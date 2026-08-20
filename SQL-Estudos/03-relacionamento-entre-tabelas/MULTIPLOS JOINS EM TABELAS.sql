
-- CRIANDO INNER DENTRO DE INNER... 
-- PARA PODER PUXAR OS DADOS DE UMA TABELA COM OUTRA TEMOS QUE USAR AS CHAVES PARA RELACIONAR AS TABELAS E PEGAR OS DADOS
-- MELHOR USAR O DIAGRAMA PARA VISUALIZAR O RELACIONAMENTO ENTRE AS TABELAS.


USE ContosoRetailDW

SELECT TOP(100)
	S.SalesKey,
	S.SalesAmount,
	S.ProductKey,
	P.ProductName,
	P.ProductSubcategoryKey,
	SC.ProductSubcategoryName,
	PC.ProductCategoryName
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC ON PC.ProductCategoryKey = SC.ProductCategoryKey