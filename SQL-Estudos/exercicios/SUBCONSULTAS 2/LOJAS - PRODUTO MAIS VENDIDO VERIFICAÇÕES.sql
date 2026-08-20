

USE ContosoRetailDW

/*QUAL PORDUTO QUE MAIS VENDEU POR LOJA,
NOME DA LOJA, NOME DO PRODUTO, VALOR VENDIDO DELE E QUANTAS VENDAS TEVE
ORGANIZE DO MAIOR VALOR VENDIDO PARA O MENOR*/


SELECT
	T.StoreName,
	T.ProductName,
	T.Valor_Vendido,
	T.Qtd_Vendida,
	(SELECT
		COUNT(DISTINCT(T3.StoreName))
	FROM (SELECT
			P.ProductName,
			ST.StoreName,
			SUM(S.SalesAmount) AS Valor_Vendido,
			COUNT(*) AS Qtd_Vendida
		FROM FactSales AS S
		INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
		INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
		GROUP BY P.ProductName, ST.StoreName) AS T3
		WHERE T3.ProductName = T.ProductName)AS Qtd_Lojas
FROM
	(SELECT
		ST.StoreName,
		P.ProductName,
		SUM(S.SalesAmount) AS Valor_Vendido,
		COUNT(*) AS Qtd_Vendida
	FROM FactSales AS S
	INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
	INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
	GROUP BY ST.StoreName, P.ProductName) AS T
WHERE T.Valor_Vendido = (
	SELECT
		MAX(T2.Valor_Vendido)
	FROM
		(SELECT
			ST.StoreName,
			P.ProductName,
			SUM(S.SalesAmount) AS Valor_Vendido,
			COUNT(*) AS Qtd_Vendida
		FROM FactSales AS S
		INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
		INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
		GROUP BY ST.StoreName, P.ProductName) AS T2
		WHERE T.StoreName = T2.StoreName
)
ORDER BY T.Valor_Vendido DESC

-- VERIFICAÇÃO DE QUANTAS LOJAS VENDERAM O PRODUTO 'Proseware Projector 1080p LCD86 White' '551', PARA PODER CONFIRMAR A TABELA QUE APARECER

SELECT
	P.ProductName,
	COUNT(DISTINCT(S.StoreKey)) AS Qtd_Loja
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
WHERE S.ProductKey = 551
GROUP BY P.ProductName

--TABELA COM OS VALORES DE VENDA E QUANTIDADE DE CADA PRODUTO EM CADA LOJA
SELECT
	ST.StoreName,
	P.ProductName,
	SUM(S.SalesAmount) AS Valor_Vendido,
	COUNT(S.SalesAmount) AS Qtd_Vendida
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
GROUP BY ST.StoreName, P.ProductName




