# Exercícios — Parte 2: Todos os JOINs, HAVING e WITH ROLLUP

Agora que você já dominou bem o **INNER JOIN**, esta lista mistura **todos os tipos de JOIN** e os outros recursos que apareceram no seu material: `LEFT`, `RIGHT`, `FULL`, `CROSS`, múltiplos JOINs com `WHERE`, `HAVING` e `WITH ROLLUP`.

```sql
USE ContosoRetailDW
GO
```

> 🧠 Antes de começar, lembre rapidinho a diferença de cada um:
> - **INNER JOIN** → só o que existe nas duas tabelas
> - **LEFT JOIN** → tudo da tabela da esquerda + o que casar da direita (NULL se não casar)
> - **RIGHT JOIN** → o oposto do LEFT (tudo da direita + o que casar da esquerda)
> - **FULL JOIN** → tudo das duas tabelas, casando o que der
> - **CROSS JOIN** → todos contra todos (produto cartesiano)
> - **HAVING** → filtra depois do `GROUP BY` (em cima de agregações)
> - **WITH ROLLUP** → adiciona linhas de subtotal/total no resultado agrupado

---

## Exercício 1 — LEFT JOIN
Liste **todos os produtos** (`ProductKey`, `ProductName`) e, se existir, o `SalesKey` de uma venda relacionada. **Mostre também os produtos que nunca foram vendidos** (ou seja, que aparecem com `SalesKey` nulo). Use `DimProduct` como tabela da esquerda.

> 💡 Esse é o uso clássico do LEFT JOIN: descobrir o que **não tem correspondência**.

---

## Exercício 2 — LEFT JOIN + WHERE
A partir do exercício 1, **filtre apenas os produtos que nunca foram vendidos** (ou seja, onde o `SalesKey` da `FactSales` é `NULL`). Mostre `ProductKey` e `ProductName`. Quantos produtos aparecem?

---

## Exercício 3 — RIGHT JOIN
Reescreva a consulta abaixo usando **RIGHT JOIN** ao invés de LEFT JOIN, **invertendo a ordem das tabelas** (a "do meio" deve continuar trazendo o mesmo resultado lógico):

```sql
SELECT DISTINCT
    P.ProductKey,
    P.ProductName,
    S.SalesKey
FROM DimProduct AS P
LEFT JOIN FactSales AS S ON S.ProductKey = P.ProductKey
```

Confirme mentalmente: o resultado final deveria ser **idêntico** ao do LEFT JOIN original.

---

## Exercício 4 — FULL JOIN
Use **FULL JOIN** entre `DimStore` e `FactSales` para listar `StoreKey`, `StoreName` e `SalesKey`. O objetivo é identificar:
- Lojas que existem mas **nunca tiveram venda**
- (Hipoteticamente) vendas que não têm loja associada

Mostre apenas as primeiras 100 linhas.

---

## Exercício 5 — CROSS JOIN
Use **CROSS JOIN** para gerar todas as combinações possíveis entre os canais de venda (`DimChannel`) e os territórios de venda (`DimSalesTerritory`). Mostre `ChannelName` e `SalesTerritoryName`. 

> 💡 Pense: se há 5 canais e 10 territórios, quantas linhas o resultado deve ter?

---

## Exercício 6 — Múltiplos JOINs + WHERE
Liste `SalesKey`, `SalesAmount`, `StoreName` e `SalesTerritoryName`, passando por `DimStore → DimGeography → DimSalesTerritory`. Filtre apenas vendas onde o território comece com a letra **"E"** e o `SalesAmount` seja maior que **500**.

---

## Exercício 7 — HAVING
Mostre o `ProductKey` e a soma de `SalesQuantity` vendida, mas **apenas para vendas a partir de 2008-01-01**. Traga somente os produtos cuja soma da quantidade vendida esteja **entre 2000 e 2500**. Ordene do maior para o menor.

> 💡 Lembre: o filtro de data vai no `WHERE` (antes de agrupar) e o filtro da soma vai no `HAVING` (depois de agrupar).

---

## Exercício 8 — WITH ROLLUP
Mostre a soma de `SalesAmount` agrupada por `SalesTerritoryName` e `ChannelName`, usando **WITH ROLLUP** para gerar os subtotais por território e o total geral.

> 💡 Repare como aparecem linhas extras com `NULL` no `ChannelName` (subtotal do território) e uma linha final com tudo `NULL` (total geral).

---

## Exercício 9 — LEFT JOIN + GROUP BY (combinando tudo)
Mostre **todas as categorias de produto** (mesmo as que não tiveram vendas) junto com o total de `SalesAmount` vendido em cada uma. Para categorias sem nenhuma venda, o total deve aparecer como `0` (use `ISNULL` ou `COALESCE`).

> 💡 Esse é um exercício avançado: junta LEFT JOIN (pra não perder categoria nenhuma) + GROUP BY + tratamento de NULL.

---

## Exercício 10 — Desafio final (mistura tudo)
Monte uma consulta que mostre, por **território de vendas** (`SalesTerritoryName`):
- Total vendido (`SUM(SalesAmount)`)
- Quantidade de lojas distintas que venderam (`COUNT(DISTINCT StoreKey)`)

Use **WITH ROLLUP** para ter o total geral ao final, filtre com `HAVING` apenas territórios com total vendido maior que **1.000.000**, e ordene do maior para o menor faturamento.

> 💡 Atenção: ao usar `HAVING` junto com `WITH ROLLUP`, a linha de total geral pode ser filtrada também — pense em como contornar isso se quiser mantê-la (dica: `GROUPING()`).

---

# ✅ Gabarito

### Exercício 1
```sql
SELECT DISTINCT
    P.ProductKey,
    P.ProductName,
    S.SalesKey
FROM DimProduct AS P
LEFT JOIN FactSales AS S ON S.ProductKey = P.ProductKey
```

