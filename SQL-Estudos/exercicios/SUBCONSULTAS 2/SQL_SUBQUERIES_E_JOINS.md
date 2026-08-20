# SQL - Subqueries e Relacionamento entre Tabelas

Guia de estudo + exercicios + gabarito
**Banco:** ContosoRetailDW  **SGBD:** SQL Server (T-SQL)

> Comentarios e texto sem acento de proposito, para evitar problema de encoding
> ao abrir no SSMS / Azure Data Studio.

---

## 1. O "clique" das subqueries

Uma subquery e so **uma consulta dentro de outra**. Toda a inseguranca some
quando voce responde UMA pergunta antes de escrever:

> **"Minha subquery devolve UM VALOR, UMA LISTA ou UMA TABELA?"**

A resposta decide ONDE ela pode ficar:

| A subquery devolve... | Onde ela entra | Operadores |
|---|---|---|
| **um valor** (um MAX, uma media) | depois de `=`, `>`, `<`, `>=`, `<=` | comparacao |
| **uma lista** (uma coluna, varios valores) | com `IN` / `NOT IN` / `ANY` / `ALL` | pertencimento |
| **uma tabela** (varias colunas/linhas) | no `FROM` (com apelido) ou com `EXISTS` | join / existencia |

**Correlacionada:** quando a subquery usa uma coluna da query de fora, ela roda
"uma vez por linha". Quase sempre aparece com `EXISTS` ou como comparacao no
`WHERE`/`SELECT`.

Voce ja usou as tres formas no curso:

```sql
-- UM VALOR (a media): cabe depois do <=
WHERE UnitPrice <= (SELECT AVG(UnitPrice) FROM DimProduct)

-- UMA LISTA de ProductKey: usa IN
WHERE S.ProductKey IN (SELECT ProductKey FROM DimProduct WHERE ...)

-- UMA TABELA: vai no FROM com apelido (AS TOP5) e entra num JOIN
FROM FactSales S2 INNER JOIN (SELECT TOP 5 ...) AS TOP5 ON ...
```

---

## 2. Correcao rapida: FULL JOIN vs RIGHT JOIN

No seu arquivo `FULL_JOIN.sql` o **comentario** descrevia o FULL JOIN, mas o
**codigo** usava `RIGHT JOIN`. Para fixar a diferenca:

- `LEFT JOIN`  -> tudo da tabela da **esquerda** + o que casar da direita
- `RIGHT JOIN` -> tudo da **direita** + o que casar da esquerda
- `FULL JOIN`  -> **tudo dos dois lados**; o que nao casa vira `NULL` do lado faltante

```sql
-- FULL JOIN de verdade:
SELECT P.ProductKey, P.ProductName, S.ProductKey AS S_ProductKey
FROM DimProduct AS P
FULL JOIN FactSales AS S ON S.ProductKey = P.ProductKey;
```

---

## 3. Banco de exemplo (colunas principais)

```
FactSales              : SalesKey, DateKey, channelKey, StoreKey, ProductKey,
                         UnitPrice, UnitCost, SalesQuantity, SalesAmount,
                         ReturnAmount, DiscountAmount, TotalCost
DimProduct             : ProductKey, ProductName, BrandName, ColorName,
                         Manufacturer, UnitPrice, ProductSubcategoryKey
DimProductSubcategory  : ProductSubcategoryKey, ProductSubcategoryName,
                         ProductCategoryKey
DimProductCategory     : ProductCategoryKey, ProductCategoryName
DimStore               : StoreKey, StoreName, GeographyKey, EmployeeCount
DimGeography           : GeographyKey, ContinentName, RegionCountryName, CityName
DimChannel             : ChannelKey, ChannelName
```

Relacoes: `FactSales.ProductKey -> DimProduct`, `FactSales.StoreKey -> DimStore`,
`FactSales.channelKey -> DimChannel`, `DimStore.GeographyKey -> DimGeography`,
`DimProduct.ProductSubcategoryKey -> DimProductSubcategory -> DimProductCategory`.

