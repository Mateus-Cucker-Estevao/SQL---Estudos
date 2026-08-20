
--## Exercício 1 — LEFT JOIN
--Liste **todos os produtos** (`ProductKey`, `ProductName`) e, se existir, o `SalesKey` de uma venda relacionada. 
--**Mostre também os produtos que nunca foram vendidos** (ou seja, que aparecem com `SalesKey` nulo). 
--Use `DimProduct` como tabela da esquerda.

--> 💡 Esse é o uso clássico do LEFT JOIN: descobrir o que **não tem correspondência**.


USE ContosoRetailDW

SELECT
	P.ProductKey,
	P.ProductName,
	S.SalesKey
FROM DimProduct AS P
LEFT JOIN FactSales AS S -- QUANDO USA O LEFT, PRIORIZA A TABELA DA ESQUERDA, OU SEJA - TODOS OS VALORES DA TABELA VENDAS DESSES PRODUTOS.
	ON S.ProductKey = P.ProductKey
ORDER BY S.SalesKey




--## Exercício 2 — LEFT JOIN + WHERE
--A partir do exercício 1, **filtre apenas os produtos que nunca foram vendidos** (ou seja, onde o `SalesKey` da `FactSales` é `NULL`). 
--Mostre `ProductKey` e `ProductName`. Quantos produtos aparecem?


USE ContosoRetailDW

SELECT
	P.ProductKey,
	P.ProductName,
	S.SalesKey
FROM DimProduct AS P
LEFT JOIN FactSales AS S -- QUANDO USA O LEFT, PRIORIZA A TABELA DA ESQUERDA, OU SEJA - TODOS OS VALORES DA TABELA VENDAS DESSES PRODUTOS.
	ON S.ProductKey = P.ProductKey
WHERE S.SalesKey IS NULL -- PARA FILTRAR USAR O IS NULL
ORDER BY S.SalesKey


--## Exercício 3 — RIGHT JOIN
--Reescreva a consulta abaixo usando **RIGHT JOIN** ao invés de LEFT JOIN, 
--**invertendo a ordem das tabelas** (a "do meio" deve continuar trazendo o mesmo resultado lógico):


SELECT DISTINCT
    P.ProductKey,
    P.ProductName, 
    S.SalesKey
FROM FactSales AS S
RIGHT JOIN DimProduct AS P ON S.ProductKey = P.ProductKey
WHERE S.SalesKey IS NULL                          --TRAZENDO APENAS OQUE NÃO TEM VENDA


--Confirme mentalmente: o resultado final deveria ser **idêntico** ao do LEFT JOIN original.



--## Exercício 4 — FULL JOIN
--Use **FULL JOIN** entre `DimStore` e `FactSales` para listar `StoreKey`, `StoreName` e `SalesKey`. O objetivo é identificar:
-- Lojas que existem mas **nunca tiveram venda**
-- (Hipoteticamente) vendas que não têm loja associada

--Mostre apenas as primeiras 100 linhas.

USE ContosoRetailDW


SELECT
	S.StoreKey,
	S.StoreName,
	F.SalesKey
FROM DimStore AS S
FULL JOIN FactSales AS F
	ON S.StoreKey = F.StoreKey






--## Exercício 5 — CROSS JOIN
--Use **CROSS JOIN** para gerar todas as combinações possíveis entre os canais de venda (`DimChannel`) 
--e os territórios de venda (`DimSalesTerritory`). Mostre `ChannelName` e `SalesTerritoryName`. 

--> 💡 Pense: se há 5 canais e 10 territórios, quantas linhas o resultado deve ter?



USE ContosoRetailDW

SELECT
	C.ChannelName,
	DST.SalesTerritoryName
FROM DimChannel AS C
CROSS JOIN DimSalesTerritory AS DST

-- SERVER APENAS PARA CONECTAR E MOSTRAR UMA RELAÇÃO DE TODOS OS DADOS POSSIVEIS DE UMA TABELA!




--## Exercício 6 — Múltiplos JOINs + WHERE
--Liste `SalesKey`, `SalesAmount`, `StoreName` e `SalesTerritoryName`, passando por `DimStore → DimGeography → DimSalesTerritory`. 
--Filtre apenas vendas onde o território comece com a letra **"E"** e o `SalesAmount` seja maior que **500**.


USE ContosoRetailDW
	
SELECT	
	S.SalesKey,
	S.SalesAmount,
	DS.StoreName,
	DST.SalesTerritoryName
FROM FactSales AS S
INNER JOIN DimStore AS DS ON DS.StoreKey = S.StoreKey
INNER JOIN DimGeography AS DG ON  DS.GeographyKey = DG.GeographyKey
INNER JOIN DimSalesTerritory AS DST ON DG.GeographyKey = DST.GeographyKey
WHERE DST.SalesTerritoryName LIKE 'E%'
AND S.SalesAmount > 500
ORDER BY S.SalesAmount






--## Exercício 7 — HAVING
--Mostre o `ProductKey` e a soma de `SalesQuantity` vendida, mas **apenas para vendas a partir de 2008-01-01**. 
--Traga somente os produtos cuja soma da quantidade vendida esteja **entre 2000 e 2500**. Ordene do maior para o menor.

