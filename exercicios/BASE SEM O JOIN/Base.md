# 📘 Exercícios de SQL para Praticar

> **Bancos usados:** `ContosoRetailDW` e `AdventureWorksDW2025`
> **Tópicos cobertos:** SELECT, WHERE, ORDER BY, TOP / TOP WITH TIES, BETWEEN, IN, LIKE, IS NULL, NOT, AND/OR, ALIAS, concatenação, CREATE/ALTER TABLE, INSERT, UPDATE, DELETE.

**Dica geral:** sempre comece com `USE NomeDoBanco` para selecionar o banco correto. Tente resolver **sem olhar o gabarito** — o gabarito está no final.

---

## 🟢 Seção 1 — SELECT, ALIAS e Concatenação

**1.** No banco `ContosoRetailDW`, traga **todas as colunas** da tabela `DimProduct`.

**2.** Ainda em `DimProduct`, traga apenas as colunas `ProductName`, `BrandName`, `ColorName` e `UnitPrice`.

**3.** Na tabela `DimStore`, traga `StoreName`, `EmployeeCount` e `Status`, mas renomeie as colunas para `LOJA`, `QTD_FUNCIONARIOS` e `SITUACAO`.

**4.** Na `DimEmployee`, crie uma coluna chamada `NOME_COMPLETO` concatenando `FirstName + ' ' + LastName`. Traga também `Title` e `HireDate`.

**5.** Em `AdventureWorksDW2025`, na `DimCustomer`, crie uma coluna `IDENTIFICACAO` concatenando `FirstName + ' ' + MiddleName + ' ' + LastName`. Traga junto `EmailAddress` e `Gender`.
> 💡 Cuidado: se `MiddleName` for `NULL`, o resultado fica `NULL`. Você vai observar isso na prática — depois aprende a tratar, por enquanto só observe.

---

## 🟢 Seção 2 — ORDER BY

**6.** Em `ContosoRetailDW`, traga todos os clientes de `DimCustomer` ordenados por `BirthDate` do **mais velho para o mais novo**.

**7.** Em `DimProduct` (`ContosoRetailDW`), liste todos os produtos ordenados pelo `UnitPrice` do **mais caro para o mais barato**.

**8.** Em `DimCustomer` (`ContosoRetailDW`), traga `FirstName`, `LastName`, `Gender`, `MaritalStatus` e `YearlyIncome`, ordenando por:
- `Gender` crescente
- depois `MaritalStatus` crescente
- depois `YearlyIncome` decrescente

**9.** Refaça o exercício 8, mas dessa vez ordene **pela posição** das colunas no `SELECT`, não pelos nomes.

**10.** Refaça o exercício 8, mas dessa vez ordene **pelo apelido (alias)** — coloque `YearlyIncome` como `RENDA_ANUAL` e ordene por `RENDA_ANUAL DESC`.

---

## 🟢 Seção 3 — TOP e TOP WITH TIES

**11.** Em `ContosoRetailDW.DimCustomer`, traga os **10 clientes com a maior renda anual** (`YearlyIncome`). Mostre nome, sobrenome e renda.

**12.** Em `ContosoRetailDW.DimProduct`, traga os **5 produtos mais baratos** (`UnitPrice`). Mostre `ProductName`, `BrandName` e `UnitPrice`.

**13.** Refaça o exercício 11 usando `TOP 10 WITH TIES`. Observe se aparecem mais que 10 linhas (quando há empate no último valor).

**14.** Em `AdventureWorksDW2025.DimEmployee`, traga os **3 funcionários com maior `BaseRate`** com `WITH TIES`. Mostre nome, sobrenome, cargo (`Title`) e `BaseRate`.

---

## 🟢 Seção 4 — WHERE básico

**15.** Em `ContosoRetailDW.DimCustomer`, traga apenas os clientes **do gênero masculino** (`Gender = 'M'`).

**16.** Em `ContosoRetailDW.DimProduct`, traga apenas os produtos cujo `UnitPrice` seja **maior que 1000**.

**17.** Em `ContosoRetailDW.DimStore`, traga apenas as lojas com **mais de 30 funcionários** (`EmployeeCount > 30`).

