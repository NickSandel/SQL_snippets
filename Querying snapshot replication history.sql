SELECT *
FROM [distribution].[dbo].[MSsnapshot_history]
WHERE comments LIKE '%Financial%'
ORDER BY start_time DESC