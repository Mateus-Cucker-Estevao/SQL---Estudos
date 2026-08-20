# 05 — Funções de Texto e Variáveis

> 🗓️ Estudado em **Agosto/2026** · Banco: `ContosoRetailDW`

Guardar valores em variáveis e manipular textos (strings): juntar, limpar, recortar, formatar e substituir.

---

## 📦 Variáveis

Guardam uma informação pra reutilizar na consulta (filtros, parâmetros). Em T-SQL toda variável começa com **`@`** e precisa ter um **tipo**.

```sql
DECLARE @PROD INT;      -- cria
SET @PROD = 782;        -- atribui
SELECT * FROM FactOnlineSales WHERE ProductKey = @PROD;  -- usa
```

## 🔗 Concatenação

| Forma | Detalhe |
|-------|---------|
| `+` | Junta textos, mas **se algum valor for `NULL`, o resultado inteiro vira `NULL`**. |
| `CONCAT(...)` | Mais seguro: trata `NULL` como vazio e não quebra. Aceita vários valores. |

## 🧹 Funções básicas de texto

| Função | O que faz |
|--------|-----------|
| `LEN()` | Conta caracteres. ⚠️ Ignora espaços **à direita**, mas conta os **à esquerda**. |
| `LTRIM()` | Remove espaços da **esquerda**. |
| `RTRIM()` | Remove espaços da **direita**. |
| `TRIM()` | Remove espaços dos **dois lados**. |
| `UPPER()` | Deixa **MAIÚSCULO**. |
| `LOWER()` | Deixa **minúsculo**. |

> 💡 Dá pra encaixar uma função na outra: `UPPER(TRIM(@USER))` tira os espaços **e** deixa maiúsculo. O SQL resolve de dentro pra fora.

## ✂️ Extração de partes (recorte)

| Função | O que faz |
|--------|-----------|
| `SUBSTRING(texto, início, qtd)` | Pega um pedaço **do meio**. |
| `LEFT(texto, n)` | Pega os **primeiros** n caracteres (da esquerda). |
| `RIGHT(texto, n)` | Pega os **últimos** n caracteres (da direita). |
| `CHARINDEX('x', texto)` | Devolve a **posição** onde `x` começa. |

## 🔁 Substituição

- `REPLACE(texto, 'procurar', 'trocar')` → troca **todas** as ocorrências.
- Truque: colocando `''` no lugar da troca, você **remove** o trecho.

---

## 📂 Scripts deste módulo

`DECLARANDO VARIAVEIS` · `CONCATENAR` · `FUNCOES BASICAS DE TEXTO` · `Extração de partes de uma string` · `Substituição de texto`

> ⚠️ **Fica a dica:** nos comentários do arquivo de extração, `LEFT` e `RIGHT` estavam com as descrições trocadas. O certo é: **`LEFT` pega da esquerda, `RIGHT` da direita.**
