USE ContosoRetailDW

-- SELECT DA TABELA
SELECT 
	SalesAmount
FROM FactSales


-- SOMANDO A COLUNA
SELECT 
	SUM(SalesAmount) AS SOMA
FROM FactSales


-- MÉDIA
SELECT 
	AVG(SalesAmount) AS MEDIA
FROM FactSales

-- CONTAGEM
SELECT 
	COUNT(SalesAmount) AS CONTAGEM_LINHAS
FROM FactSales


-- MAXIMO
SELECT 
	MAX(SalesAmount) AS MAXIMO
FROM FactSales

-- MINIMO
SELECT 
	MIN(SalesAmount) AS MINIMO
FROM FactSales


-- CAULCULANDO A MEDIA
SELECT
	SUM(SalesAmount) / COUNT(SalesAmount) AS MEDIA_V2
FROM FactSales

