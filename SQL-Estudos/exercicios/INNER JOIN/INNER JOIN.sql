

--### Exercício 1
--Liste o `SalesKey`, `SalesAmount` e o `ProductName` de cada venda. Traga apenas os 100 primeiros registros.

USE ContosoRetailDW

SELECT TOP(100)
	S.SalesKey,
	S.ProductKey,
	S.SalesAmount,
	P.ProductName AS 'P.ProductName'
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey

--------------------------------------------------------------------------------------------------------------


--### Exercício 2
--Mostre o `SalesKey`, `SalesAmount` e o `ChannelName` (nome do canal de venda) de cada venda. Use **aliases** nas tabelas (`FS` e `DC`).

USE ContosoRetailDW

SELECT TOP(100)
	FS.Saleskey,
	FS.SalesAmount,
	FS.channelKey,
	DC.ChannelName AS 'DC.ChannelName'
FROM FactSales  AS FS
INNER JOIN DimChannel AS DC ON DC.ChannelKey = FS.channelKey
ORDER BY FS.SalesKey DESC


--------------------------------------------------------------------------------------------------------------


--### Exercício 3
--Liste todas as vendas (`SalesKey`, `SalesQuantity`, `SalesAmount`) junto com o nome da loja 
--(`StoreName`) da tabela `DimStore`. Limite a 50 linhas.

USE ContosoRetailDW

SELECT TOP(50)
	FS.SalesKey,
	FS.SalesQuantity,
	FS.SalesAmount,
	DS.StoreName
FROM FactSales AS FS
INNER JOIN DimStore AS DS ON DS.StoreKey = FS.StoreKey

--------------------------------------------------------------------------------------------------------------


--### Exercício 4
--Mostre o nome do produto (`ProductName`) e o nome da subcategoria (`ProductSubcategoryName`) a que ele pertence. 
--Ordene por subcategoria.

USE ContosoRetailDW

SELECT 
	DP.ProductName,
	DP.ProductSubcategoryKey,
	DPS.ProductSubcategoryName
FROM DimProduct AS DP                            -- DANDO APELIDO A TABELA PRINCIPAL
INNER JOIN DimProductSubcategory AS DPS          -- DANDO APELIDO A TEBELA DE INFORMAÇÕES
	ON DPS.ProductSubcategoryKey = DP.ProductSubcategoryKey        -- CONECTANDO AS COLUNAS CHAVES
ORDER BY DPS.ProductSubcategoryName



--------------------------------------------------------------------------------------------------------------


--### Exercício 5
--Liste todos os produtos com sua marca (`BrandName`) e o nome da categoria (`ProductCategoryName`). 
--*(Dica: você vai precisar passar por `DimProductSubcategory` no meio do caminho — pense bem se 2 JOINs resolvem.)*

USE ContosoRetailDW

SELECT
	DP.ProductName,
	DP.BrandName,
	DPS.ProductCategoryKey,
	DPC.ProductCategoryName
FROM DimProduct AS DP
INNER JOIN DimProductSubcategory AS DPS                       
	ON DPS.ProductSubcategoryKey = DP.ProductSubcategoryKey        -- CONECTANDO A PRIEMIRA TABELA "DimProductSubcategory"
INNER JOIN DimProductCategory AS DPC 
	ON DPS.ProductCategoryKey = DPC.ProductCategoryKey             -- CONECTANDO A SEGUNDA TABELA "ProductCategoryKey"


--------------------------------------------------------------------------------------------------------------


--### Exercício 6
--Mostre o total de `SalesAmount` por canal de venda (`ChannelName`). Ordene do maior para o menor.

USE ContosoRetailDW

SELECT
	S.channelKey,
	DC.ChannelName,
	SUM(S.SalesAmount) AS SOMA
FROM FactSales AS S
INNER JOIN DimChannel AS DC 
	ON DC.ChannelKey = S.channelKey
GROUP BY 
	S.channelKey, DC.ChannelName
ORDER BY SOMA DESC


--------------------------------------------------------------------------------------------------------------


--### Exercício 7
--Liste os 10 produtos mais vendidos em **quantidade** (`SalesQuantity`). Mostre `ProductName` e a soma total da quantidade.

USE ContosoRetailDW

SELECT TOP(10)
	S.ProductKey,
	DC.ProductName,
	SUM(S.SalesQuantity) AS TOTAL_QUANTIDADE
FROM FactSales AS S
INNER JOIN DimProduct AS DC
	ON DC.ProductKey =  S.ProductKey
GROUP BY S.ProductKey, DC.ProductName
ORDER BY TOTAL_QUANTIDADE DESC

--------------------------------------------------------------------------------------------------------------


--### Exercício 8
--Mostre o valor total vendido (`SalesAmount`) por **categoria de produto** (`ProductCategoryName`). Ordene do maior para o menor.

USE ContosoRetailDW

