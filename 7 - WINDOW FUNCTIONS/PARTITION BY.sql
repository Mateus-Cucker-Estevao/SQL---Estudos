
/* PARTICIONANDO OS DADOS E ORDENANDO ELES POR CADA DADOS */

SELECT 
       [TrackId]
      ,[Name]
      ,[Composer]
      ,[Milliseconds]
      ,[Bytes]
      ,[UnitPrice]
      ,ROW_NUMBER() OVER(ORDER BY Milliseconds ASC) AS 'ROW_NUMBER' --FUNÇAO PODEMOS USAR PARA CRIAR RANKING
      ,ROW_NUMBER() OVER(PARTITION BY Composer ORDER BY Milliseconds DESC) AS 'ROW_NUMBER_PARTITION_BY'  --O PARTITION BY, É USADO PARA PARTICIONAR OS DADOS E ORDERNAR A CADA UM DELES!
  FROM [Chinook].[dbo].[Track]
  WHERE Composer IS NOT NULL
