



USE ContosoRetailDW

-- USANDO UM SELECT PARA PEGAR UM RESULTADO PARA DENTRO DE UMA CONSULTA
SELECT
	COUNT(ProductKey)
FROM DimProduct
WHERE UnitPrice <= (SELECT AVG(UnitPrice) AS MEDIA FROM DimProduct) -- SUB CONSULTA



-- IN
SELECT 
	*
FROM FactSales AS S 
WHERE S.ProductKey IN (
	SELECT
		ProductKey
	FROM DimProduct
	WHERE UnitPrice <= (SELECT AVG(UnitPrice) AS MEDIA FROM DimProduct) -- SUB CONSULTA
)
ORDER BY S.UnitPrice DESC



-- NOT IN
SELECT 
	*
FROM FactSales AS S 
WHERE S.ProductKey NOT IN (
	SELECT
		ProductKey
	FROM DimProduct
	WHERE UnitPrice <= (SELECT AVG(UnitPrice) AS MEDIA FROM DimProduct) -- SUB CONSULTA
)
ORDER BY S.UnitPrice ASC