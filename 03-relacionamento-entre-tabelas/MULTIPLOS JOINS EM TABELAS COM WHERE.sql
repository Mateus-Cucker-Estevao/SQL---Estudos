
-- INNER DENTRO DE INNER COM WHERE JUNTO

USE ContosoRetailDW

SELECT 
	S.SalesKey,
	S.SalesAmount,
	DS.StoreName,
	DG.ContinentName,
	DST.SalesTerritoryName
FROM FactSales AS S
INNER JOIN DimStore AS DS
	ON DS.StoreKey = S.StoreKey
INNER JOIN DimGeography AS DG
	ON DG.GeographyKey = DS.GeographyKey
INNER JOIN DimSalesTerritory AS DST
	ON DST.GeographyKey = DG.GeographyKey
WHERE DST.SalesTerritoryName LIKE 'G%'
AND S.SalesKey BETWEEN 35 AND 500    
ORDER BY S.SalesKey