### Exercício 2
```sql
SELECT DISTINCT
    P.ProductKey,
    P.ProductName
FROM DimProduct AS P
LEFT JOIN FactSales AS S ON S.ProductKey = P.ProductKey
WHERE S.SalesKey IS NULL
```

### Exercício 3
```sql
SELECT DISTINCT
    P.ProductKey,
    P.ProductName,
    S.SalesKey
FROM FactSales AS S
RIGHT JOIN DimProduct AS P ON S.ProductKey = P.ProductKey
```
> Quando você inverte para RIGHT JOIN, a tabela que "manda" (a que traz tudo, mesmo sem correspondência) passa a ser a do **lado direito** — por isso `DimProduct` precisa estar depois do `RIGHT JOIN`.

### Exercício 4
```sql
SELECT TOP (100)
    DS.StoreKey,
    DS.StoreName,
    S.SalesKey
FROM DimStore AS DS
FULL JOIN FactSales AS S ON S.StoreKey = DS.StoreKey
```

### Exercício 5
```sql
SELECT
    DC.ChannelName,
    DST.SalesTerritoryName
FROM DimChannel AS DC
CROSS JOIN DimSalesTerritory AS DST
```

### Exercício 6
```sql
SELECT
    S.SalesKey,
    S.SalesAmount,
    DS.StoreName,
    DST.SalesTerritoryName
FROM FactSales AS S
INNER JOIN DimStore AS DS ON DS.StoreKey = S.StoreKey
INNER JOIN DimGeography AS DG ON DG.GeographyKey = DS.GeographyKey
INNER JOIN DimSalesTerritory AS DST ON DST.GeographyKey = DG.GeographyKey
WHERE DST.SalesTerritoryName LIKE 'E%'
AND S.SalesAmount > 500
```

### Exercício 7
```sql
SELECT
    S.ProductKey,
    SUM(S.SalesQuantity) AS SomaQuantidade
FROM FactSales AS S
WHERE S.DateKey >= '2008-01-01'
GROUP BY S.ProductKey
HAVING SUM(S.SalesQuantity) BETWEEN 2000 AND 2500
ORDER BY SomaQuantidade DESC
```

### Exercício 8
```sql
SELECT
    DST.SalesTerritoryName,
    DC.ChannelName,
    SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimStore AS DS ON DS.StoreKey = S.StoreKey
INNER JOIN DimGeography AS DG ON DG.GeographyKey = DS.GeographyKey
INNER JOIN DimSalesTerritory AS DST ON DST.GeographyKey = DG.GeographyKey
INNER JOIN DimChannel AS DC ON DC.ChannelKey = S.channelKey
GROUP BY DST.SalesTerritoryName, DC.ChannelName
WITH ROLLUP
```

### Exercício 9
```sql
SELECT
    PC.ProductCategoryName,
    ISNULL(SUM(S.SalesAmount), 0) AS TotalVendas
FROM DimProductCategory AS PC
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductCategoryKey = PC.ProductCategoryKey
INNER JOIN DimProduct AS P 
    ON P.ProductSubcategoryKey = SC.ProductSubcategoryKey
LEFT JOIN FactSales AS S 
    ON S.ProductKey = P.ProductKey
GROUP BY PC.ProductCategoryName
ORDER BY TotalVendas DESC
```
> Note que a cadeia de produto inteira (`DimProductCategory → DimProductSubcategory → DimProduct`) precisa ser com **INNER JOIN** (porque essas tabelas sempre têm correspondência entre si), e só o último salto para `FactSales` é **LEFT JOIN** — é ali que pode não existir venda.

### Exercício 10
```sql
SELECT
    DST.SalesTerritoryName,
    SUM(S.SalesAmount) AS TotalVendas,
    COUNT(DISTINCT S.StoreKey) AS QtdLojas
FROM FactSales AS S
INNER JOIN DimStore AS DS ON DS.StoreKey = S.StoreKey
INNER JOIN DimGeography AS DG ON DG.GeographyKey = DS.GeographyKey
INNER JOIN DimSalesTerritory AS DST ON DST.GeographyKey = DG.GeographyKey
GROUP BY DST.SalesTerritoryName
WITH ROLLUP
HAVING SUM(S.SalesAmount) > 1000000 OR GROUPING(DST.SalesTerritoryName) = 1
ORDER BY TotalVendas DESC
```
> O `GROUPING(DST.SalesTerritoryName) = 1` é o "pulo do gato": ele identifica a linha de **total geral** gerada pelo `WITH ROLLUP` (onde a coluna fica `NULL` por ser subtotal) e garante que ela não seja descartada pelo `HAVING`.

---

# 💡 Resumo mental dos conceitos novos

| Recurso | Quando usar |
|---|---|
| `LEFT JOIN` | Quando quero **tudo da tabela principal**, mesmo sem correspondência (ex: produtos sem venda) |
| `RIGHT JOIN` | Igual ao LEFT, só que priorizando a tabela da direita |
| `FULL JOIN` | Quando quero **tudo das duas tabelas**, casando o que der |
| `CROSS JOIN` | Combinação total entre duas tabelas (raro no dia a dia) |
| `WHERE` + JOIN | Filtra linhas **antes** de qualquer agrupamento |
| `HAVING` | Filtra **depois** do `GROUP BY`, em cima de agregações (`SUM`, `COUNT`...) |
| `WITH ROLLUP` | Adiciona subtotais e total geral automaticamente ao agrupamento |
| `GROUPING()` | Identifica se uma linha é subtotal/total gerado pelo ROLLUP |

Bons estudos! Se travar em algum, manda sua tentativa que eu reviso. 🚀
