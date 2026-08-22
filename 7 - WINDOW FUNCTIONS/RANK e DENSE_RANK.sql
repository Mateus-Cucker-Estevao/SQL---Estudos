
USE Chinook

SELECT 
       [TrackId]
      ,[Name]
      ,[AlbumId]
      ,[Milliseconds]
      ,[UnitPrice]
      ,ROW_NUMBER() OVER(ORDER BY Unitprice ASC) AS 'ROW_NUMBER' -- POSIÇÕES POR Unitprice
      ,RANK() OVER(ORDER BY Unitprice ASC) AS 'RANK' --DEIXNADO AS POSIÇÕES QUE SÃO IGUAIS COM O MESMO INDICE MAS PULA QUANDO TROCA A LINHA 
      ,DENSE_RANK() OVER(ORDER BY Unitprice ASC) AS 'DENSE_RANK' --DEIXNADO AS POSIÇÕES QUE SÃO IGUAIS COM O MESMO INDICE MAS CONTINUA QUANDO TROCA A LINHA 
  FROM [Chinook].[dbo].[Track]

 
