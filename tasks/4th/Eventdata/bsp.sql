-- Übung 1
create database noTables;
go

use noTables;
go

create trigger SorryNoNewTables
on database
after create_table
as
begin
    select eventdata();
    raiserror('Sorry, no new tables allowed in this database.', 16, 1);
    rollback;
end
go

create table Suppliers
(
  SupplierID       char(2) primary key,
  SupplierName     char(6),
  SupplierCity     char(6),
  SupplierDiscount decimal(2),
  TotalAmount      int
 );
go

use master
drop database noTables
go

-- Übung 2

create database noTables;
go

use noTables;
go

create trigger BlockAlterDrop on database
after drop_table, alter_table
as
begin
    declare @Data xml = eventdata();
    
    select @Data.query('data(/EVENT_INSTANCE/PostTime)') as "Event Time",
           @Data.query('data(/EVENT_INSTANCE/EventType)') as "Event Type",
           @Data.query('data(/EVENT_INSTANCE/ServerName)') as "Server Name",
           @Data.query('data(/EVENT_INSTANCE/TSQLCommand/CommandText)') as "Command Text";
           
    print 'ALTER / DROP TABLE statements are not allowed in this database.';
    rollback;
end
go

create table Suppliers
(
  SupplierID       char(2) primary key,
  SupplierName     char(6),
  SupplierCity     char(6),
  SupplierDiscount decimal(2),
  TotalAmount      int
 );
go

drop table Suppliers;
go

use master
drop database noTables