---

## 4. Exercicios

Tente resolver com o gabarito (secao 5) fechado. Depois compare.

### Nivel 1 - subquery escalar e IN

1. Liste `ProductKey`, `ProductName` e `UnitPrice` dos produtos com preco
   **acima da media** de todos os produtos. *(subquery = um valor)*
2. Mostre o(s) produto(s) **mais caro(s)**: `UnitPrice` igual ao `MAX(UnitPrice)`
   da `DimProduct`. *(um valor)*
3. Traga todas as linhas de `FactSales` dos produtos cuja marca (`BrandName`)
   seja `'Contoso'`. *(uma lista -> IN)*
4. Liste os produtos (`DimProduct`) que **nunca** aparecem em `FactSales`.
   *(NOT IN; cuidado com NULL)*

### Nivel 2 - subquery no FROM e correlacionada

5. **Top 10** produtos por total vendido (`SUM(SalesAmount)`), mostrando o
   `ProductName`. *(subquery no FROM = uma tabela)*
6. Para cada canal (`DimChannel.ChannelName`), mostre ao lado o total de
   `SalesAmount` daquele canal. *(correlacionada no SELECT)*
7. Liste os produtos cujo `UnitPrice` e maior que a **media de preco da propria
   subcategoria**. *(correlacionada no WHERE)*

### Nivel 3 - EXISTS, combinacoes e desafios

8. Liste as lojas (`DimStore.StoreName`) que tem **pelo menos uma venda** em
   `FactSales`. *(EXISTS)*
9. Refaca o exercicio 4 usando **NOT EXISTS**. Por que ele nao sofre com o
   problema do NULL?
10. Liste os paises (`RegionCountryName`) cujo total de `SalesAmount` esta
    **acima da media dos totais por pais**. *(subquery dentro de subquery)*
11. Para cada categoria (`ProductCategoryName`), mostre o produto com a **maior
    soma de `SalesQuantity`**. *(top-1 por grupo)*
12. **Desafio:** canais cujo ticket medio (`AVG(SalesAmount)`) supera o ticket
    medio **geral** de toda a `FactSales`. *(subquery escalar no HAVING)*

---

## 5. Gabarito

Cada resposta traz o TIPO da subquery. Se a sua deu o mesmo resultado por outro
caminho, tambem esta certa.

### Nivel 1

**1) Produtos acima da media de preco.** `[um valor]`
```sql
SELECT ProductKey, ProductName, UnitPrice
FROM DimProduct
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM DimProduct)
ORDER BY UnitPrice DESC;
```
A subquery roda 1x, calcula a media e vira um numero fixo dentro do WHERE.

**2) Produto(s) mais caro(s).** `[um valor]`
```sql
SELECT ProductKey, ProductName, UnitPrice
FROM DimProduct
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM DimProduct);
```
Usar `=` com `MAX()` traz todos que empatam no preco maximo (pode dar +1 linha).

**3) Vendas de produtos da marca 'Contoso'.** `[uma lista]`
```sql
SELECT *
FROM FactSales
WHERE ProductKey IN (
    SELECT ProductKey
    FROM DimProduct
    WHERE BrandName = 'Contoso'
);
```
`IN` compara cada `ProductKey` de `FactSales` com a lista de chaves da marca.

**4) Produtos que nunca aparecem em FactSales.** `[lista, NOT IN]`
```sql
SELECT ProductKey, ProductName
FROM DimProduct
WHERE ProductKey NOT IN (
    SELECT ProductKey
    FROM FactSales
    WHERE ProductKey IS NOT NULL     -- protege o NOT IN contra NULL
);
```
Se a lista do `NOT IN` tiver 1 `NULL`, o resultado inteiro vira vazio. Por isso
o filtro `IS NOT NULL`. (No ex.9 resolvemos isso de vez com `NOT EXISTS`.)

