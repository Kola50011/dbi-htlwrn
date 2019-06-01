set nocount on;

create database lt;
go

use lt;
go


CREATE TABLE l (
       lnr    CHAR(2) PRIMARY KEY,
       lname  CHAR(6),
       rabatt DECIMAL(2),
       stadt  CHAR(6));

CREATE TABLE t (
       tnr    CHAR(2) PRIMARY KEY,
       tname  CHAR(8),
       farbe  CHAR(5),
       preis  DECIMAL(10,2),
       stadt  CHAR(6));

CREATE TABLE lt (
       lnr    CHAR(2) REFERENCES l,
       tnr    CHAR(2) REFERENCES t,
       menge  DECIMAL(4) NOT NULL CHECK(menge>0),
       PRIMARY KEY (lnr,tnr));
go

create clustered index IX_l_lname_stadt
    on l (lname, stadt)
;
go

create nonclustered index IX_l_lname_stadt
    on l (lname, stadt)
;
go

select * from sys.key_constraints;
select * from sys.foreign_keys;
go

-- foreign key droppen
DECLARE @table NVARCHAR(512), @sql NVARCHAR(MAX);
SELECT @table = N'dbo.lt';
SELECT @sql = 'ALTER TABLE ' + @table 
    + ' DROP CONSTRAINT ' + name + ';'
    FROM sys.foreign_keys
    WHERE [parent_object_id] = OBJECT_ID(@table);
EXEC sp_executeSQL @sql;
go
DECLARE @table NVARCHAR(512), @sql NVARCHAR(MAX);
SELECT @table = N'dbo.lt';
SELECT @sql = 'ALTER TABLE ' + @table 
    + ' DROP CONSTRAINT ' + name + ';'
    FROM sys.foreign_keys
    WHERE [parent_object_id] = OBJECT_ID(@table);
EXEC sp_executeSQL @sql;
go
-- pk droppen
DECLARE @table NVARCHAR(512), @sql NVARCHAR(MAX);
SELECT @table = N'dbo.l';
SELECT @sql = 'ALTER TABLE ' + @table 
    + ' DROP CONSTRAINT ' + name + ';'
    FROM sys.key_constraints
    WHERE [parent_object_id] = OBJECT_ID(@table);
EXEC sp_executeSQL @sql;
go
DECLARE @table NVARCHAR(512), @sql NVARCHAR(MAX);
SELECT @table = N'dbo.l';
SELECT @sql = 'ALTER TABLE ' + @table 
    + ' DROP CONSTRAINT ' + name + ';'
    FROM sys.key_constraints
    WHERE [parent_object_id] = OBJECT_ID(@table);
EXEC sp_executeSQL @sql;
go


select * from sys.key_constraints;
select * from sys.foreign_keys;
go

go
use master;
go

drop database lt;
