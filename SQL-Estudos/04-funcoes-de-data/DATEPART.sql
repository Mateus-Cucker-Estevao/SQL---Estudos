
USE ContosoRetailDW

/*
Pedaço	Abreviação	O que devolve	Ex. em 2007-12-31 14:30:45
YEAR	yy	ano	2007
QUARTER	qq	trimestre (1 a 4)	4
MONTH	mm	mês (1 a 12)	12
DAY	dd	dia do mês	31
DAYOFYEAR	dy	dia do ano (1 a 366)	365
WEEKDAY	dw	dia da semana (número)	varia
WEEK	wk	semana do ano	53
HOUR	hh	hora	14
MINUTE	mi	minuto	30
SECOND	ss	segundo	45*/


SELECT TOP 100
	S.DateKey,
	DATEPART(YEAR, S.DateKey) AS ANO,
	DATEPART(MONTH, S.DateKey) AS MES,
	DATEPART(DAY, S.DateKey) AS DIA,
	DATEPART(DAYOFYEAR, S.DateKey) AS DIA_DO_ANO,
	DATEPART(WEEKDAY, S.DateKey) AS DIA_DA_SEMANA
FROM FactOnlineSales AS S
ORDER BY S.DateKey DESC


--FILTRANDO DADOS COM DATE PART

SELECT TOP 100
	*
FROM FactOnlineSales AS S
WHERE 
	DATEPART(DAY, S.DateKey) = 30
	AND DATEPART(MONTH, S.DateKey) = 12
	AND DATEPART(DAYOFYEAR, S.DateKey) = 365

	--PODEMOS USAR PARA FILTRAR CONFORME A TABELA ACIMA