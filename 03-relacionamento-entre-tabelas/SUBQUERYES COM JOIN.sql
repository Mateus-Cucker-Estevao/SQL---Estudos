



USE ContosoRetailDW


-- USANDO UMA TABELA IDENTRO DE UM INNER JOIN

SELECT
	S2.*
FROM FactSales S2
INNER JOIN (
	SELECT TOP 5
	S.ProductKey,
	SUM(SalesAmount) AS Sales
	FROM FactSales S 
	GROUP BY S.ProductKey
	ORDER BY Sales DESC	
) AS TOP5 ON TOP5.ProductKey = S2.ProductKey



--VALIDAÇÃO TOP5, PEGANDO APENAS A CONTAGEM DISTINTA DOS PRODUTOS PARA VALIDAR

SELECT
	DISTINCT(VAL.ProductKey)
FROM (
	SELECT
		S2.*
	FROM FactSales S2
	INNER JOIN (
		SELECT TOP 5
		S.ProductKey,
		SUM(SalesAmount) AS Sales
		FROM FactSales S 
		GROUP BY S.ProductKey
		ORDER BY Sales DESC	
	) AS TOP5 ON TOP5.ProductKey = S2.ProductKey
) AS VAL