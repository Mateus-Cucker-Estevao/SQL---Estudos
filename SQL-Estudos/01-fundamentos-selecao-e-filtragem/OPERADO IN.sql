

USE ContosoRetailDW

-- FILTRANDO APENAS AS PRIMEIRAS 1000 LINHAS
-- E TBM COM OS QUE NO FINAL ESTIVEREM EMPATADOS NÃO SÓ APENAS OS 100 FILTRADOS

SELECT
	EmailAddress,
	Gender,
	MaritalStatus,
	TotalChildren,
	NumberChildrenAtHome,
	NumberCarsOwned AS 'QTD_CARROS', -- DANDO NOME A UMA COLUNA
	Education
FROM DimCustomer

WHERE 
	Education IN ('Bachelors', 'Graduate Degree') 
	AND NumberChildrenAtHome >= 1
	AND NOT MaritalStatus = 'M'
	AND TotalChildren IN (3,4) -- (IN) PODE SER USADAO COMO UMA LISTA "OU 3 OU 4"
