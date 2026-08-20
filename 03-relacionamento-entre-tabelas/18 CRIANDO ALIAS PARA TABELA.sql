

--APLICANDO APELIDOS PARA AS TABELAS JUNTO COM O JOIN

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
FROM FactSales AS FS -- DANDO APELIDO
INNER JOIN DimChannel AS DC ON DC.ChannelKey = FS.channelKey -- DANDO APELIDO
WHERE SalesKey BETWEEN 2 AND 6
ORDER BY FS.channelKey 