**18.** Em `AdventureWorksDW2025.DimCustomer`, traga apenas os clientes cuja `YearlyIncome` seja **menor ou igual a 30000**.

---

## 🟡 Seção 5 — BETWEEN, IN, IS NULL

**19.** Em `ContosoRetailDW.DimCustomer`, traga clientes nascidos entre **01/01/1970 e 31/12/1980**.

**20.** Em `ContosoRetailDW.DimCustomer`, traga clientes com `TotalChildren` **entre 1 e 3**.

**21.** Em `ContosoRetailDW.DimProduct`, traga produtos cuja `ColorName` seja **'Red', 'Blue' ou 'Green'**.

**22.** Em `ContosoRetailDW.DimCustomer`, traga clientes cujo `Education` seja **'Bachelors' ou 'Graduate Degree'** E que tenham `MaritalStatus` preenchido (não nulo).

**23.** Em `ContosoRetailDW.DimCustomer`, traga clientes cujo `MaritalStatus` **seja NULL** (sem estado civil informado).

---

## 🟡 Seção 6 — LIKE

**24.** Em `ContosoRetailDW.DimEmployee`, traga todos cujo `FirstName` **comece com a letra 'M'**.

**25.** Em `ContosoRetailDW.DimEmployee`, traga todos cujo `LastName` **termine com 'son'** (ex.: Anderson, Johnson…).

**26.** Em `ContosoRetailDW.DimProduct`, traga produtos cujo `ProductName` **contenha a palavra 'Bike'** em qualquer posição.

**27.** Em `ContosoRetailDW.DimEmployee`, traga funcionários cujo `FirstName` tenha **exatamente 4 letras** e comece com 'J'.
> 💡 Dica: use o curinga `_` para representar uma única letra.

**28.** Em `ContosoRetailDW.DimEmployee`, traga funcionários cujo `FirstName` comece com **'C' ou 'S'**, usando colchetes `[ ]`.

---

## 🟡 Seção 7 — Operadores lógicos (AND, OR, NOT) combinados

**29.** Em `ContosoRetailDW.DimCustomer`, traga clientes que sejam:
- **Mulheres** E
- **Casadas** E
- Tenham **renda anual maior que 60.000** E
- Tenham **2 ou mais filhos**.

Ordene da maior renda para a menor.

**30.** Em `ContosoRetailDW.DimCustomer`, traga clientes que **NÃO** sejam de educação `'High School'` E que tenham `NumberChildrenAtHome` **diferente de 0**.

**31.** Em `ContosoRetailDW.DimCustomer`, traga clientes que:
- Tenham `Education` em `('Bachelors', 'Graduate Degree')` E
- Tenham `TotalChildren` entre 2 e 4 E
- **NÃO** sejam casados (use `NOT MaritalStatus = 'M'` — cuide do caso `NULL`).

**32.** Em `ContosoRetailDW.DimProduct`, traga produtos que:
- Tenham `ColorName` **diferente de 'Black' e 'White'** (use `NOT IN`) E
- `UnitPrice` entre **500 e 2000** E
- `ProductName` **contenha 'Pro'** (LIKE).

---

## 🔴 Seção 8 — Desafios (mistura tudo)

**33.** Em `ContosoRetailDW.DimCustomer`, monte uma consulta que mostre:
- Coluna `NOME_COMPLETO` com `FirstName + ' ' + LastName`
- `BirthDate` como `DATA_NASCIMENTO`
- `YearlyIncome` como `RENDA`
- `Education` como `ESCOLARIDADE`

Filtros:
- Nascidos entre 1960 e 1985
- Renda anual entre 40.000 e 90.000
- Escolaridade em `('Bachelors','Graduate Degree','High School')`
- `MaritalStatus` **não pode ser NULL**

Ordene pela `RENDA` decrescente e traga apenas os **TOP 50 WITH TIES**.

**34.** Em `ContosoRetailDW.DimEmployee`, traga os **20 primeiros funcionários** (use `TOP`) cujo:
- `FirstName` comece com qualquer letra de 'A' até 'M' (use `LIKE '[A-M]%'`)
- `Title` contenha a palavra **'Manager'**
- `HireDate` seja anterior a `'2005-01-01'`

