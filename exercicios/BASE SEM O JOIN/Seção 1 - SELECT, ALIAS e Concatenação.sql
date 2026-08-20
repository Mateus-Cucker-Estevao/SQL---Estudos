--**1.** No banco `ContosoRetailDW`, traga **todas as colunas** da tabela `DimProduct`.

USE ContosoRetailDW

SELECT * FROM DimProduct

--**2.** Ainda em `DimProduct`, traga apenas as colunas `ProductName`, `BrandName`, `ColorName` e `UnitPrice`.

USE ContosoRetailDW

SELECT
	ProductName,
	BrandName,
	ColorName,
	UnitPrice
FROM DimProduct

--**3.** Na tabela `DimStore`, traga `StoreName`, `EmployeeCount` e `Status`, 
--mas renomeie as colunas para `LOJA`, `QTD_FUNCIONARIOS` e `SITUACAO`.

USE ContosoRetailDW

SELECT
	StoreName AS LOJA,
	EmployeeCount AS QTD_FUNCIONARIOS,
	Status AS SITUACAO
FROM DimStore


--**4.** Na `DimEmployee`, crie uma coluna chamada `NOME_COMPLETO` 
--concatenando `FirstName + ' ' + LastName`. Traga também `Title` e `HireDate`.

USE ContosoRetailDW

SELECT 
	FirstName + ' ' + LastName AS NOME_COMPLETO,
	Title,
	HireDate
FROM DimEmployee



-- **5.** Em `AdventureWorksDW2025`, na `DimCustomer`, crie uma coluna `IDENTIFICACAO` concatenando ]
--`FirstName + ' ' + MiddleName + ' ' + LastName`. Traga junto `EmailAddress` e `Gender`.
-- 💡 Cuidado: se `MiddleName` for `NULL`, o resultado fica `NULL`. Você vai observar isso na prática — 
--depois aprende a tratar, por enquanto só observe.

USE AdventureWorksDW2025

SELECT
	FirstName + ' ' + MiddleName + ' ' + LastName AS IDENTIFICACAO,
	EmailAddress,
	Gender
FROM DimCustomer
