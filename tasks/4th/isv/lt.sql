---------------------------------------------------
-- CREATE --
---------------------------------------------------
use master
drop database lt
go

create database lt
go

use lt
go

create table Suppliers 
    (
     SupplierID varchar (2) not null, 
     SupplierName varchar (18) not null, 
     SupplierDiscount integer not null, 
     SupplierCity varchar (18) not null, 
    )
GO

create table SupplierParts 
    (
     SupplierID varchar (2) not null , 
     PartID varchar (2) not null , 
     Amount integer not null 
    )
GO

create table Parts 
    (
     PartID varchar (2) not null , 
     PartName varchar (16) not null , 
     PartColor varchar (4) not null , 
     PartPrice integer not null , 
     PartCity varchar (16) not null 
    )
GO

---------------------------------------------------
-- ALTER --
---------------------------------------------------

alter table Suppliers
	add constraint PK_Suppliers primary key (SupplierID);
go

alter table Parts
	add constraint PK_Parts primary key (PartID);
go

alter table SupplierParts
	add constraint FK_SupplierParts_Supplier foreign key (SupplierID)
			references Suppliers (SupplierID),
		constraint FK_SupplierParts_Parts foreign key (PartID)
			references Parts (PartID);
go
