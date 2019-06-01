create database Catalog;
go
use Catalog;

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

create view RedParts
as select *
     from Parts
    where PartColor = 'rot';
go

--Übung 1

create view BlueParts
as select PartName, PartPrice
     from Parts
    where PartColor = 'blau';
go

select *
  from BlueParts
;
go

--Übung 2

create view PartsWithTax
as select PartID, PartName, PartColor, PartPrice * 1.2 "PriceWithTax", PartCity, PartPrice * 0.2 "Tax"
     from Parts
go	

select *
  from PartsWithTax
;
go

--Übung 3 

insert into RedParts values ('T7', 'Kreisel', 'rot', 16.00, 'Vienna');
go

select *
  from RedParts
;
go

insert into RedParts values ('T8', 'Kurbel', 'blau', 49.00, 'Madrid');
go

select *
  from RedParts
;
go

select *
  from Parts
;
go

create trigger RedPartsOnly
on RedParts
instead of insert
as
begin
	if exists(select *
	     from inserted
		where PartColor != 'rot'
	   )
	begin
		raiserror('ERROR', 16, 1);
		rollback;
	end
end
;
go

insert into RedParts values ('T9', 'asd', 'blau', 49.00, 'Madrid');
go

--Übung 4

insert into PartsWithTax values ('T9', 'asd', 'blau', 49.00, 'Madrid');
go
-- Update or insert of view or function 'PartsWithTax' failed because it contains a derived or constant field.

use master;
drop database Catalog;
go