

USE ContosoRetailDW

SELECT * FROM DimChannel

SELECT TOP (1000)
	SalesKey,
	DateKey,
	FS.channelKey,
	DC.ChannelLabel,
	DC.ChannelName,
	DC.ChannelDescription,
	DC.ETLLoadID,
	DC.LoadDate,
	DC.UpdateDate
FROM FactSales AS FS  --DEFININDO O APELIDO NO FROM
INNER JOIN DimChannel AS DC ON DC.ChannelKey = FS.channelKey  -- DEFININDO O APELIDO NO JOIN
WHERE SalesKey BETWEEN 2 AND 6
ORDER BY FS.channelKey 