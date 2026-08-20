

USE ContosoRetailDW

-- FILTRANDO APENAS AS PRIMEIRAS 1000 LINHAS

SELECT TOP 100
	EmailAddress,
	Gender,
	MaritalStatus,
	TotalChildren,
	NumberChildrenAtHome,
	NumberCarsOwned AS 'QTD_CARROS',
	Education
FROM DimCustomer
ORDER BY 2 DESC, 3 DESC,4 DESC, [QTD_CARROS] DESC

