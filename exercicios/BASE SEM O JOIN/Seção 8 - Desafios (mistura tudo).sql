
--**33.** Em `ContosoRetailDW.DimCustomer`, monte uma consulta que mostre:
--- Coluna `NOME_COMPLETO` com `FirstName + ' ' + LastName`
--- `BirthDate` como `DATA_NASCIMENTO`
--- `YearlyIncome` como `RENDA`
--- `Education` como `ESCOLARIDADE`

--Filtros:
--- Nascidos entre 1960 e 1985
-- Renda anual entre 40.000 e 90.000
-- Escolaridade em `('Bachelors','Graduate Degree','High School')`
-- `MaritalStatus` **não pode ser NULL**
--Ordene pela `RENDA` decrescente e traga apenas os **TOP 50 WITH TIES**.

USE ContosoRetailDW

SELECT TOP (50) WITH TIES
	FirstName + ' ' + LastName AS NOME_COMPLETO,
	BirthDate AS DATA_NASCIMENTO,
	YearlyIncome AS RENDA,
	Education AS ESCOLARIDADE,
	MaritalStatus
FROM 
	DimCustomer
WHERE
	BirthDate BETWEEN '1960-01-01' AND '1985-12-31'
	AND YearlyIncome BETWEEN 40000 AND 90000
	AND Education IN ('Bachelors','Graduate Degree','High School')
	AND MaritalStatus IS NOT NULL
ORDER BY 
	YearlyIncome DESC


--**34.** Em `ContosoRetailDW.DimEmployee`, traga os **20 primeiros funcionários** (use `TOP`) cujo:
-- `FirstName` comece com qualquer letra de 'A' até 'M' (use `LIKE '[A-M]%'`)
-- `Title` contenha a palavra **'Manager'**
-- `HireDate` seja anterior a `'2005-01-01'`
--Ordene por `HireDate` crescente.

USE ContosoRetailDW

SELECT TOP (20)
	FirstName,
	Title,
	HireDate
FROM DimEmployee
WHERE 
	FirstName LIKE '[A-M]%' -- PODE USAR (-) PARA DIZER O INTERVALO DAS LETRAS
	AND Title LIKE '%Manager%'
	AND HireDate < '2005-01-01'
ORDER BY HireDate ASC

--**35.** Em `AdventureWorksDW2025.DimProduct`, traga produtos onde:
-- `Color` esteja em `('Red','Black','Silver','Blue')`
-- `ListPrice` entre 100 e 1500
-- `ProductLine` **NÃO seja NULL**
--Mostre `EnglishProductName`, `Color`, `ListPrice` e `ProductLine`. Ordene por `Color` ASC e 
--dentro de cada cor, do mais caro para o mais barato.

USE AdventureWorksDW2025

SELECT 
	EnglishProductName,
	Color,
	ListPrice,
	ProductLine
FROM DimProduct
WHERE
	Color IN ('Red','Black','Silver','Blue')
	AND ListPrice BETWEEN 100 AND 1500
	AND ProductLine IS NOT NULL
ORDER BY Color, ListPrice DESC

