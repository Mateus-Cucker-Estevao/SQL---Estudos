# 04 — Funções de Data

> 🗓️ Estudado em **Agosto/2026** · Banco: `ContosoRetailDW`

Trabalhando com datas: pegar a data atual, somar/subtrair períodos, medir diferenças, extrair partes e formatar.

---

| Função | O que faz | Exemplo |
|--------|-----------|---------|
| `GETDATE()` | Data e hora **atuais**. | `SELECT GETDATE()` |
| `YEAR()` / `MONTH()` / `DAY()` | Extraem ano / mês / dia de uma data. | `YEAR(GETDATE())` |
| `DATEADD(parte, qtd, data)` | **Soma ou subtrai** um período. Use negativo pra voltar. | `DATEADD(MONTH, -1, GETDATE())` |
| `DATEDIFF(parte, início, fim)` | **Diferença** entre duas datas na unidade escolhida. | `DATEDIFF(DAY, '2023-07-10', GETDATE())` |
| `DATEPART(parte, data)` | Extrai um pedaço como **número** (ano, mês, dia da semana...). | `DATEPART(WEEKDAY, DateKey)` |
| `DATENAME(parte, data)` | Igual ao `DATEPART`, mas devolve o **nome** (ex.: "Sexta-Feira"). | `DATENAME(MONTH, DateKey)` |
| `EOMONTH(data)` | Último dia do mês (*End Of Month*). Aceita deslocamento. | `EOMONTH(GETDATE(), -1)` |
| `FORMAT(data, 'formato')` | Formata a data como texto no padrão que quiser. | `FORMAT(GETDATE(), 'dd/MM/yyyy')` |
| `SET DATEFORMAT` | Define a ordem que o SQL **lê** datas em texto (`ymd`, `dmy`...). | `SET DATEFORMAT YMD` |

## 📅 Partes de data mais usadas (`DATEPART` / `DATEADD`)

`YEAR` (ano) · `QUARTER` (trimestre) · `MONTH` (mês) · `DAY` (dia) · `DAYOFYEAR` (dia do ano) · `WEEKDAY` (dia da semana) · `WEEK` (semana) · `HOUR` · `MINUTE` · `SECOND`

## 🔤 Formatos comuns do `FORMAT`

`dd` dia (2 díg.) · `MM` mês (2 díg.) · `MMMM` nome do mês · `yyyy` ano (4 díg.) · `HH` hora 0–23 · `mm` minutos · `ss` segundos
→ Ex.: `FORMAT(GETDATE(), 'yyyy-MM-dd HH:mm:ss')`

---

## 📂 Scripts deste módulo

`GETDATE` · `DATEADD` · `DATEDIFF` · `DATEPART` · `DATENAME` · `EOMONTH` · `FORMAT` · `SET DATEFORMAT`

> 💡 **Uso prático:** essas funções brilham em filtros do tipo "vendas dos últimos 30 dias" (`DATEDIFF`) ou "tudo que caiu numa sexta-feira" (`DATENAME`/`DATEPART`).
