USE ContosoRetailDW


SELECT * FROM DimEmployee

-- Buscando nome completo
SELECT 
	FirstName + ' ' + LastName AS 'FullName',
	*	
FROM DimEmployee
WHERE FirstName + ' ' + LastName LIKE 'Aaron Painter'


-- Buscando nome primeiro nome
SELECT 
	FirstName + ' ' + LastName AS 'FullName',
	*	
FROM DimEmployee
WHERE FirstName + ' ' + LastName LIKE 'Aaron%'



-- Buscando qualuqer parte
SELECT 
	FirstName + ' ' + LastName AS 'FullName',
	*	
FROM DimEmployee
WHERE FirstName + ' ' + LastName LIKE '%REX%'





-- Buscando com algumas letras (Re__)
SELECT 
	FirstName + ' ' + LastName AS 'FullName',
	*	
FROM DimEmployee
WHERE FirstName + ' ' + LastName LIKE 'Re__%'





-- Buscando com algumas letras (___des)
SELECT 
	FirstName + ' ' + LastName AS 'FullName',
	*	
FROM DimEmployee
WHERE FirstName + ' ' + LastName LIKE '%___des'



-- Buscando quando não saber com que letre o nome é (podemos usar o [sd]) "DAVE"
SELECT 
	FirstName + ' ' + LastName AS 'FullName',
	*	
FROM DimEmployee
WHERE FirstName + ' ' + LastName LIKE 'Dav[ei]%'
