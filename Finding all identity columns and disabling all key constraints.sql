--select t.name, c.name, is_identity
--from sys.columns c
--JOIN sys.tables t ON c.object_id = t.object_id
--WHERE is_identity = 1
--ORDER BY t.name

--Disable all constraints
EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all"

--BEWARE, truncate will still not work as it doesn't check the content. It just checks if there is a constraint present. Instead use DELETE.

--Enable all constraints
exec sp_msforeachtable @command1="print '?'", @command2="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all"

--Finding foreign keys for a given table:
EXEC sp_fkeys 'ADD_INFO_META_DATA'

--Raw lookup syntax:
select t.name as TableWithForeignKey, fk.constraint_column_id as FK_PartNo , c.name as ForeignKeyColumn 
from sys.foreign_key_columns as fk
inner join sys.tables as t on fk.parent_object_id = t.object_id
inner join sys.columns as c on fk.parent_object_id = c.object_id and fk.parent_column_id = c.column_id
order by TableWithForeignKey, FK_PartNo