


-- AGRUPANDO VALORES DE UMA COLUNA

-- SEMPRE QUE USAR COLUNAS PARA AGREGAÇÃO ELAS TEM QUE APARECER NO GROUPBY
USE ContosoRetailDW

SELECT 
	S.channelKey,
	DC.ChannelName,
	S.PromotionKey,  
	P.PromotionName,
	SUM(S.SalesAmount) AS SOMA,
	AVG(S.SalesAmount) AS MEDIA,
	MIN(S.SalesAmount) AS MINIMO,
	MAX(S.SalesAmount) AS MAXIMO,
	COUNT(S.SalesAmount) AS CONTAGEM_LINHAS
FROM FactSales AS S
INNER JOIN DimChannel AS DC
	ON	DC.ChannelKey = S.channelKey
INNER JOIN DimPromotion AS P
	ON P.PromotionKey = S.PromotionKey
WHERE 
	S.channelKey IN (1,2) AND
	S.PromotionKey BETWEEN 1 AND 5
GROUP BY 
	S.channelKey,
	DC.ChannelName, 
	S.PromotionKey,
	P.PromotionName-- INSERINDO AS COLUNAS NO GROUP BY
ORDER BY S.channelKey, S.PromotionKey

