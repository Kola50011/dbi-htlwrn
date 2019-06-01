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

create trigger AfterDelUpdDDLLog
on DDLLog
after update, delete
as
begin
    raiserror('No direct UPDATE or DELETE on DDLLog. Your attempt has been logged.', 16, 1);
	rollback;
end
go

create trigger AfterInsDDLLog
on DDLLog
after insert
as
begin
	select trigger_nestlevel()
    raiserror('No direct UPDATE or DELETE on DDLLog. Your attempt has been logged.', 16, 1);
	rollback;
end
go

use master;
go

drop database LogDB;
go
