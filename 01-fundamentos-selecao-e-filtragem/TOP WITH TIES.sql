

USE ContosoRetailDW

-- FILTRANDO APENAS AS PRIMEIRAS 1000 LINHAS
-- E TBM COM OS QUE NO FINAL ESTIVEREM EMPATADSO NÃO SÓ APENAS OS 100 FILTRADOS

SELECT TOP 100 WITH TIES
	EmailAddress,
	Gender,
	MaritalStatus,
	TotalChildren,
	NumberChildrenAtHome,
	NumberCarsOwned AS 'QTD_CARROS',
	Education
FROM DimCustomer
ORDER BY 2 DESC, 3 DESC,4 DESC, [QTD_CARROS] DESC

