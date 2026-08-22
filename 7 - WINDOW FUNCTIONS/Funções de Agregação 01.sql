

USE BikeStores


/**/

SELECT
	P.CategoryID,
	COUNT(*) AS TOTAL_PRODUTOS
FROM Production.Product AS P
GROUP BY P.CategoryID

---------------------------------------------------------------
/*SELECIOANDO CONTAGEM DE PRODUTOS POR BrandID*/

SELECT
	P.CategoryID,
	P.BrandID,
	COUNT(*) AS TOTAL_PRODUTOS
FROM Production.Product AS P
GROUP BY  P.BrandID, P.CategoryID;
---------------------------------------------------------------

/*JUNTANDO AS DUAS TABELAS PARA PODER MANUPULAR AS DUAS IDENPENDENTES*/

WITH TOTAL_POR_CATEGORIA AS 
(
	SELECT
		P.CategoryID,
		COUNT(*) AS TOTAL_PRODUTOS
	FROM Production.Product AS P
	GROUP BY P.CategoryID
)
SELECT
	P.CategoryID,
	P.BrandID,
	COUNT(*) AS TOTAL_PRODUTOS,
	TC.TOTAL_PRODUTOS,
	COUNT(*) * 100.0 / TC.TOTAL_PRODUTOS AS 'PERCENT'
FROM Production.Product AS P
INNER JOIN TOTAL_POR_CATEGORIA AS TC ON TC.CategoryID = P.CategoryID
GROUP BY  P.CategoryID,P.BrandID,TC.TOTAL_PRODUTOS