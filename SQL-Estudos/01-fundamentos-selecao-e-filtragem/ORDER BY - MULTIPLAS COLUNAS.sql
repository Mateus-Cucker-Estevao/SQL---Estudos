


USE ContosoRetailDW

-- USANDO ORDER BY PARA ORDENAR, COM (ASC OU DESC) COM MAIS COLUNAS

SELECT 
	* 
FROM DimCustomer
ORDER BY Gender DESC, MaritalStatus DESC, TotalChildren DESC, NumberChildrenAtHome ASC
	