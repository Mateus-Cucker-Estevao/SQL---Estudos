
--**29.** Em `ContosoRetailDW.DimCustomer`, traga clientes que sejam:
-- **Mulheres** E
-- **Casadas** E
-- Tenham **renda anual maior que 60.000** E
-- Tenham **2 ou mais filhos**.
--Ordene da maior renda para a menor.

USE ContosoRetailDW

SELECT
	FirstName,
	LastName,
	Gender,
	MaritalStatus,
	YearlyIncome,
	TotalChildren
FROM 
	DimCustomer
WHERE Gender = 'F'
	AND MaritalStatus = 'M'
	AND YearlyIncome > 60000
	AND TotalChildren >= 2
ORDER BY YearlyIncome DESC

--**30.** Em `ContosoRetailDW.DimCustomer`, traga clientes que **NÃO** sejam de educação `'High School'` 
--E que tenham `NumberChildrenAtHome` **diferente de 0**.

USE ContosoRetailDW

SELECT 
	FirstName,
	LastName,
	MaritalStatus,
	Education,
	NumberChildrenAtHome
FROM 
	DimCustomer
WHERE
	NOT Education = 'High School'
	AND NumberChildrenAtHome <> 0


--**31.** Em `ContosoRetailDW.DimCustomer`, traga clientes que:
-- Tenham `Education` em `('Bachelors', 'Graduate Degree')` E
-- Tenham `TotalChildren` entre 2 e 4 E
-- **NÃO** sejam casados (use `NOT MaritalStatus = 'M'` — cuide do caso `NULL`).

USE ContosoRetailDW

SELECT 
	FirstName,
	LastName,
	Education,
	TotalChildren,
	MaritalStatus
FROM DimCustomer
WHERE
	Education IN ('Bachelors', 'Graduate Degree') --EDUCAÇÃO (BACHAREL OU GRADUAÇÃO)
	AND TotalChildren BETWEEN 2 AND 4 -- TOTAL DE FILHOS (ENTRE 2 E 4)
	AND (NOT MaritalStatus = 'M' OR MaritalStatus IS NULL) -- NÃO SÃO CASADOS

--**32.** Em `ContosoRetailDW.DimProduct`, traga produtos que:
-- Tenham `ColorName` **diferente de 'Black' e 'White'** (use `NOT IN`) E
-- `UnitPrice` entre **500 e 2000** E
-- `ProductName` **contenha 'Pro'** (LIKE).

USE ContosoRetailDW

SELECT 
	ProductKey,
	ProductDescription,
	ColorName,
	UnitPrice,
	ProductName
FROM DimProduct
WHERE
	NOT ColorName IN ('Black','White')
	AND UnitPrice BETWEEN 500 AND 2000
	AND ProductName LIKE '%Pro%'






