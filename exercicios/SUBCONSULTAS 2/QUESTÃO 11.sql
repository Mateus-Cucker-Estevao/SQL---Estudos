/*Cada categoria (Electronics, Books, Home) tem vários produtos. Alguns venderam muita quantidade, outros pouca. 
Quero saber, dentro de cada categoria, qual foi o produto que mais vendeu em quantidade — o campeão de cada uma. 
No fim, uma linha por categoria: a categoria, o nome do produto campeão e a quantidade dele.*/


USE ContosoRetailDW

SELECT
	T.ProductCategoryName,
	T.ProductName,
	T.QtdVendida
FROM 
	(SELECT
		PC.ProductCategoryName,
		P.ProductName,
		SUM(S.SalesQuantity) AS QtdVendida
	FROM FactSales AS S
	INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
	INNER JOIN DimProductSubcategory AS PS ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
	INNER JOIN DimProductCategory AS PC ON PC.ProductCategoryKey = PS.ProductCategoryKey
	GROUP BY PC.ProductCategoryName, P.ProductName
) AS T
WHERE T.QtdVendida = (
	SELECT
		MAX(T2.QtdVendida)
	FROM 
	(SELECT
		PC.ProductCategoryName,
		P.ProductName,
		SUM(S.SalesQuantity) AS QtdVendida
	FROM FactSales AS S
	INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
	INNER JOIN DimProductSubcategory AS PS ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
	INNER JOIN DimProductCategory AS PC ON PC.ProductCategoryKey = PS.ProductCategoryKey
	GROUP BY PC.ProductCategoryName, P.ProductName)	AS T2
	WHERE T.ProductCategoryName = T2.ProductCategoryName)

--TABELA RESUMO DOS PRODUTOS / CATEGORIA MAIS VENDIDOS
SELECT
	PC.ProductCategoryName,
	P.ProductName,
	SUM(S.SalesQuantity) AS QtdVendida
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS PS ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC ON PC.ProductCategoryKey = PS.ProductCategoryKey
GROUP BY PC.ProductCategoryName, P.ProductName
ORDER BY PC.ProductCategoryName, QtdVendida DESC
