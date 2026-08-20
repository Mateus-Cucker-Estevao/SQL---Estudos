

USE ContosoRetailDW

--FUNCÃO PARA PEGAR APENAS ALGUNS DADOS DE UM TEXTO
SELECT  
	'SQL é mais legal que power BI',
	SUBSTRING('SQL é mais legal que power BI', 22, 9),
	RIGHT('SQL é mais legal que power BI', 8) AS DIREITA, -- PEGANDO DADOS DA ESQUERDA
	LEFT('SQL é mais legal que power BI', 3) AS ESQUERDA, -- PEGANDO DADOS DA DIREITA
	LEFT(RIGHT('SQL é mais legal que power BI', 8),5) AS ESQUERDA_DA_DIREITA,
	CHARINDEX('mais', 'SQL é mais legal que power BI') AS INDICE_INICIO,
	RIGHT('SQL é mais legal que power BI', LEN('SQL é mais legal que power BI') - CHARINDEX('mais', 'SQL é mais legal que power BI')+1)