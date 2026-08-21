
/*ADICIONANDO UMA COLUNA COM OS NUMEROS DE LINHAS*/

SELECT 
       [TrackId]
      ,[Name]
      ,[AlbumId]
      ,[MediaTypeId]
      ,[GenreId]
      ,[Composer]
      ,[Milliseconds]
      ,[Bytes]
      ,[UnitPrice]
      ,ROW_NUMBER() OVER(ORDER BY Milliseconds ASC) AS 'ROW_NUMBER' --FUNÇAO PODEMOS USAR PARA CRIAR RANKING
  FROM [Chinook].[dbo].[Track]

  /* NESSE CASSO USAMOS O OVER PARA SELECIONAR UMA COLUNA E ORDENAR ELA DA MENOR PARA A MAIOR
