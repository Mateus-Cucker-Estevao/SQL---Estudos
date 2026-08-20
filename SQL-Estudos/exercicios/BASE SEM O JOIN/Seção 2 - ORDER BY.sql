--**6.** Em `ContosoRetailDW`, traga todos os clientes de `DimCustomer` ordenados por `BirthDate` do **mais velho para o mais novo**.

USE ContosoRetailDW

SELECT
	*
FROM DimCustomer
ORDER BY BirthDate ASC


--**7.** Em `DimProduct` (`ContosoRetailDW`), liste todos os produtos ordenados pelo `UnitPrice` do **mais caro para o mais barato**.

USE ContosoRetailDW

SELECT * FROM DimProduct
ORDER BY UnitPrice DESC


--**8.** Em `DimCustomer` (`ContosoRetailDW`), traga `FirstName`, `LastName`, `Gender`, `MaritalStatus` e `YearlyIncome`, ordenando por:
-- `Gender` crescente
-- depois `MaritalStatus` crescente
-- depois `YearlyIncome` decrescente

USE ContosoRetailDW

SELECT
	FirstName,
	LastName,
	Gender,
	MaritalStatus,
	YearlyIncome
FROM DimCustomer
ORDER BY Gender ASC,MaritalStatus ASC, YearlyIncome DESC

--**9.** Refaça o exercício 8, mas dessa vez ordene **pela posição** das colunas no `SELECT`, não pelos nomes.

USE ContosoRetailDW

SELECT
	FirstName,
	LastName,
	Gender,
	MaritalStatus,
	YearlyIncome
FROM DimCustomer
ORDER BY 3 ASC, 4 ASC, 5 DESC

--**10.** Refaça o exercício 8, mas dessa vez ordene **pelo apelido (alias)** 
-- coloque `YearlyIncome` como `RENDA_ANUAL` e ordene por `RENDA_ANUAL DESC`

USE ContosoRetailDW

SELECT
	FirstName,
	LastName,
	Gender,
	MaritalStatus,
	YearlyIncome AS RENDA_ANUAL
FROM DimCustomer
ORDER BY Gender ASC,MaritalStatus ASC, [RENDA_ANUAL] DESC
