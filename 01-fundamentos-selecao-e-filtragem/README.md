# 01 — Fundamentos: Seleção e Filtragem

> 🗓️ Estudado em **Maio/2026** · Bancos: `ContosoRetailDW` e `PRIMEIRO_BD`

Primeiro contato com SQL: criar banco/tabelas, inserir e alterar dados, e o coração de tudo — o `SELECT` com seus filtros.

---

## 🏗️ DDL — Criando e alterando estruturas

| Comando | O que faz |
|---------|-----------|
| `CREATE TABLE` | Cria uma tabela definindo colunas e **tipos** (`INT`, `VARCHAR(30)`, `DATETIME`...). |
| `ALTER TABLE` | Altera uma tabela já existente (ex.: mudar o tipo de uma coluna com `ALTER COLUMN`). |

> 💡 Sempre comece com `USE NomeDoBanco` pra garantir que está trabalhando no banco certo.

## ✏️ DML — Manipulando dados

| Comando | O que faz |
|---------|-----------|
| `INSERT INTO` | Insere novas linhas (`VALUES (...)`). |
| `UPDATE ... SET` | Altera dados existentes. **Sempre com `WHERE`** pra não atualizar a tabela inteira! |
| `DELETE` | Apaga linhas. **Sempre com `WHERE`** pela mesma razão. |

## 🔍 SELECT e filtros

| Recurso | Resuminho |
|---------|-----------|
| `SELECT` | Escolhe as colunas a exibir (`*` = todas). |
| `ALIAS` (`AS`) | Dá um "apelido" a colunas ou tabelas, deixando o resultado legível. |
| `WHERE` | Filtra as linhas segundo condições. |
| `ORDER BY` | Ordena o resultado (`ASC` crescente / `DESC` decrescente). Pode ordenar por nome da coluna, **posição** (`ORDER BY 2, 3`) ou **alias**. |
| `TOP` | Traz só as N primeiras linhas. |
| `TOP ... WITH TIES` | Igual ao `TOP`, mas **inclui os empates** da última posição. |
| `BETWEEN` | Filtra dentro de um intervalo (`BETWEEN 2 AND 4`). Vale pra números e datas. |
| `IN` | Testa se o valor está numa lista (`IN ('A','B')`) — funciona como vários "OU". |
| `LIKE` | Busca por padrões de texto: `%` (qualquer coisa), `_` (um caractere), `[ei]` (um dentre os listados). |
| `IS NULL` | Testa se o campo está vazio (nulo). Cuidado: nulo **não** é comparável com `=`. |
| `NOT` | Nega uma condição. |
| Operadores lógicos | `AND`, `OR` e parênteses pra combinar condições. |
| Concatenação | `FirstName + ' ' + LastName` junta colunas de texto num campo só. |

---

## 📂 Scripts deste módulo

`SELECT` · `SELEC COLUNS ESPEFIC` · `ALIAS` · `WHERE` · `ORDERBY` (+ variações por múltiplas colunas e por posição/alias) · `TOP` · `TOP WITH TIES` · `BETWEEN` · `OPERADO IN` · `LIKE` · `IS NULL` · `NOT` · `OPERADORES LOGICOS` · `CONCATENANDO COLUNAS` · `CREAT_TABLE` · `ALTER_TABLE` · `INSERT` · `UPDATE` · `DELETE`

> ⚠️ **Lembrete que vale ouro:** em `UPDATE` e `DELETE`, **nunca** esqueça o `WHERE`. Sem ele, o comando afeta **todas** as linhas da tabela.
