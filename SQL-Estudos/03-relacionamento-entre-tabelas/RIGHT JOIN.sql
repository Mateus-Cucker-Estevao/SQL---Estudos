-- O RIGHT JOIN É APENAS O OPOSTO DO LEFT JOIN, OQUE MUDA É APENAS A POSIÇÃO DAS TABELAS NO CODIGO.


USE ContosoRetailDW

SELECT DISTINCT
	P.ProductKey,
	P.ProductName,
	S.ProductKey
FROM DimProduct AS P
LEFT JOIN FactSales AS S ON S.ProductKey = P.ProductKey
ORDER BY 3

SELECT DISTINCT
	P.ProductKey,
	P.ProductName,
	S.ProductKey
FROM DimProduct AS P
RIGHT JOIN FactSales AS S ON S.ProductKey = P.ProductKey
ORDER BY 3