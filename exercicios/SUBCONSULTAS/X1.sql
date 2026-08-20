

--1.1) Liste todos os produtos (ProductKey, ProductName, UnitPrice) cujo preço seja maior que a média de preço de todos os produtos. (É o inverso do seu exemplo.)

USE ContosoRetailDW


-- FILTRANDO COM SUBCONSULTA
SELECT 
	ProductKey,
	ProductName,
	UnitPrice
FROM DimProduct
WHERE Unitprice > (
	SELECT
		AVG(UnitPrice) AS MEDIA
	FROM DimProduct
)
ORDER BY UnitPrice ASC


--PEGANDO A MEDIA DOS PRODUTOS
SELECT
	AVG(UnitPrice) AS MEDIA
FROM DimProduct


--1.2) Encontre o(s) produto(s) com o maior UnitPrice da tabela, usando uma subconsulta com MAX() no WHERE (sem usar TOP nem ORDER BY).

USE ContosoRetailDW

SELECT
	ProductKey,
	ProductName,
	UnitPrice
FROM DimProduct AS P

--APLICANDO A SUB NO WHERE
WHERE P.UnitPrice = (
	SELECT
		MAX(UnitPrice) AS ValorMaior
	FROM DimProduct
)



--2.1)liste os produtos cujo UnitCost seja maior que a média geral de UnitCost, trazendo também a margem (UnitPrice - UnitCost).

USE ContosoRetailDW


-- FILTRANDO JUNTO COM A SUBCONSULTA
SELECT
	ProductKey,
	ProductName,
	UnitCost,
	UnitPrice,
	(UnitPrice - UnitCost) AS Margem
FROM DimProduct
WHERE UnitCost > (
	SELECT
		AVG(UnitCost) AS Media
	FROM DimProduct
)
ORDER BY UnitCost ASC

-- ENCONTRANDO A MEDIA DE UnitCost
SELECT
	AVG(UnitCost) AS Media
FROM DimProduct



--2.2) Liste os clientes (CustomerKey, FirstName, LastName) da tabela DimCustomer que moram no mesmo país 
--(CustomerType ou GeographyKey, dependendo do seu schema) do cliente de CustomerKey = 100. Use subconsulta para descobrir o país desse cliente.

USE ContosoRetailDW

SELECT
	CustomerKey,
	FirstName,
	LastName,
	GeographyKey
FROM DimCustomer
-- FILRANDO OS DADOS QUE SÃO IGUAIS AO CLIENTE 100
WHERE GeographyKey = (
	SELECT
		GeographyKey
	FROM DimCustomer
	WHERE CustomerKey = 100
	
)
AND CustomerKey <> 100           --REOVENDO APENAS ELE DA CONSULTA

-- PEGANDO OS DADOS DO CLIENTE 100
SELECT
	CustomerType,
	GeographyKey
FROM DimCustomer AS C
WHERE CustomerKey = 100




--3.1) Usando FactSales, liste os ProductKey distintos que tiveram alguma venda registrada. 
--Depois, em DimProduct, traga só os produtos cujo ProductKey esteja IN nesse resultado (produtos que efetivamente venderam).

USE ContosoRetailDW

SELECT
	ProductKey,
	ProductName
FROM DimProduct
WHERE ProductKey IN (
	SELECT DISTINCT
		ProductKey
	FROM FactSales AS S
)
ORDER BY ProductKey




--3.2) O oposto: liste os produtos que nunca apareceram em FactSales (use NOT IN ou NOT EXISTS).

USE ContosoRetailDW

SELECT
	ProductKey,
	ProductName
FROM DimProduct
WHERE ProductKey NOT IN (
	SELECT DISTINCT
		ProductKey
	FROM FactSales AS S
)
ORDER BY ProductKey


--**E1)** Liste os produtos cujo preço esteja **acima da média** porém **abaixo
--do preço máximo** — os "caros, mas não os mais caros".

USE ContosoRetailDW

SELECT
	ProductKey,
	ProductName,
	UnitPrice
FROM DimProduct
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM DimProduct) --MEDIA
AND UnitPrice < (SELECT MAX(UnitPrice) FROM DimProduct) --VALOR MAXIMO
ORDER BY UnitPrice DESC

--**E2)** Em `FactSales`, liste as vendas (`SalesKey`, `ProductKey`,
--`SalesAmount`) cujo valor seja maior que a média de todas as vendas.

USE ContosoRetailDW

SELECT
	FS.SalesKey,
	FS.ProductKey,
	FS.SalesAmount
FROM FactSales AS FS
WHERE FS.SalesAmount > (SELECT AVG(SalesAmount) FROM FactSales) -- MEDIA
ORDER BY FS.SalesAmount 


--**E3)** Liste os produtos que pertencem à subcategoria chamada
--**'Televisions'**. Use `DimProductSubcategory` para descobrir a chave e `IN`
--para filtrar em `DimProduct`.

USE ContosoRetailDW

SELECT
	DP.ProductKey,
	DP.ProductName,
	DP.ProductSubcategoryKey
FROM DimProduct AS DP
WHERE DP.ProductSubcategoryKey IN (
	SELECT
		DPS.ProductSubcategoryKey
	FROM DimProductSubcategory AS DPS
	WHERE DPS.ProductSubcategoryName = 'Televisions'
)
ORDER BY DP.ProductName


--**E5)** Liste as lojas (`StoreKey`, `StoreName`) que tiveram **pelo menos
--uma** venda registrada em `FactSales`.

USE ContosoRetailDW

SELECT
	S.StoreKey,
	S.StoreName
FROM DimStore AS S
WHERE EXISTS (SELECT 1 FROM FactSales AS F WHERE F.StoreKey = S.StoreKey) --APENAS OQUE EM STOREKEY FOR IGUAL
ORDER BY S.StoreKey