### Nivel 2

**5) Top 10 produtos por total vendido, com o nome.** `[uma tabela]`
```sql
SELECT P.ProductName, T.TotalVendas
FROM (
    SELECT TOP 10 S.ProductKey, SUM(S.SalesAmount) AS TotalVendas
    FROM FactSales AS S
    GROUP BY S.ProductKey
    ORDER BY TotalVendas DESC
) AS T
INNER JOIN DimProduct AS P ON P.ProductKey = T.ProductKey
ORDER BY T.TotalVendas DESC;   -- repetir o ORDER BY: o JOIN nao preserva a ordem
```
A subquery `T` e uma "tabela temporaria" ja com o top 10; o JOIN so busca o nome.

**6) Total de vendas por canal.** `[correlacionada no SELECT]`
```sql
SELECT
    DC.ChannelName,
    (SELECT SUM(S.SalesAmount)
     FROM FactSales AS S
     WHERE S.channelKey = DC.ChannelKey) AS TotalVendas
FROM DimChannel AS DC
ORDER BY TotalVendas DESC;
```
Usa `DC.ChannelKey` de fora, entao roda 1x por canal. Mesma coisa com JOIN +
GROUP BY (costuma ser mais eficiente):
```sql
SELECT DC.ChannelName, SUM(S.SalesAmount) AS TotalVendas
FROM DimChannel AS DC
INNER JOIN FactSales AS S ON S.channelKey = DC.ChannelKey
GROUP BY DC.ChannelName;
```

**7) Produtos acima da media da propria subcategoria.** `[correlacionada no WHERE]`
```sql
SELECT P.ProductKey, P.ProductName, P.UnitPrice, P.ProductSubcategoryKey
FROM DimProduct AS P
WHERE P.UnitPrice > (
    SELECT AVG(P2.UnitPrice)
    FROM DimProduct AS P2
    WHERE P2.ProductSubcategoryKey = P.ProductSubcategoryKey
)
ORDER BY P.ProductSubcategoryKey, P.UnitPrice DESC;
```
Para cada produto `P`, a subquery calcula a media SO da subcategoria dele. Os
apelidos `P` e `P2` sao a mesma tabela usada duas vezes.

### Nivel 3

**8) Lojas com pelo menos uma venda.** `[EXISTS]`
```sql
SELECT DS.StoreKey, DS.StoreName
FROM DimStore AS DS
WHERE EXISTS (
    SELECT 1
    FROM FactSales AS S
    WHERE S.StoreKey = DS.StoreKey
);
```
`EXISTS` para na 1a linha que encontra: so responde "existe? sim/nao". O
`SELECT 1` e convencao - nao importa o que se poe dentro.

**9) Produtos nunca vendidos, com NOT EXISTS.**
```sql
SELECT P.ProductKey, P.ProductName
FROM DimProduct AS P
WHERE NOT EXISTS (
    SELECT 1
    FROM FactSales AS S
    WHERE S.ProductKey = P.ProductKey
);
```
Por que e mais seguro que o `NOT IN` do ex.4? `EXISTS` avalia linha a linha e
sempre devolve TRUE/FALSE. O `NOT IN`, quando a lista tem `NULL`, devolve
UNKNOWN e "engole" o resultado. `NOT EXISTS` nao tem esse problema.

