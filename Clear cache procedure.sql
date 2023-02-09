EXEC master.[dbo].[sp_DbccDropCleanBuffers]

--Proper cache clearing for use on dev
dbcc freeproccache
dbcc dropcleanbuffers