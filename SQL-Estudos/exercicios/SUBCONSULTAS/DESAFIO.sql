

--**4.1)** Liste as lojas (`DimStore`) cujo total de vendas (`SalesAmount` em
--`FactSales`) esteja **acima da média de vendas de todas as lojas**.


USE ContosoRetailDW

SELECT
	S.StoreKey,
	DS.StoreName,
	SUM(S.SalesAmount) AS TotalVendas     --SOMANDO AS VENDAS / LOJA
FROM FactSales AS S
INNER JOIN DimStore AS DS ON DS.StoreKey = S.StoreKey               --CONECTANDO AS TABELAS
GROUP BY S.StoreKey,DS.StoreName
HAVING SUM(S.SalesAmount) > (SELECT AVG(SalesAmount) AS MEDIA FROM FactSales)           -- FILTRANDO DEPOIS DO GROUP BY


-- MEDIA DE VENDAS DE TODAS AS LOJAS
SELECT
	AVG(S.SalesAmount) AS MEDIA
FROM FactSales AS S
