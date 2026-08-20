# 02 — Agrupando Informações

> 🗓️ Estudado em **Junho/2026** · Banco: `ContosoRetailDW`

Como resumir muitos dados em números úteis (totais, médias, contagens) e agrupá-los por categoria.

---

## 🧮 Funções de agregação

| Função | O que devolve |
|--------|---------------|
| `SUM()` | Soma dos valores. |
| `AVG()` | Média. |
| `COUNT()` | Contagem de linhas. |
| `MIN()` | Menor valor. |
| `MAX()` | Maior valor. |

> 💡 Dá pra "montar" a média na mão com `SUM(coluna) / COUNT(coluna)` — bom exercício pra entender o que a `AVG` faz por baixo dos panos.

## 🗂️ GROUP BY

Agrupa as linhas por uma ou mais colunas e aplica a agregação **dentro de cada grupo**.

**Regra de ouro:** toda coluna que aparece no `SELECT` e **não** está dentro de uma função de agregação **precisa** aparecer no `GROUP BY`.

Ordem típica de uma consulta agregada:

```
SELECT   colunas + agregações
FROM     tabela
JOIN     outras tabelas
WHERE    filtra ANTES de agrupar
GROUP BY colunas
ORDER BY ordenação
```

---

## 📂 Scripts deste módulo

`FUNÇÕES DE AGREGAÇÃO` · `GROUP BY`

> 🔗 O filtro **depois** do agrupamento (`HAVING`) e o subtotal (`WITH ROLLUP`) estão no módulo [03 — Relacionamento entre tabelas](../03-relacionamento-entre-tabelas/), porque foram estudados junto com os JOINs.
