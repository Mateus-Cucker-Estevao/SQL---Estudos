# Exercícios de INNER JOIN — ContosoRetailDW

Lista progressiva de exercícios para fixar bem o conceito de **INNER JOIN**. Vai do básico (2 tabelas) até múltiplos JOINs com agregações e filtros. Tente resolver cada um antes de olhar o gabarito no final.

> Lembrete rápido: o **INNER JOIN** só traz os registros que existem **nas duas tabelas** (a interseção). Se o registro não tem correspondência, ele é descartado.

```sql
USE ContosoRetailDW
GO
```

---

## 🟢 Nível 1 — Básico (2 tabelas)

### Exercício 1
Liste o `SalesKey`, `SalesAmount` e o `ProductName` de cada venda. Traga apenas os 100 primeiros registros.

### Exercício 2
Mostre o `SalesKey`, `SalesAmount` e o `ChannelName` (nome do canal de venda) de cada venda. Use **aliases** nas tabelas (`FS` e `DC`).

### Exercício 3
Liste todas as vendas (`SalesKey`, `SalesQuantity`, `SalesAmount`) junto com o nome da loja (`StoreName`) da tabela `DimStore`. Limite a 50 linhas.

### Exercício 4
Mostre o nome do produto (`ProductName`) e o nome da subcategoria (`ProductSubcategoryName`) a que ele pertence. Ordene por subcategoria.

### Exercício 5
Liste todos os produtos com sua marca (`BrandName`) e o nome da categoria (`ProductCategoryName`). *(Dica: você vai precisar passar por `DimProductSubcategory` no meio do caminho — pense bem se 2 JOINs resolvem.)*

---

## 🟡 Nível 2 — Intermediário (filtros + agregações)

### Exercício 6
Mostre o total de `SalesAmount` por canal de venda (`ChannelName`). Ordene do maior para o menor.

### Exercício 7
Liste os 10 produtos mais vendidos em **quantidade** (`SalesQuantity`). Mostre `ProductName` e a soma total da quantidade.

### Exercício 8
Mostre o valor total vendido (`SalesAmount`) por **categoria de produto** (`ProductCategoryName`). Ordene do maior para o menor.

### Exercício 9
Mostre quantas vendas (contagem de `SalesKey`) foram feitas em cada loja (`StoreName`). Traga só lojas com mais de 1000 vendas.

### Exercício 10
Liste o `ProductName`, `BrandName` e a soma do `SalesAmount`, **apenas para produtos da marca "Contoso"**. Ordene do maior para o menor faturamento.

---

## 🟠 Nível 3 — Avançado (múltiplos JOINs)

### Exercício 11
Mostre, para cada venda (top 100), as seguintes colunas:
- `SalesKey`
- `SalesAmount`
- `ProductName`
- `ProductSubcategoryName`
- `ProductCategoryName`
- `ChannelName`
- `StoreName`

### Exercício 12
Calcule o total de `SalesAmount` por **categoria** e **canal**, mostrando as colunas `ProductCategoryName`, `ChannelName` e o total. Ordene por categoria e depois por canal.

### Exercício 13
Liste o **top 5 de subcategorias** com maior valor vendido. Mostre `ProductCategoryName`, `ProductSubcategoryName` e o total de `SalesAmount`.

### Exercício 14
Mostre o nome do produto, a categoria, e o **lucro total** (`SalesAmount - TotalCost`) por produto. Traga os 20 produtos com maior lucro.

### Exercício 15
Quantos produtos distintos cada **canal** vendeu? Mostre `ChannelName` e a contagem distinta de `ProductKey`. Ordene do maior para o menor.

---

## 🔴 Nível 4 — Desafios

### Exercício 16
Para cada **categoria de produto**, mostre:
- A quantidade total vendida (`SUM(SalesQuantity)`)
- O ticket médio (`AVG(SalesAmount)`)
- O lucro total (`SUM(SalesAmount - TotalCost)`)

Ordene pelo lucro total decrescente.

### Exercício 17
Liste as **10 lojas com maior faturamento**, mostrando `StoreName`, `StoreType` e o total de `SalesAmount`.

