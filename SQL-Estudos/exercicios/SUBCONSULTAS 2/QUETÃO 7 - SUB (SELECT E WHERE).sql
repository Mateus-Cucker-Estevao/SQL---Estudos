

/*Liste os produtos cujo UnitPrice e maior que a media de preco da propria subcategoria. (correlacionada no WHERE)*/

USE ContosoRetailDW

SELECT
	DP.ProductKey,
	DP.ProductSubcategoryKey,
	DP.UnitPrice,

	--MOSTRANDO OS VALORES DAS MEDIAS DAS SUBCAOGORIAS JUNTO
	(SELECT AVG(P.UnitPrice) AS MediaSubcategoria
	FROM DimProduct AS P
	WHERE P.ProductSubcategoryKey = DP.ProductSubcategoryKey) AS MediaSubcategoria

FROM DimProduct AS DP
--FILTRANDO APENAS OS PRODUTOS COM VALRO MAIOR QUE A MEDIA DE VENDA DA SUBCATEGORIA
WHERE DP.UnitPrice > (
	SELECT AVG(DP2.UnitPrice) AS Media
	FROM DimProduct AS DP2
	WHERE DP2.ProductSubcategoryKey = DP.ProductSubcategoryKey)
ORDER BY DP.UnitPrice DESC


--MEDIA DE CADA SUBCATEGORIA
SELECT
	DP.ProductSubcategoryKey,
	AVG(DP.UnitPrice) AS Media
FROM DimProduct AS DP
GROUP BY DP.ProductSubcategoryKey
ORDER BY DP.ProductSubcategoryKey