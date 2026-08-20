# 📅 2026-08-19 — SQL: CTEs, Variáveis e Funções de Texto

> Registro de estudos (TIL — *Today I Learned*). Banco usado nos exemplos: **ContosoRetailDW** (SQL Server / T-SQL).

**O que aprendi hoje:**
- [CTE (Common Table Expression)](#1-cte--common-table-expression)
- [Declarando variáveis](#2-declarando-variáveis)
- [Concatenar textos](#3-concatenar-textos)
- [Funções básicas de texto](#4-funções-básicas-de-texto)
- [Extração de partes de uma string](#5-extração-de-partes-de-uma-string)
- [Substituição de texto](#6-substituição-de-texto)

---

## 1. CTE — Common Table Expression

**O que é:** uma CTE é uma "tabela temporária" com nome, que existe **só durante a execução da consulta**. Serve pra deixar consultas complexas mais organizadas e legíveis, evitando subconsultas aninhadas e confusas. Ela começa com `WITH`.

```sql
USE ContosoRetailDW;

/* CRIANDO UMA CTE: uma "tabela" com os dados que vamos utilizar */
WITH ANALISE_PRODUTO (ANO, MES, ID_PRODUTO, NOME_PRODUTO, QTDE)
AS
(
    SELECT
        DATEPART(YEAR, S.DateKey)  AS ANO,
        DATEPART(MONTH, S.DateKey) AS MES,
        S.ProductKey               AS ID_PRODUTO,
        P.ProductName              AS NOME_PRODUTO,
        SUM(S.SalesQuantity)       AS QTDE
    FROM FactSales AS S
    INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
    GROUP BY
        DATEPART(YEAR, S.DateKey),
        DATEPART(MONTH, S.DateKey),
        S.ProductKey,
        P.ProductName
)
SELECT AVG(QTDE)
FROM ANALISE_PRODUTO;
```

**Resuminho:**
- `WITH NOME (colunas) AS ( ... )` → define a CTE e os nomes das colunas dela.
- Dentro do parêntese vai um `SELECT` normal — aqui eu agrupei as vendas por **ano, mês e produto** e somei a quantidade (`SUM`).
- Depois de fechar a CTE, eu faço um `SELECT` **em cima dela**, como se fosse uma tabela de verdade. No exemplo, tirei a **média** da quantidade.
- `DATEPART(YEAR, ...)` e `DATEPART(MONTH, ...)` extraem o ano/mês de uma data.

**Reaproveitando a mesma CTE de outro jeito** — dá pra fazer `JOIN` e ordenar os TOP 10:

```sql
WITH ANALISE_PRODUTO (ANO, MES, ID_PRODUTO, NOME_PRODUTO, QTDE)
AS
(
    SELECT
        DATEPART(YEAR, S.DateKey)  AS ANO,
        DATEPART(MONTH, S.DateKey) AS MES,
        S.ProductKey               AS ID_PRODUTO,
        P.ProductName              AS NOME_PRODUTO,
        SUM(S.SalesQuantity)       AS QTDE
    FROM FactSales AS S
    INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
    GROUP BY
        DATEPART(YEAR, S.DateKey),
        DATEPART(MONTH, S.DateKey),
        S.ProductKey,
        P.ProductName
)
SELECT TOP 10
    A.*,
    P.*
FROM ANALISE_PRODUTO AS A
INNER JOIN DimProduct AS P ON P.ProductKey = A.ID_PRODUTO
ORDER BY QTDE DESC;
```

> 💡 **Dica:** a CTE precisa vir **imediatamente antes** do `SELECT` que a usa. Se tiver outro comando no meio, o SQL "esquece" que ela existe.

---

## 2. Declarando Variáveis

**O que é:** uma variável guarda uma informação num "espacinho" da memória pra reutilizar na consulta (filtros, parâmetros etc.). Em T-SQL toda variável começa com **`@`** e precisa ter um **tipo de dado** definido.

```sql
USE ContosoRetailDW;

-- GUARDAR INFORMAÇÕES EM UM ESPAÇO
-- Precisa informar o TIPO de dado e usar @ na frente
DECLARE @USUARIO VARCHAR(30);
SET @USUARIO = ' ROBERTO CARLOS ';

SELECT @USUARIO AS NAME;
```

**Usando variável como filtro:**

```sql
-- DEFININDO A VARIAVEL
DECLARE @PROD INT;

-- COLOCANDO INFORMAÇÃO NELA
SET @PROD = 782;

-- FILTRANDO DADOS USANDO ELA
SELECT TOP 100 *
FROM FactOnlineSales
WHERE ProductKey = @PROD;
```

**Resuminho:**
- `DECLARE @nome TIPO;` → cria a variável (ex.: `VARCHAR(30)` pra texto, `INT` pra número inteiro).
- `SET @nome = valor;` → coloca um valor dentro dela.
- Depois é só usar `@nome` em qualquer lugar da consulta — inclusive no `WHERE`.
- **Vantagem:** se você precisa trocar o produto filtrado, muda só o `SET` em vez de caçar o número no meio da query.

---

## 3. Concatenar Textos

**O que é:** juntar dois ou mais textos num só. Dá pra fazer com o operador `+` ou com a função `CONCAT()`.

```sql
USE ContosoRetailDW;

DECLARE @USER  VARCHAR(30) = ' Maria Maria ';
DECLARE @USER2 VARCHAR(30) = ' Joao Joao ';

-- Usando o operador +
SELECT @USER + @USER2 AS NAMES;

-- Usando a função CONCAT
SELECT CONCAT('MATEUS ', @USER2, 'CUCKER', @USER);
```

**Resuminho:**
- `+` junta textos, mas tem uma pegadinha: **se qualquer valor for `NULL`, o resultado inteiro vira `NULL`**.
- `CONCAT(...)` é mais seguro: ele trata `NULL` como texto vazio e **não quebra** o resultado. Também aceita vários valores separados por vírgula.
- 👉 Na dúvida, prefira `CONCAT()`.

---

## 4. Funções Básicas de Texto

**O que é:** funções pra medir, limpar espaços e mudar maiúsculas/minúsculas de um texto.

```sql
USE ContosoRetailDW;

DECLARE @USER VARCHAR(30) = ' Maria Maria ';

SELECT
    @USER                    AS NAME,
    LEN(@USER)               AS TAMANHO,                  -- conta caracteres
    LTRIM(@USER)             AS SEM_ESPACO_ESQUERDA,      -- remove espaço à esquerda
    RTRIM(@USER)             AS SEM_ESPACO_DIREITA,       -- remove espaço à direita
    TRIM(@USER)              AS SEM_ESPACOS,              -- remove os dois lados
    UPPER(@USER)             AS MAIUSCULO,                -- tudo MAIÚSCULO
    UPPER(TRIM(@USER))       AS MAIUSCULO_SEM_ESPACO,     -- combinando funções
    LOWER(TRIM(@USER))       AS MINUSCULO_SEM_ESPACO;     -- tudo minúsculo
```

**Resuminho:**

| Função | O que faz |
|--------|-----------|
| `LEN()`   | Conta os caracteres. ⚠️ Ignora os espaços **à direita**, mas conta os **à esquerda**. |
| `LTRIM()` | Remove espaços da **esquerda** (*Left*). |
| `RTRIM()` | Remove espaços da **direita** (*Right*). |
| `TRIM()`  | Remove espaços dos **dois lados** de uma vez. |
| `UPPER()` | Deixa tudo **MAIÚSCULO**. |
| `LOWER()` | Deixa tudo **minúsculo**. |

> 💡 Dá pra **encaixar uma função dentro da outra** (ex.: `UPPER(TRIM(@USER))` → tira os espaços **e** deixa maiúsculo). O SQL resolve de dentro pra fora.

---

## 5. Extração de Partes de uma String

**O que é:** funções pra "recortar" pedaços específicos de um texto.

```sql
USE ContosoRetailDW;

SELECT
    'SQL é mais legal que power BI',
    SUBSTRING('SQL é mais legal que power BI', 22, 9)      AS PEDACO_DO_MEIO,
    RIGHT('SQL é mais legal que power BI', 8)              AS DIREITA,
    LEFT('SQL é mais legal que power BI', 3)               AS ESQUERDA,
    LEFT(RIGHT('SQL é mais legal que power BI', 8), 5)     AS ESQUERDA_DA_DIREITA,
    CHARINDEX('mais', 'SQL é mais legal que power BI')     AS INDICE_INICIO,
    RIGHT(
        'SQL é mais legal que power BI',
        LEN('SQL é mais legal que power BI') - CHARINDEX('mais', 'SQL é mais legal que power BI') + 1
    ) AS A_PARTIR_DE_MAIS;
```

**Resuminho:**
- `SUBSTRING(texto, início, quantidade)` → pega um pedaço **do meio**. Começa na posição indicada e pega X caracteres.
- `LEFT(texto, n)` → pega os **primeiros** `n` caracteres (começa pela **esquerda**).
- `RIGHT(texto, n)` → pega os **últimos** `n` caracteres (começa pela **direita**).
- `CHARINDEX('pedaço', texto)` → devolve a **posição** (número) onde o pedaço começa. Útil pra achar onde algo aparece.
- Dá pra **combinar**: `LEFT(RIGHT(...))` pega um trecho a partir do fim e depois recorta de novo pela esquerda.

> ⚠️ **Correção importante (peguei um errinho de comentário nas anotações):**
> - `LEFT` = pega da **ESQUERDA** (início do texto).
> - `RIGHT` = pega da **DIREITA** (final do texto).
> No arquivo original os comentários estavam trocados. Fica a atenção pra não confundir depois! 😉

---

## 6. Substituição de Texto

**O que é:** trocar um pedaço do texto por outro usando `REPLACE()`.

```sql
USE ContosoRetailDW;

SELECT
    'SQL para analise de dados',
    REPLACE('SQL para analise de dados', 'analise', 'ANALISE')        AS TROCANDO_PALAVRA,
    REPLACE(TRIM('SQL para analise de dados'), ' de dados', '')       AS REMOVENDO_TRECHO;
```

**Resuminho:**
- `REPLACE(texto, 'procurar', 'substituir')` → troca **todas** as ocorrências de um trecho por outro.
- Truque útil: se você colocar `''` (texto vazio) no lugar do substituto, o `REPLACE` **remove** aquele trecho.
- Dá pra combinar com `TRIM()` pra limpar espaços antes de trocar.

---

### ✅ Resumo do dia

Hoje eu aprendi a organizar consultas com **CTEs**, a guardar valores em **variáveis** (`DECLARE`/`SET`) e a manipular texto com um monte de funções: **concatenar** (`+`, `CONCAT`), **limpar e formatar** (`LEN`, `TRIM`, `UPPER`, `LOWER`), **recortar** (`SUBSTRING`, `LEFT`, `RIGHT`, `CHARINDEX`) e **substituir** (`REPLACE`).

**Próximo passo:** praticar combinando essas funções em consultas reais do ContosoRetailDW. 🚀
