

USE Chinook

/**1. Ranking simples
Traga TrackId, Name, Bytes da tabela Track e crie uma coluna RANKING_TAMANHO numerando as faixas da maior para a menor em bytes.*/

SELECT
	T.TrackId,
	T.Name,
	T.Bytes,
	ROW_NUMBER() OVER(ORDER BY T.Bytes DESC) AS 'RANKING_TAMANHO'
FROM Track AS T


/*2. Particionando por gênero
Traga TrackId, Name, GenreId, Milliseconds e crie a coluna POSICAO_NO_GENERO, numerando as faixas dentro de cada gênero, da mais longa para a mais curta.*/

SELECT
	T.TrackId,
	T.Name,
	T.GenreId,
	T.Milliseconds,
	ROW_NUMBER() OVER(PARTITION BY T.GenreId ORDER BY T.Milliseconds DESC) AS 'POSICAO_NO_GENERO'
FROM Track AS T;


/*3. A faixa mais longa de cada compositor
Usando o exercício da aula (PARTITION BY Composer ORDER BY Milliseconds DESC), retorne apenas uma linha por compositor: a faixa mais longa dele. Ignore compositores nulos.
Dica: ROW_NUMBER() não funciona direto no WHERE. Você vai precisar jogar a consulta dentro de uma subconsulta ou de um WITH ... AS () (CTE) e filtrar = 1 do lado de fora.*/


WITH ANALISE_FAIXAS(TrackId,Name,Composer,Milliseconds,Bytes,UnitPrice,ROW_NUMBER_PARTITION_BY)
AS
(
	SELECT 
		   [TrackId]
		  ,[Name]
		  ,[Composer]
		  ,[Milliseconds]
		  ,[Bytes]
		  ,[UnitPrice]
		  ,ROW_NUMBER() OVER(PARTITION BY Composer ORDER BY Milliseconds DESC) AS 'ROW_NUMBER_PARTITION_BY'  --O PARTITION BY, É USADO PARA PARTICIONAR OS DADOS E ORDERNAR A CADA UM DELES!
	  FROM [Chinook].[dbo].[Track]
	  WHERE Composer IS NOT NULL
  )
SELECT
	*
FROM ANALISE_FAIXAS
WHERE ROW_NUMBER_PARTITION_BY = 1




/*4. Top 3 de cada álbum
Para cada AlbumId, retorne as 3 faixas mais caras (UnitPrice), e em caso de empate, desempate pelo nome em ordem alfabética.
Dica: dá pra colocar mais de uma coluna no ORDER BY de dentro do OVER().*/


WITH ANALISE_PRECO(Name,AlbumId,Composer,UnitPrice,RANKG_PRECO)
AS
(
	SELECT 
		T.Name,
		T.AlbumId,
		T.Composer,
		T.UnitPrice,
		ROW_NUMBER() OVER(PARTITION BY T.AlbumId ORDER BY T.UnitPrice DESC, T.Name ASC) AS 'RANKG_PRECO'
	FROM Track AS T
)
SELECT
	*
FROM ANALISE_PRECO
WHERE RANKG_PRECO <= 3


/*5. Maior compra de cada cliente
Na tabela Invoice, numere as notas fiscais de cada CustomerId da maior para a menor pelo campo Total, e devolva só a maior compra de cada cliente. 
Ordene o resultado final pelo Total decrescente.*/


WITH ANALISE_MAIOR_COMPRA(CustomerId,BillingAddress,InvoiceTotal,RANK_NOTAS)
AS
(
	SELECT
		CustomerId,
		BillingAddress,
		InvoiceTotal,
		ROW_NUMBER() OVER(PARTITION BY CustomerId ORDER BY InvoiceTotal DESC) AS 'RANK_NOTAS'
	FROM Invoice
)
SELECT 
	*
FROM ANALISE_MAIOR_COMPRA
WHERE RANK_NOTAS = 1
ORDER BY InvoiceTotal DESC