SELECT
	DPC.ProductCategoryName,
	SUM(SalesAmount) AS TOTAL_VENDAS
FROM FactSales AS S
INNER JOIN DimProduct AS DC
	ON DC.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS DPS
	ON DPS.ProductSubcategoryKey = DC.ProductSubcategoryKey
INNER JOIN DimProductCategory AS DPC
	ON DPC.ProductCategoryKey = DPS.ProductCategoryKey
GROUP BY DPC.ProductCategoryName
ORDER BY TOTAL_VENDAS DESC

--------------------------------------------------------------------------------------------------------------


--### Exercício 9
--Mostre quantas vendas (contagem de `SalesKey`) foram feitas em cada loja (`StoreName`). Traga só lojas com mais de 1000 vendas.

USE ContosoRetailDW

SELECT
	DS.StoreName,
	COUNT(S.SalesKey) AS CONTAGEM_VENDAS
FROM FactSales AS S
INNER JOIN DimStore AS DS
	ON DS.StoreKey = S.StoreKey
GROUP BY DS.StoreName
HAVING COUNT(S.SalesKey) > 1000
ORDER BY CONTAGEM_VENDAS DESC

--------------------------------------------------------------------------------------------------------------

--### Exercício 10
--Liste o `ProductName`, `BrandName` e a soma do `SalesAmount`, 
--**apenas para produtos da marca "Contoso"**. Ordene do maior para o menor faturamento.

USE ContosoRetailDW

SELECT
	PD.ProductName,
	PD.BrandName,
	SUM(S.SalesAmount) AS TOTAL_VENDAS
FROM FactSales AS S
INNER JOIN DimProduct AS PD
	ON PD.ProductKey = S.ProductKey
WHERE BrandName LIKE 'Contoso'
GROUP BY PD.ProductName, PD.BrandName
ORDER BY TOTAL_VENDAS DESC

--------------------------------------------------------------------------------------------------------------


--### Exercício 11
--Mostre, para cada venda (top 100), as seguintes colunas:
-- `SalesKey`
-- `SalesAmount`
-- `ProductName`
-- `ProductSubcategoryName`
-- `ProductCategoryName`
-- `ChannelName`
-- `StoreName`

USE ContosoRetailDW

SELECT
	FS.SalesKey,
	FS.SalesAmount,
	DP.ProductName,
	DPS.ProductSubcategoryName,
	DPC.ProductCategoryName,
	DC.ChannelName,
	DS.StoreName
FROM FactSales AS FS
INNER JOIN DimProduct AS DP                   --CONECTANDO A TABELA DE PRODUTOS
	ON DP.ProductKey = FS.ProductKey
INNER JOIN DimProductSubcategory AS DPS       -- CONECTANDO A TABELA SUBCATEGORIA 
	ON DPS.ProductSubcategoryKey = DP.ProductSubcategoryKey
INNER JOIN DimProductCategory AS DPC          -- CONECTANDO A TABELA CATEGORIA 
	ON DPC.ProductCategoryKey = DPS.ProductCategoryKey
INNER JOIN DimChannel AS DC                                     -- CONECTANDO A TABELA CANAIS 
	ON DC.ChannelKey = FS.channelKey
INNER JOIN DimStore AS DS                        -- CONECTANDO A TABELA LOJAS         
	ON DS.StoreKey = FS.StoreKey


--------------------------------------------------------------------------------------------------------------


--### Exercício 12
--Calcule o total de `SalesAmount` por **categoria** e **canal**, mostrando as colunas `ProductCategoryName`, 
--`ChannelName` e o total. Ordene por categoria e depois por canal.

USE ContosoRetailDW

SELECT
	DPC.ProductCategoryName,
	DC.ChannelName,
	SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimChannel AS DC
	ON DC.ChannelKey = S.channelKey
INNER JOIN DimProduct AS DP
	ON DP.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS DPS
	ON DPS.ProductSubcategoryKey = DP.ProductSubcategoryKey
INNER JOIN DimProductCategory AS DPC
	ON DPC.ProductCategoryKey = DPS.ProductCategoryKey
GROUP BY DPC.ProductCategoryName, DC.ChannelName 
ORDER BY DPC.ProductCategoryName, DC.ChannelName

--------------------------------------------------------------------------------------------------------------

--### Exercício 13
--Liste o **top 5 de subcategorias** com maior valor vendido. Mostre `ProductCategoryName`, `ProductSubcategoryName` 
--e o total de `SalesAmount`.

USE ContosoRetailDW

--SELECIONANDO A CALCULANDO O TOTAL
SELECT TOP(5)
  PC.ProductCategoryName,
  PS.ProductSubcategoryName,
  SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S

--CONECTANDO AS TABELAS
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS PS ON PS.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC ON PC.ProductCategoryKey = PS.ProductCategoryKey

--AGRUPANDO OS DADOS
GROUP BY PC.ProductCategoryName, PS.ProductSubcategoryName
ORDER BY TotalVendas DESC

