# 07 — Funções de Janela (Window Functions)

> 🗓️ Estudado em **Agosto/2026** · Bancos: `Chinook` e `BikeStores`

Funções de janela fazem cálculos **linha a linha, mas olhando para um conjunto de linhas**, sem "colapsar" o resultado como o `GROUP BY` faz. Aqui o foco foi criar **rankings** e **dividir dados em grupos**.

---

## 🪟 A cláusula `OVER()` — a base de tudo

É o que transforma uma função em função de janela. Ela define **como as linhas são olhadas**:

```sql
ROW_NUMBER() OVER (ORDER BY coluna ASC)
```

- A **função** (`ROW_NUMBER`, `RANK`...) diz *o que calcular*.
- `OVER(...)` define a **"janela"** — o conjunto de linhas considerado.
- `ORDER BY` **dentro** do `OVER` decide **a ordem** do cálculo (é diferente do `ORDER BY` no final da consulta, que só ordena a exibição).
- `PARTITION BY` **dentro** do `OVER` divide em grupos (opcional).

---

## 🥇 As 4 funções de ranking (o coração do módulo)

Todas usam `OVER(ORDER BY ...)`. A diferença aparece **quando há valores empatados**. Imagine 5 faixas ordenadas por preço:

| Preço | `ROW_NUMBER` | `RANK` | `DENSE_RANK` | `NTILE(2)` |
|:-----:|:---:|:---:|:---:|:---:|
| 0,99 | 1 | 1 | 1 | 1 |
| 0,99 | 2 | 1 | 1 | 1 |
| 0,99 | 3 | 1 | 1 | 1 |
| 1,99 | 4 | 4 | 2 | 2 |
| 2,99 | 5 | 5 | 3 | 2 |

Repare no comportamento de cada uma:

### `ROW_NUMBER()` — numeração pura
Numera 1, 2, 3, 4, 5... **sempre única**, mesmo em empate. Se dois valores são iguais, ele escolhe uma ordem qualquer entre eles, mas nunca repete o número.
> Uso: "dê um número de linha", pegar exatamente 1 registro por grupo.

### `RANK()` — ranking com "buracos"
Empatados recebem o **mesmo** número, mas depois **pula** as posições usadas. Veja: três "1" e o próximo é "4" (pulou o 2 e o 3).
> Uso: ranking de competição — se 3 pessoas empatam em 1º, o próximo é o 4º lugar.

### `DENSE_RANK()` — ranking sem "buracos"
Empatados recebem o **mesmo** número, mas a contagem **continua** sem pular: três "1" e o próximo é "2".
> Uso: quando você quer "níveis" de valor sem lacunas (1º nível, 2º nível, 3º nível...).

### `NTILE(n)` — divide em N grupos
Distribui as linhas em **`n` grupos** de tamanho parecido e numera os grupos de 1 a `n`. `NTILE(4)` cria **quartis**, `NTILE(100)` cria **percentis**.
> Uso: "divida meus clientes em 4 faixas de gasto", "quais os 25% mais caros".

**Resumo rápido:** `ROW_NUMBER` nunca repete · `RANK` repete e pula · `DENSE_RANK` repete e não pula · `NTILE` fatia em grupos.

---

## 🧩 `PARTITION BY` — reiniciar por grupo

Adicionado dentro do `OVER`, ele **divide os dados em grupos** e o cálculo **recomeça** em cada um. Funciona com **todas** as funções acima.

```sql
NTILE(12) OVER (PARTITION BY GenreId ORDER BY UnitPrice ASC)
```

> 👉 Isso divide as faixas em 12 grupos **dentro de cada gênero** — cada gênero é fatiado separadamente.

| Sem `PARTITION BY` | Com `PARTITION BY` |
|---|---|
| Calcula sobre a tabela inteira. | Reinicia o cálculo a cada grupo. |
| Ranking/divisão geral. | Ranking/divisão **por categoria**. |

---

## 🎯 O pulo do gato: filtrar o ranking (função de janela + CTE)

Funções de janela **não podem ser usadas direto no `WHERE`** (ele roda antes de a numeração existir). A solução é colocar a consulta dentro de uma **CTE** (ou subconsulta) e filtrar do lado de fora:

```sql
WITH ANALISE_FAIXAS AS
(
    SELECT
        Composer, Name, Milliseconds,
        ROW_NUMBER() OVER (PARTITION BY Composer ORDER BY Milliseconds DESC) AS RN
    FROM Track
    WHERE Composer IS NOT NULL
)
SELECT *
FROM ANALISE_FAIXAS
WHERE RN = 1;   -- só a faixa mais longa de cada compositor
```

