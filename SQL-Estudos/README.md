# 📚 Meus Estudos de SQL

> Repositório com tudo que venho aprendendo em **SQL (T-SQL / SQL Server)**, organizado por assunto.
> Cada módulo tem os scripts `.sql` que escrevi na prática + um `README` explicando os comandos.
> A ideia é acompanhar minha evolução ao longo do tempo, revisar depois e compartilhar o aprendizado. 🚀

---

## 🗓️ Linha do tempo

A ordem abaixo segue a data em que estudei cada bloco (baseada na data dos arquivos):

| Período | Módulo | Assunto |
|---------|--------|---------|
| Maio/2026 | [01 — Fundamentos](./01-fundamentos-selecao-e-filtragem/) | Criação de banco/tabelas, SELECT, filtros, DDL e DML |
| Jun/2026  | [02 — Agrupando informações](./02-agrupando-informacoes/) | Funções de agregação e `GROUP BY` |
| Mai–Jul/2026 | [03 — Relacionamento entre tabelas](./03-relacionamento-entre-tabelas/) | JOINs, `HAVING`, `WITH ROLLUP` e subconsultas |
| Ago/2026  | [04 — Funções de data](./04-funcoes-de-data/) | `GETDATE`, `DATEADD`, `DATEDIFF`, `FORMAT` e afins |
| Ago/2026  | [05 — Funções de texto](./05-funcoes-de-texto/) | Variáveis e manipulação de strings |
| Ago/2026  | [06 — CTE](./06-cte-common-table-expression/) | Common Table Expressions (`WITH`) |
| Mai–Ago/2026 | [🎯 Exercícios](./exercicios/) | Desafios práticos com gabarito |

---

## 📌 Assuntos estudados (resumão)

**Fundamentos e filtragem**
`CREATE / ALTER TABLE` · `INSERT` · `UPDATE` · `DELETE` · `SELECT` · `ALIAS` · `WHERE` · `ORDER BY` · `TOP` / `TOP WITH TIES` · `BETWEEN` · `IN` · `LIKE` · `IS NULL` · `NOT` · operadores lógicos · concatenação de colunas

**Agregação**
`SUM` · `AVG` · `COUNT` · `MIN` · `MAX` · `GROUP BY` · `HAVING` · `WITH ROLLUP`

**Relacionamento entre tabelas**
`INNER JOIN` · `LEFT JOIN` · `RIGHT JOIN` · `FULL JOIN` · `CROSS JOIN` · múltiplos JOINs · subconsultas (subqueries) com `IN` / `NOT IN` e dentro do `FROM`

**Funções de data**
`GETDATE` · `DATEADD` · `DATEDIFF` · `DATEPART` · `DATENAME` · `EOMONTH` · `FORMAT` · `SET DATEFORMAT`

**Funções de texto e variáveis**
`DECLARE` / `SET` · `+` e `CONCAT` · `LEN` · `TRIM` / `LTRIM` / `RTRIM` · `UPPER` / `LOWER` · `SUBSTRING` · `LEFT` / `RIGHT` · `CHARINDEX` · `REPLACE`

**CTE (Common Table Expression)**
`WITH ... AS (...)` para organizar consultas complexas

---

## 🛠️ Ambiente

- **SGBD:** Microsoft SQL Server (T-SQL)
- **Bancos usados nos exemplos:** `ContosoRetailDW`, `PRIMEIRO_BD` e `AdventureWorksDW2025`
- **Ferramentas:** SSMS / Azure Data Studio

---

## 📖 Como este repositório é organizado

```
SQL-Estudos/
├── README.md                          ← você está aqui (índice geral)
├── 01-fundamentos-selecao-e-filtragem/
│   ├── README.md                      ← resumo do módulo
│   └── *.sql                          ← scripts que escrevi
├── 02-agrupando-informacoes/
├── 03-relacionamento-entre-tabelas/
├── 04-funcoes-de-data/
├── 05-funcoes-de-texto/
├── 06-cte-common-table-expression/
└── exercicios/                        ← desafios práticos com gabarito
```

> 💡 As pastas usam nomes sem acento **de propósito**, pra evitar problemas de codificação (encoding) ao abrir em ferramentas ou clonar no Windows.

---

⭐ *Sinta-se à vontade pra acompanhar, sugerir melhorias ou aprender junto!*