### Exercício 18
Mostre o faturamento total por **ano e categoria de produto**. Use a `DimDate` (campos `CalendarYear` e `DateKey`).
Colunas: `CalendarYear`, `ProductCategoryName`, `TotalVendas`. Ordene por ano e depois por categoria.

### Exercício 19
Encontre as **marcas (BrandName)** que tiveram faturamento acima de 10 milhões. Mostre `BrandName` e o total vendido.

### Exercício 20 (boss final 💪)
Mostre, **por canal e por categoria**:
- Total de vendas (`SUM(SalesAmount)`)
- Lucro total (`SUM(SalesAmount - TotalCost)`)
- Margem de lucro em % (lucro / vendas * 100)

Filtre apenas combinações com faturamento maior que 1 milhão. Ordene pela margem de lucro decrescente.

---

# ✅ Gabarito

> Tente fazer sem olhar primeiro! As soluções abaixo são **uma** maneira de resolver — pode haver variações válidas.

### Exercício 1
```sql
SELECT TOP (100)
    S.SalesKey,
    S.SalesAmount,
    P.ProductName
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
```

### Exercício 2
```sql
SELECT TOP (100)
    FS.SalesKey,
    FS.SalesAmount,
    DC.ChannelName
FROM FactSales AS FS
INNER JOIN DimChannel AS DC ON DC.ChannelKey = FS.ChannelKey
```

### Exercício 3
```sql
SELECT TOP (50)
    S.SalesKey,
    S.SalesQuantity,
    S.SalesAmount,
    ST.StoreName
FROM FactSales AS S
INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
```

### Exercício 4
```sql
SELECT
    P.ProductName,
    SC.ProductSubcategoryName
FROM DimProduct AS P
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
ORDER BY SC.ProductSubcategoryName
```

### Exercício 5
```sql
SELECT
    P.ProductName,
    P.BrandName,
    PC.ProductCategoryName
FROM DimProduct AS P
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
```
> Sim, precisa de 2 JOINs porque `DimProduct` não tem `ProductCategoryKey` direto — é preciso passar pela subcategoria.

### Exercício 6
```sql
SELECT
    DC.ChannelName,
    SUM(FS.SalesAmount) AS TotalVendas
FROM FactSales AS FS
INNER JOIN DimChannel AS DC ON DC.ChannelKey = FS.ChannelKey
GROUP BY DC.ChannelName
ORDER BY TotalVendas DESC
```

### Exercício 7
```sql
SELECT TOP (10)
    P.ProductName,
    SUM(S.SalesQuantity) AS QtdTotal
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
GROUP BY P.ProductName
ORDER BY QtdTotal DESC
```

### Exercício 8
```sql
SELECT
    PC.ProductCategoryName,
    SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
GROUP BY PC.ProductCategoryName
ORDER BY TotalVendas DESC
```

### Exercício 9
```sql
SELECT
    ST.StoreName,
    COUNT(S.SalesKey) AS QtdVendas
FROM FactSales AS S
INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
GROUP BY ST.StoreName
HAVING COUNT(S.SalesKey) > 1000
ORDER BY QtdVendas DESC
```
> Note o **HAVING** — filtro depois do agrupamento. Não dá pra usar WHERE com `COUNT()`.

### Exercício 10
```sql
SELECT
    P.ProductName,
    P.BrandName,
    SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
WHERE P.BrandName = 'Contoso'
GROUP BY P.ProductName, P.BrandName
ORDER BY TotalVendas DESC
```

### Exercício 11
```sql
SELECT TOP (100)
    S.SalesKey,
    S.SalesAmount,
    P.ProductName,
    SC.ProductSubcategoryName,
    PC.ProductCategoryName,
    DC.ChannelName,
    ST.StoreName
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
INNER JOIN DimChannel AS DC ON DC.ChannelKey = S.ChannelKey
INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
```

### Exercício 12
```sql
SELECT
    PC.ProductCategoryName,
    DC.ChannelName,
    SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
INNER JOIN DimChannel AS DC ON DC.ChannelKey = S.ChannelKey
GROUP BY PC.ProductCategoryName, DC.ChannelName
ORDER BY PC.ProductCategoryName, DC.ChannelName
```

