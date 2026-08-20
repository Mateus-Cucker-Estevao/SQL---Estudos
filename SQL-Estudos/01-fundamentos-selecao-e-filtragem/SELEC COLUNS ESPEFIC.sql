USE ContosoRetailDW

SELECT * FROM FactSales

SELECT 
	SalesKey,
	ProductKey,
	UnitCost,
	UnitPrice,
	SalesQuantity,
	TotalCost,
	SalesAmount
FROM FactSales