

USE ContosoRetailDW

-- SUBSTITUIR TEXTOS COM FUNÇÃO
 
SELECT
	'SQL para analise de dados',
	REPLACE('SQL para analise de dados', 'analise', 'ANALISE'), -- MUDANDO APENAS UMA PARTE DOS DADOS
	REPLACE(TRIM('SQL para analise de dados'), ' de dados', '')
	