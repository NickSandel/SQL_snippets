CREATE TABLE SimpleTable (ID INT NOT NULL IDENTITY(1,1), Name VARCHAR(10) NULL)
GO

CREATE TRIGGER SimpleTrigger ON SimpleTable
FOR UPDATE,INSERT
AS
BEGIN
	IF UPDATE(Name)
	PRINT 'Name is being updated'
END
GO

INSERT INTO SimpleTable (Name) VALUES ('Nick');

UPDATE SimpleTable SET Name = 'Not Nick' WHERE Name = 'Nick';