Padrão muito comum:
- `WHERE RN = 1` → o "top 1" de cada grupo.
- `WHERE RN <= 3` → o "top 3" de cada grupo.

> 💡 Dá pra colocar **mais de uma coluna** no `ORDER BY` de dentro do `OVER()` pra desempatar. Ex.: `ORDER BY UnitPrice DESC, Name ASC` (maior preço; empate, ordem alfabética).

---

## 🔗 CTEs encadeadas (duas CTEs numa consulta só)

No exercício 6 apareceu um padrão poderoso: **encadear CTEs**, separando por vírgula. Uma prepara os dados para a outra.

```sql
WITH GASTO_POR_CLIENTE AS (
    -- 1ª etapa: junta as tabelas e SOMA o gasto por cliente
    SELECT C.CustomerId, C.Country, SUM(I.InvoiceTotal) AS TOTAL_GASTO
    FROM Customer AS C
    INNER JOIN Invoice AS I ON I.CustomerId = C.CustomerId
    GROUP BY C.CustomerId, C.Country
),
RANKING_PAIS AS (
    -- 2ª etapa: rankeia em cima do total JÁ somado
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Country ORDER BY TOTAL_GASTO DESC) AS POSICAO_NO_PAIS
    FROM GASTO_POR_CLIENTE
)
-- 3ª etapa: filtra e ordena
SELECT * FROM RANKING_PAIS
WHERE POSICAO_NO_PAIS <= 2
ORDER BY Country ASC, POSICAO_NO_PAIS ASC;
```

> 🧠 A lógica é montar em **camadas**: primeiro somar (agregação), depois rankear sobre o resultado, depois filtrar. Cada CTE resolve **uma** etapa — muito mais legível do que empilhar subconsultas.

---

## 📊 Bônus: percentual com CTE de agregação (`BikeStores`)

Também apareceu um caso clássico de negócio: **quanto cada marca representa dentro da sua categoria**. O truque é usar uma CTE para guardar o total da categoria e depois dividir:

```sql
WITH TOTAL_POR_CATEGORIA AS (
    SELECT CategoryID, COUNT(*) AS TOTAL_PRODUTOS
    FROM Production.Product
    GROUP BY CategoryID
)
SELECT
    P.CategoryID, P.BrandID,
    COUNT(*) AS TOTAL_PRODUTOS,
    COUNT(*) * 100.0 / TC.TOTAL_PRODUTOS AS 'PERCENT'   -- % da marca na categoria
FROM Production.Product AS P
INNER JOIN TOTAL_POR_CATEGORIA AS TC ON TC.CategoryID = P.CategoryID
GROUP BY P.CategoryID, P.BrandID, TC.TOTAL_PRODUTOS;
```

> ⚠️ **Detalhe importante:** multiplicar por `100.0` (e não `100`) força o cálculo a ser **decimal**. Se usar `100` inteiro, o SQL faz divisão inteira e o percentual sai arredondado/errado.

---

## 📂 Scripts deste módulo

- **`ROW_NUMBER.sql`** — numeração simples da tabela toda.
- **`PARTITION_BY.sql`** — numeração reiniciando por compositor.
- **`RANK_e_DENSE_RANK.sql`** — comparação lado a lado de `ROW_NUMBER` × `RANK` × `DENSE_RANK`.
- **`NTILE.sql`** — dividindo a tabela em grupos (geral e por gênero com `PARTITION BY`).
- **`EXERCICIOS.sql`** — 6 desafios resolvidos, incluindo:
  1. Ranking simples por tamanho (bytes).
  2. Posição dentro de cada gênero.
  3. A faixa mais longa de cada compositor (`WHERE RN = 1`).
  4. Top 3 faixas mais caras de cada álbum (`WHERE RN <= 3`, com desempate).
  5. A maior compra de cada cliente.
  6. **Top 2 de gasto por país** — usando **duas CTEs encadeadas** (somar → rankear → filtrar).

> 🔗 Este módulo junta tudo que veio antes: agregação ([02](../02-agrupando-informacoes/)), JOINs ([03](../03-relacionamento-entre-tabelas/)) e CTE ([06](../06-cte-common-table-expression/)). É a base das análises de "top N por categoria" do dia a dia de dados.