Ordene por `HireDate` crescente.

**35.** Em `AdventureWorksDW2025.DimProduct`, traga produtos onde:
- `Color` esteja em `('Red','Black','Silver','Blue')`
- `ListPrice` entre 100 e 1500
- `ProductLine` **NÃO seja NULL**

Mostre `EnglishProductName`, `Color`, `ListPrice` e `ProductLine`. Ordene por `Color` ASC e dentro de cada cor, do mais caro para o mais barato.

---

## 🟢 Seção 9 — DDL e DML (criar/alterar/inserir/atualizar/deletar)

> Use o seu banco de testes (`PRIMEIRO_BD` ou crie um banco novo só pra esses exercícios). **Não rode esses comandos no Contoso ou no AdventureWorks.**

**36.** Crie uma tabela chamada `PRODUTO_TESTE` com as colunas:
- `ID_PRODUTO` — inteiro
- `NOME_PRODUTO` — texto de até 60 caracteres
- `PRECO` — decimal com 10 dígitos no total e 2 casas decimais
- `CATEGORIA` — texto de até 30 caracteres
- `DATA_CADASTRO` — datetime

**37.** Insira **3 produtos diferentes** na tabela. Em pelo menos um deles, use `GETDATE()` para a `DATA_CADASTRO`.

**38.** Atualize o `PRECO` do produto com `ID_PRODUTO = 2` para `99.90` e ao mesmo tempo mude a `CATEGORIA` dele para `'Promoção'`.

**39.** Apague apenas o produto com `ID_PRODUTO = 1`.

**40.** Altere a coluna `CATEGORIA` para aceitar até **100 caracteres** em vez de 30.

**41.** **Mini-desafio:** insira mais 2 produtos onde o `PRECO` esteja entre 50 e 100, depois faça um `SELECT` que traga **apenas esses 2** usando `WHERE PRECO BETWEEN 50 AND 100`.

---

# ✅ Gabarito (tente antes de olhar!)

<details>
<summary><strong>Clique/role para ver as soluções comentadas</strong></summary>

### Seção 1

**1.**
```sql
USE ContosoRetailDW
SELECT * FROM DimProduct
```

**2.**
```sql
USE ContosoRetailDW
SELECT ProductName, BrandName, ColorName, UnitPrice
FROM DimProduct
```

**3.**
```sql
USE ContosoRetailDW
SELECT
    StoreName     AS LOJA,
    EmployeeCount AS QTD_FUNCIONARIOS,
    Status        AS SITUACAO
FROM DimStore
```

**4.**
```sql
USE ContosoRetailDW
SELECT
    FirstName + ' ' + LastName AS NOME_COMPLETO,
    Title,
    HireDate
FROM DimEmployee
```

**5.**
```sql
USE AdventureWorksDW2025
SELECT
    FirstName + ' ' + MiddleName + ' ' + LastName AS IDENTIFICACAO,
    EmailAddress,
    Gender
FROM DimCustomer
```
> Quando qualquer parte da concatenação é `NULL`, o resultado todo vira `NULL`. Isso é normal — depois você vai aprender `ISNULL()` / `COALESCE()` para tratar.

---

### Seção 2

**6.**
```sql
USE ContosoRetailDW
SELECT * FROM DimCustomer
ORDER BY BirthDate ASC
```
> Mais velho = data mais antiga = ASC.

**7.**
```sql
USE ContosoRetailDW
SELECT * FROM DimProduct
ORDER BY UnitPrice DESC
```

**8.**
```sql
USE ContosoRetailDW
SELECT FirstName, LastName, Gender, MaritalStatus, YearlyIncome
FROM DimCustomer
ORDER BY Gender ASC, MaritalStatus ASC, YearlyIncome DESC
```

**9.**
```sql
SELECT FirstName, LastName, Gender, MaritalStatus, YearlyIncome
FROM DimCustomer
ORDER BY 3 ASC, 4 ASC, 5 DESC
```

