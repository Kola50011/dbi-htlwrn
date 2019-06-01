create database LogDB;
go

use LogDB;
go

create table DDLLog
(
  ID int identity primary key,
  Date datetime not null default getdate(),
  LogText xml 
);
go

create trigger AfterAlterCreateDropTable
on database
after DDL_TABLE_EVENTS
as
begin
    print 'ALTER / TABLE / DROP detected.';
	insert into DDLLog("LogText") values (eventdata())
end
go

---------

select * from DDLLog;

create table Suppliers
(
  SupplierID       char(2) primary key
 );
go

alter table Suppliers add SupplierName char(2);
go

drop table Suppliers;
go

select * from DDLLog;

-------------

alter table DDLLog add UserName varchar(50);
alter table DDLLog add TableName varchar(50);
alter table DDLLog add EventName varchar(15);
alter table DDLLog add Command varchar(max);
go

drop trigger AfterAlterCreateDropTable on database;
go

create trigger AfterAlterCreateDropTable
on database
after DDL_TABLE_EVENTS
as
begin
	declare @event xml = eventdata();
	declare @userName varchar(50) = convert(varchar(50), @event.query('data(//UserName)'));
	declare @tableName varchar(50) = convert(varchar(50), @event.query('data(//ObjectName )'));
	declare @eventName varchar(15) = convert(varchar(15), @event.query('data(//EventType)'));
	declare @command varchar(max) = convert(varchar(max), @event.query('data(//TSQLCommand/CommandText)'));

    print 'ALTER / TABLE / DROP detected.';
	insert into DDLLog("LogText", "UserName", "TableName", "EventName", "Command") values (@event, @userName, @tableName, @eventName, @command)
end
go

---------

select * from DDLLog;

create table Suppliers
(
  SupplierID       char(2) primary key
 );
go

alter table Suppliers add SupplierName char(2);
go

drop table Suppliers;
go

select * from DDLLog;

-------------

use master;
go

drop database LogDB;
go
