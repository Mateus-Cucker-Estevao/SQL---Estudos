--**15.** Em `ContosoRetailDW.DimCustomer`, traga apenas os clientes **do gênero masculino** (`Gender = 'M'`).

USE ContosoRetailDW

SELECT 
	*
FROM DimCustomer
WHERE Gender = 'M'

--**16.** Em `ContosoRetailDW.DimProduct`, traga apenas os produtos cujo `UnitPrice` seja **maior que 1000**.

USE ContosoRetailDW

SELECT
	*
FROM DimProduct
WHERE UnitPrice > 1000

--**17.** Em `ContosoRetailDW.DimStore`, traga apenas as lojas com **mais de 30 funcionários** (`EmployeeCount > 30`).

USE ContosoRetailDW

SELECT 
	* 
FROM DimStore
WHERE EmployeeCount > 30

--**18.** Em `AdventureWorksDW2025.DimCustomer`, traga apenas os clientes cuja `YearlyIncome` seja **menor ou igual a 30000**.


USE AdventureWorksDW2025

SELECT 
	* 
FROM DimCustomer
WHERE YearlyIncome <= 30000