**10.**
```sql
SELECT
    FirstName,
    LastName,
    Gender,
    MaritalStatus,
    YearlyIncome AS RENDA_ANUAL
FROM DimCustomer
ORDER BY Gender ASC, MaritalStatus ASC, RENDA_ANUAL DESC
```

---

### Seção 3

**11.**
```sql
SELECT TOP (10)
    FirstName, LastName, YearlyIncome
FROM DimCustomer
ORDER BY YearlyIncome DESC
```

**12.**
```sql
SELECT TOP (5)
    ProductName, BrandName, UnitPrice
FROM DimProduct
ORDER BY UnitPrice ASC
```

**13.**
```sql
SELECT TOP (10) WITH TIES
    FirstName, LastName, YearlyIncome
FROM DimCustomer
ORDER BY YearlyIncome DESC
```
> `WITH TIES` **só funciona com ORDER BY**. Se houver 5 pessoas empatadas com a 10ª maior renda, retorna 14 linhas, não 10.

**14.**
```sql
USE AdventureWorksDW2025
SELECT TOP (3) WITH TIES
    FirstName, LastName, Title, BaseRate
FROM DimEmployee
ORDER BY BaseRate DESC
```

---

### Seção 4

**15.**
```sql
SELECT * FROM DimCustomer
WHERE Gender = 'M'
```

**16.**
```sql
SELECT * FROM DimProduct
WHERE UnitPrice > 1000
```

**17.**
```sql
SELECT * FROM DimStore
WHERE EmployeeCount > 30
```

**18.**
```sql
USE AdventureWorksDW2025
SELECT * FROM DimCustomer
WHERE YearlyIncome <= 30000
```

---

### Seção 5

**19.**
```sql
SELECT * FROM DimCustomer
WHERE BirthDate BETWEEN '1970-01-01' AND '1980-12-31'
```

**20.**
```sql
SELECT * FROM DimCustomer
WHERE TotalChildren BETWEEN 1 AND 3
```

**21.**
```sql
SELECT * FROM DimProduct
WHERE ColorName IN ('Red','Blue','Green')
```

**22.**
```sql
SELECT * FROM DimCustomer
WHERE Education IN ('Bachelors','Graduate Degree')
  AND MaritalStatus IS NOT NULL
```

**23.**
```sql
SELECT * FROM DimCustomer
WHERE MaritalStatus IS NULL
```
> ⚠️ Nunca escreva `WHERE MaritalStatus = NULL`. Tem que ser **`IS NULL`**.

---

### Seção 6

**24.**
```sql
SELECT * FROM DimEmployee
WHERE FirstName LIKE 'M%'
```

**25.**
```sql
SELECT * FROM DimEmployee
WHERE LastName LIKE '%son'
```

**26.**
```sql
SELECT * FROM DimProduct
WHERE ProductName LIKE '%Bike%'
```

**27.**
```sql
SELECT * FROM DimEmployee
WHERE FirstName LIKE 'J___'
```
> `_` = 1 caractere obrigatório. `'J___'` = J + 3 caracteres = total 4 letras.

**28.**
```sql
SELECT * FROM DimEmployee
WHERE FirstName LIKE '[CS]%'
```

---

### Seção 7

**29.**
```sql
SELECT FirstName, LastName, Gender, MaritalStatus, YearlyIncome, TotalChildren
FROM DimCustomer
WHERE Gender = 'F'
  AND MaritalStatus = 'M'
  AND YearlyIncome > 60000
  AND TotalChildren >= 2
ORDER BY YearlyIncome DESC
```

**30.**
```sql
SELECT *
FROM DimCustomer
WHERE NOT Education = 'High School'
  AND NumberChildrenAtHome <> 0
```
> `<>` significa "diferente de". Você também poderia escrever `!=`, mas `<>` é o padrão ANSI.

**31.**
```sql
SELECT *
FROM DimCustomer
WHERE Education IN ('Bachelors','Graduate Degree')
  AND TotalChildren BETWEEN 2 AND 4
  AND (NOT MaritalStatus = 'M' OR MaritalStatus IS NULL)
```
> ⚠️ `NOT MaritalStatus = 'M'` sozinho **não pega os NULL** — por isso o `OR ... IS NULL`. Esse é um dos detalhes mais traiçoeiros do SQL.

