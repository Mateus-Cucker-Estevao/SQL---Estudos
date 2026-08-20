# 06 — CTE (Common Table Expression)

> 🗓️ Estudado em **Agosto/2026** · Banco: `ContosoRetailDW`

Uma CTE é uma "tabela temporária" com nome, que existe **só durante a execução da consulta**. Serve pra organizar consultas complexas e evitar subconsultas aninhadas e confusas. Começa com `WITH`.

---

## Estrutura

```sql
WITH NOME_DA_CTE (col1, col2, ...)
AS
(
    SELECT ...      -- a consulta que "monta" a tabela temporária
)
SELECT ...          -- consulta que USA a CTE, como se fosse uma tabela
FROM NOME_DA_CTE;
```

## Resuminho

- `WITH NOME (colunas) AS ( ... )` define a CTE e os nomes das colunas.
- Dentro dos parênteses vai um `SELECT` normal (aqui, agregando vendas por ano/mês/produto).
- Depois de fechar a CTE, você faz um `SELECT` **em cima dela** — pode até dar `JOIN` com outras tabelas e ordenar.
- Serve tanto pra um cálculo final (ex.: `AVG` sobre o agrupamento) quanto pra listar um `TOP N`.

> ⚠️ **Regra importante:** a CTE precisa vir **imediatamente antes** do `SELECT` que a usa. Se tiver outro comando no meio, o SQL "esquece" que ela existe.

---

## 📂 Scripts deste módulo

`CTE - COMUM TABLE EXPRESSION` · `Exemplo com CTE`

> 🔗 CTE é uma forma mais limpa de fazer o que as **subconsultas** ([módulo 03](../03-relacionamento-entre-tabelas/)) fazem — vale comparar os dois estilos.
