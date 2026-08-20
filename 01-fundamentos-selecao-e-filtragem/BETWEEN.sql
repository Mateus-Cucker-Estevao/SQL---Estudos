

USE ContosoRetailDW


SELECT
	EmailAddress,
	Gender,
	MaritalStatus,
	TotalChildren,
	NumberChildrenAtHome,
	NumberCarsOwned AS 'QTD_CARROS', 
	Education,
	BirthDate
FROM DimCustomer

WHERE 
	MaritalStatus IS NOT NULL
	AND TotalChildren BETWEEN 2 AND 4         -- BETWEEEN PARA PUXAR DADOS (DESSE ENTRE ESSE)....
	AND BirthDate BETWEEN '1950-01-01' AND '1960-01-01'
ORDER BY BirthDate DESC	
	