**32.**
```sql
SELECT *
FROM DimProduct
WHERE ColorName NOT IN ('Black','White')
  AND UnitPrice BETWEEN 500 AND 2000
  AND ProductName LIKE '%Pro%'
```

---

### Seção 8

**33.**
```sql
SELECT TOP (50) WITH TIES
    FirstName + ' ' + LastName AS NOME_COMPLETO,
    BirthDate    AS DATA_NASCIMENTO,
    YearlyIncome AS RENDA,
    Education    AS ESCOLARIDADE
FROM DimCustomer
WHERE BirthDate BETWEEN '1960-01-01' AND '1985-12-31'
  AND YearlyIncome BETWEEN 40000 AND 90000
  AND Education IN ('Bachelors','Graduate Degree','High School')
  AND MaritalStatus IS NOT NULL
ORDER BY RENDA DESC
```

**34.**
```sql
SELECT TOP (20)
    FirstName, LastName, Title, HireDate
FROM DimEmployee
WHERE FirstName LIKE '[A-M]%'
  AND Title LIKE '%Manager%'
  AND HireDate < '2005-01-01'
ORDER BY HireDate ASC
```

**35.**
```sql
USE AdventureWorksDW2025
SELECT EnglishProductName, Color, ListPrice, ProductLine
FROM DimProduct
WHERE Color IN ('Red','Black','Silver','Blue')
  AND ListPrice BETWEEN 100 AND 1500
  AND ProductLine IS NOT NULL
ORDER BY Color ASC, ListPrice DESC
```

---

### Seção 9

**36.**
```sql
USE PRIMEIRO_BD
CREATE TABLE PRODUTO_TESTE (
    ID_PRODUTO    INT,
    NOME_PRODUTO  VARCHAR(60),
    PRECO         DECIMAL(10,2),
    CATEGORIA     VARCHAR(30),
    DATA_CADASTRO DATETIME
```

**37.**
```sql
INSERT  DUTO, NOME_PRODUTO, PRECO, CATEGORIA, DATA_CADASTRO)
VALUES
    (1, 'Mouse Gamer',  150.00, 'Periféricos', '2025-01-15'),
    (2, 'Teclado RGB',  280.50, 'Periféricos', '2025-02-20'),   
    (3, 'Monitor 24"',  899.90, 'Monitores',   GETDATE())
```

**38.**
```sql
UPDATE PRODUTO_TESTE
SET PRECO = 99.90,
    CATEGORIA = 'Promoção'
WHERE ID_PRODUTO = 2
```
> ⚠️ Esqueceu o `WHERE`? Atualiza **a tabela inteira**. Sempre cheque antes de rodar.

**39.**
```sql
DELETE FROM PRODUTO_TESTE
WHERE ID_PRODUTO = 1
```

**40.**
```sql
ALTER TABLE PRODUTO_TESTE
ALTER COLUMN CATEGORIA VARCHAR(100)
```

**41.**
```sql
INSERT INTO PRODUTO_TESTE VALUES
    (4, 'Cabo HDMI',  60.00, 'Acessórios', GETDATE()),
    (5, 'Pen Drive',  85.00, 'Acessórios', GETDATE())

SELECT * FROM PRODUTO_TESTE
WHERE PRECO BETWEEN 50 AND 100
```

</details>

---

## 💡 Dicas finais

- **Antes de rodar UPDATE/DELETE**, faça primeiro o `SELECT` com o mesmo `WHERE` pra ver o que vai ser afetado.
- **`NULL` é traiçoeiro**: `= NULL` nunca funciona, sempre use `IS NULL` / `IS NOT NULL`.
- **`WITH TIES` precisa de `ORDER BY`** — sem ele, o SQL Server dá erro.
- **`NOT IN` com valores NULL** pode te dar surpresas (não retorna nada) — algo a se atentar quando você for ver mais NULL na frente.
- Quando tiver dúvida sobre uma coluna, rode primeiro `SELECT TOP 10 * FROM Tabela` para ver os dados.

Bons estudos! 🚀
