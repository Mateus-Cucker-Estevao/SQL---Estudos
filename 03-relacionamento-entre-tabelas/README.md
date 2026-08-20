# 03 — Relacionamento entre Tabelas

> 🗓️ Estudado entre **Maio e Julho/2026** · Banco: `ContosoRetailDW`

Onde o SQL fica poderoso: juntar dados de várias tabelas usando as **chaves** que as relacionam. Também entram aqui o filtro de grupos (`HAVING`), o subtotal (`WITH ROLLUP`) e as subconsultas.

---

## 🔗 Tipos de JOIN

| JOIN | O que traz |
|------|-----------|
| `INNER JOIN` | Só as linhas que **têm correspondência** nas duas tabelas. É o mais usado. |
| `LEFT JOIN` | **Tudo da tabela da esquerda** + o que casar da direita (o resto vem `NULL`). |
| `RIGHT JOIN` | O oposto do `LEFT`: tudo da direita + o que casar da esquerda. |
| `FULL JOIN` | Tudo das **duas** tabelas, casando o que der. |
| `CROSS JOIN` | Todos contra todos (produto cartesiano). Raramente usado. |

> 💡 Sempre use **alias** nas tabelas (`FROM FactSales AS S`) e ligue-as pela chave no `ON` (`ON S.ProductKey = P.ProductKey`). Com muitas tabelas, o diagrama do banco ajuda a enxergar os relacionamentos.

**Múltiplos JOINs:** dá pra encadear vários `INNER JOIN` pra "subir" a hierarquia — ex.: venda → produto → subcategoria → categoria.

## 🎯 Filtrando grupos: HAVING

- `WHERE` filtra **antes** de agrupar (linha a linha).
- `HAVING` filtra **depois** de agrupar (o resultado das agregações).

```sql
GROUP BY S.ProductKey
HAVING SUM(S.SalesQuantity) BETWEEN 1500 AND 1600
```

## 📊 WITH ROLLUP

Adiciona **subtotais e um total geral** ao `GROUP BY`, ótimo pra análises rápidas.

## 🔎 Subconsultas (Subqueries)

Uma consulta **dentro** de outra. O segredo é saber o que ela devolve:

| A subquery devolve... | Onde ela entra |
|---|---|
| **um valor** (um `MAX`, uma média) | depois de `=`, `>`, `<`, `>=`, `<=` |
| **uma lista** (uma coluna) | com `IN` / `NOT IN` |
| **uma tabela** (várias colunas) | no `FROM` (com apelido) |

Exemplo — produtos com preço abaixo da média:

```sql
WHERE UnitPrice <= (SELECT AVG(UnitPrice) FROM DimProduct)
```

---

## 📂 Scripts deste módulo

`17 INNER JOIN` · `18 CRIANDO ALIAS PARA TABELA` · `LEFT JOIN` · `RIGHT JOIN` · `FULL JOIN` · `CROSS JOIN` · `MULTIPLOS JOINS EM TABELAS` (+ versão com `WHERE`) · `HAVING` · `WITH ROLLUP` · `SUBQUERYES` · `SUB COM IN E NOT` · `SUBQUERYES COM JOIN`

> ⚠️ **Detalhe que peguei revisando:** no arquivo `FULL JOIN.sql`, a consulta na verdade usa um `RIGHT JOIN`. Vale trocar pra `FULL JOIN` se a intenção era mesmo trazer os dois lados. 😉