### Exercício 13
```sql
SELECT TOP (5)
    PC.ProductCategoryName,
    SC.ProductSubcategoryName,
    SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
GROUP BY PC.ProductCategoryName, SC.ProductSubcategoryName
ORDER BY TotalVendas DESC
```

### Exercício 14
```sql
SELECT TOP (20)
    P.ProductName,
    PC.ProductCategoryName,
    SUM(S.SalesAmount - S.TotalCost) AS LucroTotal
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
GROUP BY P.ProductName, PC.ProductCategoryName
ORDER BY LucroTotal DESC
```

### Exercício 15
```sql
SELECT
    DC.ChannelName,
    COUNT(DISTINCT S.ProductKey) AS QtdProdutosDistintos
FROM FactSales AS S
INNER JOIN DimChannel AS DC ON DC.ChannelKey = S.ChannelKey
GROUP BY DC.ChannelName
ORDER BY QtdProdutosDistintos DESC
```

### Exercício 16
```sql
SELECT
    PC.ProductCategoryName,
    SUM(S.SalesQuantity) AS QtdTotalVendida,
    AVG(S.SalesAmount) AS TicketMedio,
    SUM(S.SalesAmount - S.TotalCost) AS LucroTotal
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
GROUP BY PC.ProductCategoryName
ORDER BY LucroTotal DESC
```

### Exercício 17
```sql
SELECT TOP (10)
    ST.StoreName,
    ST.StoreType,
    SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimStore AS ST ON ST.StoreKey = S.StoreKey
GROUP BY ST.StoreName, ST.StoreType
ORDER BY TotalVendas DESC
```

### Exercício 18
```sql
SELECT
    D.CalendarYear,
    PC.ProductCategoryName,
    SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimDate AS D ON D.Datekey = S.DateKey
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
GROUP BY D.CalendarYear, PC.ProductCategoryName
ORDER BY D.CalendarYear, PC.ProductCategoryName
```

### Exercício 19
```sql
SELECT
    P.BrandName,
    SUM(S.SalesAmount) AS TotalVendas
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
GROUP BY P.BrandName
HAVING SUM(S.SalesAmount) > 10000000
ORDER BY TotalVendas DESC
```

### Exercício 20
```sql
SELECT
    DC.ChannelName,
    PC.ProductCategoryName,
    SUM(S.SalesAmount) AS TotalVendas,
    SUM(S.SalesAmount - S.TotalCost) AS LucroTotal,
    (SUM(S.SalesAmount - S.TotalCost) / SUM(S.SalesAmount)) * 100 AS MargemPct
FROM FactSales AS S
INNER JOIN DimProduct AS P ON P.ProductKey = S.ProductKey
INNER JOIN DimProductSubcategory AS SC 
    ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
INNER JOIN DimProductCategory AS PC 
    ON PC.ProductCategoryKey = SC.ProductCategoryKey
INNER JOIN DimChannel AS DC ON DC.ChannelKey = S.ChannelKey
GROUP BY DC.ChannelName, PC.ProductCategoryName
HAVING SUM(S.SalesAmount) > 1000000
ORDER BY MargemPct DESC
```

---

# 💡 Dicas que vão te salvar muito

1. **Sempre use ALIAS** nas tabelas. Deixa o código mais limpo e obrigatório quando os nomes de coluna se repetem em tabelas diferentes (tipo `ProductKey` que existe em várias).

2. **Pense no diagrama de relacionamento** antes de escrever. Pergunte: "qual chave conecta essas tabelas?". A ordem mental fica:
   ```
   FactSales → DimProduct → DimProductSubcategory → DimProductCategory
   ```

3. **FactSales é o coração** do banco. A maioria das análises começa nela e vai puxando as dimensões.

4. **WHERE filtra linhas, HAVING filtra grupos**. Se você quer filtrar `SUM(...)` ou `COUNT(...)`, é `HAVING`.

5. **ORDER BY no final**, e você pode usar o número da coluna (`ORDER BY 3 DESC`) ou o alias criado no SELECT.

6. **GROUP BY precisa ter TODAS as colunas não-agregadas** do SELECT. Se esquecer alguma, o SQL Server reclama.

Bons estudos! 🚀
