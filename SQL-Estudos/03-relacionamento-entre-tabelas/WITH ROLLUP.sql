



--WITH ROLLUP, USA PARA CRIAR UM SUBTOTAL PARA O AGRUPAMENTO, PARA ANALISES RAPIDAS 

USE ContosoRetailDW

SELECT
	G.RegionCountryName
	,ST.StoreName
	,SUM(S.SalesQuantity) AS SomaQuantidade
FROM FactSales AS S 
INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
INNER JOIN DimGeography AS G ON G.GeographyKey = ST.GeographyKey
GROUP BY G.RegionCountryName, ST.StoreName
WITH ROLLUP