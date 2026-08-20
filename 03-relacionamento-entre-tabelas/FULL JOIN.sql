

-- O FULL JOIN TRAZ TANTOS OS DADOS DAS TABELAS DA ESQUERDA QUANTO DA DIREITA

USE ContosoRetailDW

SELECT DISTINCT
	P.ProductKey,
	P.ProductName,
	S.ProductKey AS 'S.ProductKey'
FROM DimProduct AS P
RIGHT JOIN FactSales AS S ON S.ProductKey = P.ProductKey
ORDER BY 3