**10) Paises com total acima da media dos totais por pais.**
```sql
SELECT G.RegionCountryName, SUM(S.SalesAmount) AS TotalPais
FROM FactSales AS S
INNER JOIN DimStore AS ST     ON ST.StoreKey = S.StoreKey
INNER JOIN DimGeography AS G  ON G.GeographyKey = ST.GeographyKey
GROUP BY G.RegionCountryName
HAVING SUM(S.SalesAmount) > (
    SELECT AVG(PorPais.Total)
    FROM (
        SELECT SUM(S2.SalesAmount) AS Total
        FROM FactSales AS S2
        INNER JOIN DimStore AS ST2    ON ST2.StoreKey = S2.StoreKey
        INNER JOIN DimGeography AS G2 ON G2.GeographyKey = ST2.GeographyKey
        GROUP BY G2.RegionCountryName
    ) AS PorPais
)
ORDER BY TotalPais DESC;
```
A subquery interna monta os totais de cada pais (uma tabela) e tira a media
deles (um valor); o `HAVING` compara o total de cada pais com essa media.
Subquery dentro de subquery - exatamente o que costuma dar inseguranca.

**11) Produto com maior SalesQuantity de cada categoria.** (top-1 por grupo)
```sql
SELECT T.ProductCategoryName, T.ProductName, T.TotalQtd
FROM (
    SELECT PC.ProductCategoryName, P.ProductKey, P.ProductName,
           SUM(S.SalesQuantity) AS TotalQtd
    FROM FactSales AS S
    INNER JOIN DimProduct AS P             ON P.ProductKey = S.ProductKey
    INNER JOIN DimProductSubcategory AS SC ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
    INNER JOIN DimProductCategory AS PC    ON PC.ProductCategoryKey = SC.ProductCategoryKey
    GROUP BY PC.ProductCategoryName, P.ProductKey, P.ProductName
) AS T
WHERE T.TotalQtd = (
    SELECT MAX(T2.TotalQtd)
    FROM (
        SELECT PC2.ProductCategoryName AS Cat, P2.ProductKey,
               SUM(S2.SalesQuantity) AS TotalQtd
        FROM FactSales AS S2
        INNER JOIN DimProduct AS P2             ON P2.ProductKey = S2.ProductKey
        INNER JOIN DimProductSubcategory AS SC2 ON SC2.ProductSubcategoryKey = P2.ProductSubcategoryKey
        INNER JOIN DimProductCategory AS PC2    ON PC2.ProductCategoryKey = SC2.ProductCategoryKey
        GROUP BY PC2.ProductCategoryName, P2.ProductKey
    ) AS T2
    WHERE T2.Cat = T.ProductCategoryName
)
ORDER BY T.ProductCategoryName;
```
Quando aprender **window functions**, o mesmo fica muito mais simples:
```sql
SELECT ProductCategoryName, ProductName, TotalQtd
FROM (
    SELECT PC.ProductCategoryName, P.ProductName,
           SUM(S.SalesQuantity) AS TotalQtd,
           ROW_NUMBER() OVER (PARTITION BY PC.ProductCategoryName
                              ORDER BY SUM(S.SalesQuantity) DESC) AS rn
    FROM FactSales S
    JOIN DimProduct P             ON P.ProductKey = S.ProductKey
    JOIN DimProductSubcategory SC ON SC.ProductSubcategoryKey = P.ProductSubcategoryKey
    JOIN DimProductCategory PC    ON PC.ProductCategoryKey = SC.ProductCategoryKey
    GROUP BY PC.ProductCategoryName, P.ProductName
) X
WHERE rn = 1;
```

**12) Canais com ticket medio acima do geral.** `[escalar no HAVING]`
```sql
SELECT DC.ChannelName, AVG(S.SalesAmount) AS TicketMedio
FROM FactSales AS S
INNER JOIN DimChannel AS DC ON DC.ChannelKey = S.channelKey
GROUP BY DC.ChannelName
HAVING AVG(S.SalesAmount) > (SELECT AVG(SalesAmount) FROM FactSales)
ORDER BY TicketMedio DESC;
```
O `HAVING` filtra grupos: mantem so os canais cuja media supera a media geral.
`WHERE` nao serviria aqui - ele filtra ANTES de agrupar, e a media so existe
depois do `GROUP BY`.

---

*Duvida em algum exercicio? Reveja a pergunta-chave da secao 1: valor, lista ou
tabela?*