--> 💡 Lembre: o filtro de data vai no `WHERE` (antes de agrupar) e o filtro da soma vai no `HAVING` (depois de agrupar).

USE ContosoRetailDW

SELECT
	DP.ProductKey,
	DP.ProductName,
	SUM(S.SalesQuantity) AS SOMA_QTD
FROM DimProduct AS DP
INNER JOIN FactSales AS S ON DP.ProductKey = S.ProductKey
WHERE S.DateKey >= '2008-01-01'
GROUP BY DP.ProductKey, DP.ProductName
HAVING SUM(S.SalesQuantity) BETWEEN 2000 AND 2500
ORDER BY SOMA_QTD DESC

SELECT * FROM FactSales




--## Exercício 8 — WITH ROLLUP
---Mostre a soma de `SalesAmount` agrupada por `SalesTerritoryName` e `ChannelName`, usando **WITH ROLLUP** para gerar os subtotais por território e o total geral.

--> 💡 Repare como aparecem linhas extras com `NULL` no `ChannelName` (subtotal do território) e uma linha final com tudo `NULL` (total geral).

USE ContosoRetailDW

SELECT
	DST.SalesTerritoryName,
	DC.ChannelName,
	SUM(S.SalesAmount) AS TOTAL_VENDAS
FROM FactSales AS S

-- FAZENDO AS CONEXÕES PARA PEGAR AS INFORMAÇÕES.
INNER JOIN DimChannel AS DC ON DC.ChannelKey = S.channelKey
INNER JOIN DimStore AS DS ON DS.StoreKey = S.StoreKey
INNER JOIN DimGeography AS DG ON DG.GeographyKey = DS.GeographyKey
INNER JOIN DimSalesTerritory AS DST ON DST.GeographyKey = DG.GeographyKey


GROUP BY DST.SalesTerritoryName, DC.ChannelName
WITH ROLLUP -- MOSTRA OS SUBTOTAIS E O TOTAL NO FINAL





--## Exercício 9 — LEFT JOIN + GROUP BY (combinando tudo)
--Mostre **todas as categorias de produto** (mesmo as que não tiveram vendas) junto com o total de `SalesAmount` vendido em cada uma. 
--Para categorias sem nenhuma venda, o total deve aparecer como `0` (use `ISNULL` ou `COALESCE`).

--> 💡 Esse é um exercício avançado: junta LEFT JOIN (pra não perder categoria nenhuma) + GROUP BY + tratamento de NULL.


USE ContosoRetailDW

SELECT
	PC.ProductCategoryName,
	ISNULL(SUM(S.SalesAmount), 0) AS TotalVenda
FROM DimProductCategory AS PC
INNER JOIN DimProductSubcategory AS PS ON PS.ProductCategoryKey = PC.ProductCategoryKey
INNER JOIN DimProduct AS P ON P.ProductSubcategoryKey = PS.ProductSubcategoryKey 
LEFT JOIN FactSales AS S ON S.ProductKey = P.ProductKey
GROUP BY PC.ProductCategoryName
ORDER BY TotalVenda


-- CONFIRMANDO OS PRODUTOS QUE NÃO TEM VENDA
SELECT
	P.ProductName,
	S.SalesKey
FROM DimProduct AS P
LEFT JOIN FactSales AS S ON S.ProductKey = P.ProductKey
WHERE S.SalesKey IS NULL



--## Exercício 10 — Desafio final (mistura tudo)
--Monte uma consulta que mostre, por **território de vendas** (`SalesTerritoryName`):
-- Total vendido (`SUM(SalesAmount)`)
-- Quantidade de lojas distintas que venderam (`COUNT(DISTINCT StoreKey)`)
--Use **WITH ROLLUP** para ter o total geral ao final, filtre com `HAVING` apenas territórios com total vendido maior que **1.000.000**, e ordene do maior para o menor faturamento.
--> 💡 Atenção: ao usar `HAVING` junto com `WITH ROLLUP`, a linha de total geral pode ser filtrada também — pense em como contornar isso se quiser mantê-la (dica: `GROUPING()`).



-- USANDO O BANCO
USE ContosoRetailDW

-- SELECIONANDO AS COLUNAS E GERANDO AS SOMAS E CONTAGENS
SELECT 
	ISNULL(ST.SalesTerritoryName, 'TotalGeral') AS SalesTerritoryName,
	SUM(S.SalesAmount) AS TotalVendas,
	COUNT(DISTINCT(DS.StoreKey)) AS QtdLojas
FROM DimSalesTerritory AS ST

-- FAZENDO AS CONEXÕES COM AS TABELAS
INNER JOIN DimGeography AS G ON G.GeographyKey = ST.GeographyKey
INNER JOIN DimStore AS DS ON DS.GeographyKey = G.GeographyKey
LEFT JOIN FactSales AS S ON S.StoreKey = DS.StoreKey

-- AGRUPANDO E FILTRANDO
GROUP BY ST.SalesTerritoryName
WITH ROLLUP
HAVING SUM(S.SalesAmount) > 1000000 OR GROUPING(ST.SalesTerritoryName) = 1

--ORDENANDO
ORDER BY GROUPING(ST.SalesTerritoryName), TotalVendas DESC


