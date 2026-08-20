# 🎯 Exercícios Práticos

> 🗓️ Feitos entre **Maio e Agosto/2026** · Bancos: `ContosoRetailDW` e `AdventureWorksDW2025`

Desafios que resolvi pra fixar o conteúdo. Vários vêm com **enunciado + gabarito** nos arquivos `.md`. A ideia é tentar resolver **sem olhar a resposta** primeiro.

---

## 📁 Pastas

| Pasta | Foco | Conteúdo |
|-------|------|----------|
| [`BASE SEM O JOIN`](./BASE%20SEM%20O%20JOIN/) | Fundamentos | Enunciados por seção (`SELECT`, `ORDER BY`, `TOP`, `WHERE`, `BETWEEN/IN/IS NULL`, `LIKE`, operadores lógicos, DDL/DML) + resoluções. Veja o `Base.md`. |
| [`INNER JOIN`](./INNER%20JOIN/) | JOINs (parte 1) | Primeiros exercícios de junção entre tabelas. |
| [`INNER JOIN - PART 2`](./INNER%20JOIN%20-%20PART%202/) | JOINs (parte 2) | Continuação, com todos os tipos de JOIN. Guia em `exercicios_todos_joins_parte2.md`. |
| [`SUBCONSULTAS`](./SUBCONSULTAS/) | Subqueries | Primeiros desafios de consultas dentro de consultas. |
| [`SUBCONSULTAS 2`](./SUBCONSULTAS%202/) | Subqueries + JOINs | Desafios combinando subconsultas no `WHERE` e no `FROM`. Guia em `SQL_SUBQUERIES_E_JOINS.md`. |

---

## 💡 Dicas gerais que anotei

- Sempre comece com `USE NomeDoBanco`.
- Nas subconsultas, antes de escrever, pergunte: **"ela devolve um valor, uma lista ou uma tabela?"** — isso decide onde ela pode entrar (`=`, `IN`, ou no `FROM`).
- Tente resolver sozinho antes de conferir o gabarito. Errar faz parte. 😄
