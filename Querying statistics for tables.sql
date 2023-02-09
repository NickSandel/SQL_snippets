USE Observatory_LineLevel_GB                           --PEGASUS
go

SELECT sp.Stats_Id, stat.Name, sp.Last_updated, sp.rows, sp.Rows_Sampled, sp.Steps,
       sp.Unfiltered_rows, sp.Modification_Counter
FROM sys.stats as stat
CROSS APPLY sys.dm_db_stats_properties(stat.object_id, stat.stats_id) as sp
WHERE stat.object_id = Object_ID('obsfact.transactions');

SELECT stat.name AS 'Statistics',
 OBJECT_NAME(stat.object_id) AS 'Object',
 COL_NAME(scol.object_id, scol.column_id) AS 'Column',
 sp.Last_updated, sp.rows, sp.Rows_Sampled, sp.Steps,
       sp.Unfiltered_rows, sp.Modification_Counter
FROM sys.stats AS stat (NOLOCK) Join sys.stats_columns AS scol (NOLOCK)
 ON stat.stats_id = scol.stats_id AND stat.object_id = scol.object_id
 INNER JOIN sys.tables AS tab (NOLOCK) on tab.object_id = stat.object_id
CROSS APPLY sys.dm_db_stats_properties(stat.object_id, stat.stats_id) as sp
WHERE stat.name like '_WA%'
AND stat.object_id = Object_ID('obsfact.transactions')
ORDER BY stat.name