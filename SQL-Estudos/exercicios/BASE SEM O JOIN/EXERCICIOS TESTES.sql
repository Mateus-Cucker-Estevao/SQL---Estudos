
--1. SELECT básico (todas as colunas)
--Mostre todas as colunas e todas as linhas da tabela DimProduct.

USE AdventureWorksDW2025

SELECT * FROM DimProduct


--2. SELECT de colunas específicas
--Da tabela DimCustomer, traga apenas: FirstName, LastName, BirthDate, Gender e EmailAddress.

SELECT
	FirstName,
	LastName,
	BirthDate,
	Gender,
	EmailAddress
FROM DimCustomer

--3. ALIAS (apelidos)
--Da tabela DimEmployee, traga FirstName, LastName, HireDate e BaseRate, 
--mas renomeie as colunas para NOME, SOBRENOME, DATA_CONTRATACAO e SALARIO_BASE.

SELECT 
	FirstName AS 'NOME',
	LastName AS 'SOBRENOME',
	HireDate AS 'DATA_CONTRATACAO',
	BaseRate AS 'SALARIO_BASE'
FROM DimEmployee


--4. ORDER BY (uma coluna)
--Liste todos os produtos da DimProduct ordenados pelo preço de lista (ListPrice) do mais caro para o mais barato.

SELECT * FROM DimProduct
ORDER BY ListPrice DESC

--5. ORDER BY (múltiplas colunas)
--Na DimCustomer, ordene por Gender (ASC), depois MaritalStatus (DESC), depois YearlyIncome (DESC).

SELECT * FROM DimCustomer
ORDER BY 
	Gender ASC,
	MaritalStatus DESC, 
	YearlyIncome DESC

--6. ORDER BY por posição ou alias
--Refaça o exercício 3 (DimEmployee) e ordene usando a posição das colunas: por DATA_CONTRATACAO DESC e depois SALARIO_BASE DESC.


SELECT 
	FirstName AS 'NOME',
	LastName AS 'SOBRENOME',
	HireDate AS 'DATA_CONTRATACAO',
	BaseRate AS 'SALARIO_BASE'
FROM DimEmployee
ORDER BY
	3 DESC, 4 DESC

--7. TOP
--Traga os 20 clientes com maior YearlyIncome da DimCustomer (mostre nome, sobrenome e renda).

SELECT TOP (20) 
	FirstName,
	LastName,
	YearlyIncome
FROM DimCustomer
ORDER BY YearlyIncome DESC

--8. TOP WITH TIES
--Refaça o exercício 7 usando TOP 20 WITH TIES — e perceba a diferença caso existam clientes empatados na 20ª posição.

SELECT TOP (20) WITH TIES *
FROM DimCustomer
ORDER BY YearlyIncome DESC

--9. WHERE (filtro simples)
--Na DimCustomer, mostre apenas clientes do gênero feminino (Gender = 'F').

SELECT 
	FirstName,
	Lastname,
	BirthDate,
	MaritalStatus,
	Gender
FROM DimCustomer
WHERE
	Gender = 'F'

--10. Operadores lógicos (AND, OR, NOT)
--Na DimCustomer, traga clientes que sejam:
--Casados (MaritalStatus = 'M') E
--Tenham renda anual maior que 50.000 E
--NÃO tenham filhos em casa (NumberChildrenAtHome = 0) E
--Sejam homens OU mulheres com mais de 2 filhos no total.

SELECT 
	FirstName,
	Lastname,
	BirthDate,
	MaritalStatus,
	Gender
FROM DimCustomer
WHERE
	MaritalStatus = 'M'
	AND YearlyIncome > 50000
	AND NumberChildrenAtHome = 0
	AND Gender IN ('M','F')
ORDER BY Gender DESC

	
--11. Operador IN
--Na DimProduct, traga produtos cujas cores (Color) sejam 'Red', 'Black' ou 'Silver'.

SELECT * FROM DimProduct
WHERE
	Color IN ('Red','Black','Silver')
ORDER BY Color

--12. CREATE TABLE
--Crie uma tabela chamada FUNCIONARIO_TESTE com as colunas:

CREATE TABLE FUNCIONARIO_TESTE (
	ID_FUNC INT,
	NOME VARCHAR(50),
	CARGO VARCHAR(30),
	SALARIO DECIMAL(10,2),
	DATA_ADMISSAO DATETIME
)

SELECT * FROM FUNCIONARIO_TESTE

--13. INSERT
--Insira 3 funcionários diferentes na sua tabela FUNCIONARIO_TESTE. Use GETDATE() em pelo menos um deles para a data de admissão.

INSERT INTO FUNCIONARIO_TESTE (
	ID_FUNC,
	NOME,
	CARGO,
	SALARIO,
	DATA_ADMISSAO
)

VALUES (
	2,
	'ANA',
	'ANALISTA',
	4000,
	GETDATE()
)

SELECT * FROM FUNCIONARIO_TESTE


--14. UPDATE
--Atualize o salário do funcionário de ID_FUNC = 2 para 7500.00 e mude o cargo dele ao mesmo tempo.

UPDATE FUNCIONARIO_TESTE
SET 
	SALARIO = 7500
WHERE 
	ID_FUNC = 2

SELECT * FROM FUNCIONARIO_TESTE

--15. DELETE
--Apague apenas o funcionário com ID_FUNC = 1 da tabela.

DELETE FUNCIONARIO_TESTE
WHERE ID_FUNC = 1

SELECT * FROM FUNCIONARIO_TESTE

--16. ALTER TABLE
--Altere a coluna CARGO para aceitar até 80 caracteres em vez de 30.

ALTER TABLE FUNCIONARIO_TESTE
ALTER COLUMN CARGO VARCHAR(80)

SELECT * FROM FUNCIONARIO_TESTE

