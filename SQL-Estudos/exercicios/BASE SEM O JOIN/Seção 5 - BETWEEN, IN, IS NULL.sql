--**19.** Em `ContosoRetailDW.DimCustomer`, traga clientes nascidos entre **01/01/1970 e 31/12/1980**.

USE ContosoRetailDW

SELECT 
	* 
FROM DimCustomer
WHERE BirthDate BETWEEN '01-01-1970' AND '31-12-1980'
ORDER BY BirthDate DESC 


--**20.** Em `ContosoRetailDW.DimCustomer`, traga clientes com `TotalChildren` **entre 1 e 3**.

USE ContosoRetailDW

SELECT * FROM Dimcustomer
WHERE TotalChildren BETWEEN 1 AND 3

--**21.** Em `ContosoRetailDW.DimProduct`, traga produtos cuja `ColorName` seja **'Red', 'Blue' ou 'Green'**.

USE ContosoRetailDW

SELECT 
	* 
FROM DimProduct
WHERE 
	ColorName IN ('Red','Blue','Green')
ORDER BY ColorName



--**22.** Em `ContosoRetailDW.DimCustomer`, traga clientes cujo `Education` seja **'Bachelors' ou '
--Graduate Degree'** E que tenham `MaritalStatus` preenchido (não nulo).

USE ContosoRetailDW

SELECT 
	* 
FROM DimCustomer
WHERE 
	Education IN ('Bachelors','Graduate Degree')
	AND MaritalStatus IS NOT NULL

--**23.** Em `ContosoRetailDW.DimCustomer`, traga clientes cujo `MaritalStatus` **seja NULL** (sem estado civil informado).

USE ContosoRetailDW

SELECT
	*
FROM DimCustomer
WHERE MaritalStatus IS NULL -- NUNCA ESCREVER MaritalStatus = NULL
