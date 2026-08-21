# 07 — Funções de Janela: ROW_NUMBER e PARTITION BY

> 🗓️ Estudado em **Agosto/2026** · Banco: `Chinook`

Funções de janela (*window functions*) fazem cálculos **linha a linha, mas olhando para um conjunto de linhas**, sem "colapsar" o resultado como o `GROUP BY` faz. Aqui o foco foi criar **rankings** com `ROW_NUMBER()`.

---

## 🪟 A cláusula `OVER()`

É o que transforma uma função em função de janela. Ela define **como as linhas são olhadas**:

```sql
ROW_NUMBER() OVER (ORDER BY coluna ASC)
```

- `ROW_NUMBER()` → numera as linhas: 1, 2, 3, 4... (ótimo pra criar **ranking**).
- `OVER(...)` → define a "janela" sobre a qual a numeração acontece.
- `ORDER BY` dentro do `OVER` → decide **a ordem** da numeração (não confundir com o `ORDER BY` do final da consulta).

## 🧩 `PARTITION BY` — reiniciar a contagem por grupo

O `PARTITION BY` **divide os dados em grupos** e a numeração **recomeça do 1** em cada grupo.

```sql
ROW_NUMBER() OVER (PARTITION BY Composer ORDER BY Milliseconds DESC)
```

> 👉 Isso numera as faixas **dentro de cada compositor**, da mais longa para a mais curta. Cada compositor tem sua própria faixa nº 1, nº 2, etc.

| Sem `PARTITION BY` | Com `PARTITION BY` |
|---|---|
| Numera a tabela inteira de 1 até o fim. | Reinicia a numeração a cada grupo. |
| Ranking geral. | Ranking **por categoria**. |

## 🎯 O pulo do gato: filtrar o ranking (ROW_NUMBER + CTE)

`ROW_NUMBER()` **não pode ser usado direto no `WHERE`** (o `WHERE` roda antes da numeração existir). A solução é colocar a consulta dentro de uma **CTE** (ou subconsulta) e filtrar do lado de fora:

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

Esse padrão é **muito comum**:
- `WHERE RN = 1` → o "top 1" de cada grupo (maior compra de cada cliente, faixa mais longa de cada compositor...).
- `WHERE RN <= 3` → o "top 3" de cada grupo.

> 💡 Dá pra colocar **mais de uma coluna** no `ORDER BY` de dentro do `OVER()` pra desempatar. Ex.: `ORDER BY UnitPrice DESC, Name ASC` (maior preço; empate, ordem alfabética).

---

## 📂 Scripts deste módulo

- **`ROW_NUMBER.sql`** — ranking simples numerando a tabela toda.
- **`PARTITION_BY.sql`** — ranking reiniciando a contagem por compositor.
- **`EXERCICIOS.sql`** — 5 desafios resolvidos combinando `ROW_NUMBER` + `PARTITION BY` + `CTE`:
  1. Ranking simples por tamanho (bytes).
  2. Posição dentro de cada gênero.
  3. A faixa mais longa de cada compositor (`WHERE RN = 1`).
  4. Top 3 faixas mais caras de cada álbum (`WHERE RN <= 3`, com desempate).
  5. A maior compra de cada cliente.

> 🔗 Repare como este módulo **junta** o que você viu antes: agregação/ranking + a [CTE do módulo 06](../06-cte-common-table-expression/). É a base pra análises de "top N por categoria".
