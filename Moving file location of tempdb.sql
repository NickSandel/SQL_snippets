USE tempdb

EXEC sp_Helpfile

use master

go

Alter database tempdb modify file (name = tempdev, filename = 'D:\Databases\DATA\tempdb.mdf')

go

Alter database tempdb modify file (name = templog, filename = 'D:\Databases\LOGS\templog.ldf')

go