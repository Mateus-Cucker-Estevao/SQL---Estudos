--> Use o seu banco de testes (`PRIMEIRO_BD` ou crie um banco novo só pra esses exercícios). 
--**Não rode esses comandos no Contoso ou no AdventureWorks.**


--**36.** Crie uma tabela chamada `PRODUTO_TESTE` com as colunas:
-- `ID_PRODUTO` — inteiro
-- `NOME_PRODUTO` — texto de até 60 caracteres
-- `PRECO` — decimal com 10 dígitos no total e 2 casas decimais
-- `CATEGORIA` — texto de até 30 caracteres
-- `DATA_CADASTRO` — datetime

USE PRIMEIRO_DB

CREATE TABLE PRODUTO_TESTE (
	ID_PRODUTO INT,
	NOME_PRODUTO VARCHAR(60),
	PRECO DECIMAL (10,2),
	CATEGORIA VARCHAR(30),
	DATA_CADASTRO DATETIME
)

--**37.** Insira **3 produtos diferentes** na tabela. Em pelo menos um deles, use `GETDATE()` para a `DATA_CADASTRO`.

USE PRIMEIRO_DB

INSERT INTO PRODUTO_TESTE (
	ID_PRODUTO,
	NOME_PRODUTO,
	PRECO,
	CATEGORIA,
	DATA_CADASTRO
)

VALUES
	(4, 'CJ_GARRINHA', 2000.20, 'CONJUNTO', '2025-01-15'),
	(2, 'FORMA', 1500, 'TESTE', GETDATE()),
	(3, 'PINO', 350.45, 'FIXADORES', GETDATE())

--**38.** Atualize o `PRECO` do produto com `ID_PRODUTO = 2` para `99.90` e ao mesmo tempo mude a `CATEGORIA` dele para `'Promoção'`.
USE PRIMEIRO_DB

UPDATE PRODUTO_TESTE
SET 
	PRECO = 99.90,
	CATEGORIA = 'Promoção'
WHERE 
	ID_PRODUTO = 2

SELECT * FROM PRODUTO_TESTE


--**39.** Apague apenas o produto com `ID_PRODUTO = 1`.

USE PRIMEIRO_DB

DELETE FROM PRODUTO_TESTE
WHERE ID_PRODUTO = 1

SELECT * FROM PRODUTO_TESTE

--**40.** Altere a coluna `CATEGORIA` para aceitar até **100 caracteres** em vez de 30.

USE PRIMEIRO_DB

ALTER TABLE PRODUTO_TESTE
ALTER COLUMN CATEGORIA VARCHAR(100)


--**41.** **Mini-desafio:** insira mais 2 produtos onde o `PRECO` esteja entre 50 e 100, 
--depois faça um `SELECT` que traga **apenas esses 2** usando `WHERE PRECO BETWEEN 50 AND 100`.

USE PRIMEIRO_DB

INSERT INTO PRODUTO_TESTE (
	ID_PRODUTO,
	NOME_PRODUTO,
	PRECO,
	CATEGORIA,
	DATA_CADASTRO 
)

VALUES
	(5, 'CJ_GARRINHA', 50, 'CONJUNTO', GETDATE()),
	(6, 'FORMA', 67, 'TESTE', GETDATE()),
	(7, 'PINO', 98, 'FIXADORES', GETDATE())

SELECT * FROM PRODUTO_TESTE
WHERE PRECO BETWEEN 50 AND 100
ORDER BY PRECO