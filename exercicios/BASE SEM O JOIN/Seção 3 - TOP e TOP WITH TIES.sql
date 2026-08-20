--**11.** Em `ContosoRetailDW.DimCustomer`, traga os **10 clientes com a maior renda anual** (`YearlyIncome`). 
--Mostre nome, sobrenome e renda.

USE ContosoRetailDW

SELECT TOP (10)
	FirstName,
	LastName,
	YearlyIncome
FROM Dimcustomer
ORDER BY YearlyIncome DESC


--**12.** Em `ContosoRetailDW.DimProduct`, traga os **5 produtos mais baratos** 
--(`UnitPrice`). Mostre `ProductName`, `BrandName` e `UnitPrice`.

USE ContosoRetailDW

SELECT TOP (5)
	ProductName,
	BrandName,
	UnitPrice
FROM DimProduct
ORDER BY UnitPrice ASC



--**13.** Refaça o exercício 11 usando `TOP 10 WITH TIES`. Observe se aparecem mais que 10 linhas (quando há empate no último valor).


	USE ContosoRetailDW

	SELECT TOP (10) WITH TIES
		FirstName,
		LastName,
		YearlyIncome
	FROM Dimcustomer
	WHERE FirstName IS NOT NULL --REMOVENDO OS CLIENTES COM NOMES VAZIOS
	ORDER BY YearlyIncome DESC


--**14.** Em `AdventureWorksDW2025.DimEmployee`, traga os **3 funcionários com maior 
--`BaseRate`** com `WITH TIES`. Mostre nome, sobrenome, cargo (`Title`) e `BaseRate`.

USE AdventureWorksDW2025

SELECT TOP (3) WITH TIES
	FirstName,
	LastName,
	Title,
	BaseRate
FROM DimEmployee
ORDER BY BaseRate DESC
	