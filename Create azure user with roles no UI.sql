CREATE USER [SomeUser] WITH PASSWORD = 'SomePassword',DEFAULT_SCHEMA=[dbo]
GO

EXEC sp_addrolemember N'db_datareader', N'SomeUser'
GO

EXEC sp_addrolemember N'db_datawriter', N'SomeUser'
GO