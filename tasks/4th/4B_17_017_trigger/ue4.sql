-- create database sp
use sp

if object_id('SupplierParts', 'U') is not null
begin
 drop table SupplierParts;
end
go

if object_id('Suppliers', 'U') is not null
begin
 drop table Suppliers;
end
go

if object_id('Parts', 'U') is not null
begin
 drop table Parts;
end
go

create table Suppliers
(
  SupplierID       char(2) primary key,
  SupplierName     char(6),
  SupplierCity     char(6),
  SupplierDiscount decimal(2)  
 );
go

create table Parts
(
  PartID    char(2) primary key,
  PartName  char(8),
  PartColor char(5),
  PartPrice smallmoney,
  PartCity  char(6)
);
go

create table SupplierParts
(
  SupplierID char(2) references Suppliers(SupplierID),
  PartID     char(2) references Parts(PartID),
  Amount     decimal(4) 
primary key (SupplierID, PartID)
 );
go

set nocount on;
go

begin transaction;

insert into Suppliers values('L1', 'Schmid', 'London', 20);
insert into Suppliers values('L2', 'Jonas', 'Paris', 10);
insert into Suppliers values('L3', 'Berger', 'Paris', 30);
insert into Suppliers values('L4', 'Klein', 'London', 20);
insert into Suppliers values('L5', 'Adam', 'Athen', 30);

insert into Parts values ('T1', 'Mutter', 'rot', 12, 'London');
insert into Parts values ('T2', 'Bolzen', 'gelb', 17, 'Paris');
insert into Parts values ('T3', 'Schraube', 'blau', 17, 'Rom');
insert into Parts values ('T4', 'Schraube', 'rot', 14, 'London');
insert into Parts values ('T5', 'Welle', 'blau', 12, 'Paris');
insert into Parts values ('T6', 'Zahnrad', 'rot', 19, 'London');

insert into SupplierParts values ('L1', 'T1', 300);
insert into SupplierParts values ('L1', 'T2', 200);
insert into SupplierParts values ('L1', 'T3', 400);
insert into SupplierParts values ('L1', 'T4', 200);
insert into SupplierParts values ('L1', 'T5', 100);
insert into SupplierParts values ('L1', 'T6', 100);
insert into SupplierParts values ('L2', 'T1', 300);
insert into SupplierParts values ('L2', 'T2', 400);
insert into SupplierParts values ('L3', 'T2', 200);
insert into SupplierParts values ('L4', 'T2', 200);
insert into SupplierParts values ('L4', 'T4', 300);
insert into SupplierParts values ('L4', 'T5', 400);

commit;
go

create trigger InsteadOfInsUpdDel
on Parts
instead of insert, update, delete
as
begin
	if exists( select * from inserted ) and exists( select * from deleted )
	begin
		print 'Triggered by UPDATE'
	end
	else if exists( select * from inserted )
	begin
		print 'Triggered by INSERT'
	end
	else
	begin
		print 'Triggered by DELETE'
	end

	select *
	  from inserted
    select *
	  from deleted
end
go

-- Ganz viele verschiedene Testf�lle

begin transaction

update Parts set PartPrice = 250 where PartID  = 'T5'
insert into Parts values ('T7', 'Zahnrad', 'rot', 19, 'London');

rollback transaction;
go