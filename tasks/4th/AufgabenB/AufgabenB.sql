-- Aufgabe B1

use master; 
go

if db_id('testdb') is not null drop database testdb;
go
 
create database testdb 
on ( 
 name = testdb_dat, 
 filename = 'C:\Temp\dbs\testdb.mdf'
) 
log on ( 
 name = testdb_log, 
 filename = 'C:\Temp\dbs\testdb.ldf'
);
go

-- Aufgabe B2

alter database testdb
  set recovery full;
go

select name, recovery_model_desc
  from sys.databases
 where name = 'testdb'
;
go

use testdb;
go

dbcc sqlperf(logspace);
go

-- Aufgabe B3

backup database testdb
to disk = 'C:\Temp\backups\testdb.bak'
with init;
go

-- Aufgabe B4

use testdb;
go

if object_id('dbo.LogTest') is not null drop table dbo.LogTest;
go

select top 1000000 
       identity(int, 1, 1) SomeID, 
       abs(checksum(newid())) % 50000 + 1 SomeInt, 
       char(abs(checksum(newid())) % 26 + 65) + 
       char(abs(checksum(newid())) % 26 + 65) SomeLetters2, 
       cast(abs(checksum(newid())) % 10000 / 100.0 as money) SomeMoney, 
       cast(rand(checksum(newid())) * 3653.0 + 36524.0 as datetime) SomeDate, 
       right(newid(), 12) SomeHex12 
  into dbo.LogTest 
  from sys.all_columns ac1 cross join sys.all_columns ac2
; 
go

use testdb;
go

dbcc sqlperf(logspace);
go

-- Aufgabe B5

backup log testdb
to disk = 'C:\Temp\backups\testdb.trn'
with init;
go

-- Aufgaben B6
use master;
go

drop database testdb;
go

