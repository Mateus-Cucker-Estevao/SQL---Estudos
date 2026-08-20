--**24.** Em `ContosoRetailDW.DimEmployee`, traga todos cujo `FirstName` **comece com a letra 'M'**.

USE ContosoRetailDW

SELECT * FROM DimEmployee
WHERE FirstName LIKE 'M%'

--**25.** Em `ContosoRetailDW.DimEmployee`, traga todos cujo `LastName` **termine com 'son'** (ex.: Anderson, Johnson…).

USE ContosoRetailDW

SELECT * FROM DimEmployee
WHERE LastName LIKE '%son'

--**26.** Em `ContosoRetailDW.DimProduct`, traga produtos cujo `ProductName` **contenha a palavra 'Bike'** em qualquer posição.

USE ContosoRetailDW

SELECT * FROM DimProduct
WHERE ProductName LIKE '%Bike%'

--**27.** Em `ContosoRetailDW.DimEmployee`, traga funcionários cujo `FirstName` tenha **exatamente 4 letras** e comece com 'J'.
--> 💡 Dica: use o curinga `_` para representar uma única letra.

USE ContosoRetailDW

SELECT * FROM DimEmployee
WHERE FirstName LIKE 'J___' --1 caractere obrigatório. `'J___'` = J + 3 caracteres = total 4 letras.


--**28.** Em `ContosoRetailDW.DimEmployee`, traga funcionários cujo `FirstName` comece com **'C' ou 'S'**, usando colchetes `[ ]`.

USE ContosoRetailDW

SELECT * FROM DimEmployee
WHERE FirstName LIKE '[CS]%' --PODE COLOCAR AS DUAS LETRAS JUNTAS [CS]
ORDER BY FirstName 