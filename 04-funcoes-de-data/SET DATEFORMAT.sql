

USE ContosoRetailDW

/*
PODEMOS SETAR A FORMA QUE O FILTRA VAI LER OS DADOS DE DATA
ISSO PODE SER USADO COOM QUISER CONFORME A TABELA ABAIXO

mdy	mês-dia-ano	'12-31-2007'
dmy	dia-mês-ano	'31-12-2007'
ymd	ano-mês-dia	'2007-12-31'
ydm	ano-dia-mês	'2007-31-12'
myd	mês-ano-dia	'12-2007-31'
dym	dia-ano-mês	'31-2007-12'
*/

SET DATEFORMAT YMD

SELECT DISTINCT
	S.DateKey
FROM FactOnlineSales S 
WHERE S.DateKey BETWEEN '2007-12-01' AND '2007-12-31'
ORDER BY S.DateKey DESC

