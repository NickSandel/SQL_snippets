--Truncate all the tables! Mwah ha ha! Could also turn into DELETE easily if TRUNCATE falls foul of constraints
SELECT CONCAT('TRUNCATE TABLE [', SCHEMA_NAME(schema_id), '].[', name,'];')
FROM sys.tables
WHERE is_ms_shipped = 0
AND name NOT IN ('__RefactorLog', 'sysdiagrams')
ORDER BY SCHEMA_NAME(schema_id), name

--Delete + list schema and table names
SELECT CONCAT('DELETE FROM [', SCHEMA_NAME(schema_id), '].[', name,'];'), CONCAT('[', SCHEMA_NAME(schema_id), '].[', name,']')
FROM sys.tables
WHERE is_ms_shipped = 0
AND name NOT IN ('__RefactorLog', 'sysdiagrams')
ORDER BY SCHEMA_NAME(schema_id), name