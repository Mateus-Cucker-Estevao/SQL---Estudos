/*Para cada país (RegionCountryName), descubra qual foi a loja (StoreName) com o maior faturamento total (SUM(SalesAmount)).
No fim: uma linha por país, com o país, o nome da loja campeã e o faturamento dela.*/


USE ContosoRetailDW


SELECT
	T.RegionCountryName,
	T.StoreName,
	T.TotalVenda,
	--CONTAGEM DE LOJAS NO PAIS
	(SELECT
		COUNT(DISTINCT(ST.StoreName))
	FROM DimStore AS ST
	INNER JOIN DimGeography AS G ON G.GeographyKey = ST.GeographyKey
	WHERE T.RegionCountryName = G.RegionCountryName) AS LojasPais
FROM 
--TABELA QUE VAI APARCER NA TELA AS INFORMAÇÕES
	(SELECT
		DG.RegionCountryName,
		ST.StoreName,
		SUM(S.SalesAmount) AS TotalVenda
	FROM FactSales AS S
	INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
	INNER JOIN DimGeography AS DG ON DG.GeographyKey = ST.GeographyKey
	GROUP BY DG.RegionCountryName, ST.StoreName) AS T
--FILTRANDO APENAS OS VALORES QUE VAI APARECER
WHERE T.TotalVenda = (
	SELECT
		MAX(T2.TotalVenda)
	FROM
	--USANDO A TEBELA DE RESUMO PARA PEGAR O MAXIMO VALOR POR REGIÃO E PODER FILTRAR
		(SELECT
			DG.RegionCountryName,
			ST.StoreName,
			SUM(S.SalesAmount) AS TotalVenda
		FROM FactSales AS S
		INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
		INNER JOIN DimGeography AS DG ON DG.GeographyKey = ST.GeographyKey
		GROUP BY DG.RegionCountryName, ST.StoreName) AS T2
	--RELACIONANDO AS REGIÕES PARA PEGAR O PRODUTO DE CADA UMA
	WHERE T.RegionCountryName = T2.RegionCountryName)
ORDER BY T.RegionCountryName, T.StoreName


--VERIFICAR QUANTAS RegionCountryName TEM
SELECT
	COUNT(DISTINCT(G.RegionCountryName)) AS Contagem
FROM DimGeography AS G
WHERE G.RegionCountryName IS NOT NULL


--TABELA DE RESUMO
SELECT
	DG.RegionCountryName,
	ST.StoreName,
	SUM(S.SalesAmount) AS TotalVenda
FROM FactSales AS S
INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
INNER JOIN DimGeography AS DG ON DG.GeographyKey = ST.GeographyKey
GROUP BY DG.RegionCountryName, ST.StoreName
ORDER BY DG.RegionCountryName, TotalVenda DESC
