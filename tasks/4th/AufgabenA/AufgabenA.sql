-- Aufgabe A2
create database Catalog
    on (
           name = Catalog_dat,
       filename = 'C:\Temp\dbs\Catalog_dat.mdf',
           size = 10 MB,
        maxsize = 50 MB,
     filegrowth = 5 MB
   )
   log on (
           name = Catalog_log,
       filename = 'C:\Temp\dbs\Catalog_log.ldf',
           size = 2 MB,
        maxsize = 50 MB,
     filegrowth = 5 MB
   );
go

use Catalog;

CREATE TABLE Parts 
    (
     PartID VARCHAR (2) NOT NULL , 
     PartName VARCHAR (8) , 
     PartColor VARCHAR (6) , 
     PartPrice DECIMAL (6,2) , 
     PartCity VARCHAR (6) 
    )
    ON "default"
GO

ALTER TABLE Parts ADD CONSTRAINT Parts_PK PRIMARY KEY CLUSTERED (PartID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE SupplierParts 
    (
     SupplierID VARCHAR (2) NOT NULL , 
     PartID VARCHAR (2) NOT NULL , 
     Amount INTEGER 
    )
    ON "default"
GO

ALTER TABLE SupplierParts ADD CONSTRAINT SupplierParts_PK PRIMARY KEY CLUSTERED (SupplierID, PartID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE Suppliers 
    (
     SupplierID VARCHAR (2) NOT NULL , 
     SupplierName VARCHAR (6) , 
     SupplierCity VARCHAR (6) , 
     SupplierDiscount INTEGER 
    )
    ON "default"
GO

ALTER TABLE Suppliers ADD CONSTRAINT Suppliers_PK PRIMARY KEY CLUSTERED (SupplierID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

ALTER TABLE SupplierParts 
    ADD CONSTRAINT SupplierParts_Parts_FK FOREIGN KEY 
    ( 
     PartID
    ) 
    REFERENCES Parts 
    ( 
     PartID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE SupplierParts 
    ADD CONSTRAINT SupplierParts_Suppliers_FK FOREIGN KEY 
    ( 
     SupplierID
    ) 
    REFERENCES Suppliers 
    ( 
     SupplierID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

use Catalog

delete from SupplierParts;
delete from Suppliers;
delete from Parts;
go

insert into Suppliers values('L1', 'Schmid', 'London', 20)
insert into Suppliers values('L2',  'Jonas',  'Paris', 10)
insert into Suppliers values('L3', 'Berger',  'Paris', 30)
insert into Suppliers values('L4',  'Klein', 'London', 20)
insert into Suppliers values('L5',   'Adam',  'Athen', 30)
go

insert into Parts values('T1',   'Mutter',  'rot', 12, 'London')
insert into Parts values('T2',   'Bolzen', 'gelb', 17,  'Paris')
insert into Parts values('T3', 'Schraube', 'blau', 17,    'Rom')
insert into Parts values('T4', 'Schraube',  'rot', 14, 'London')
insert into Parts values('T5',    'Welle', 'blau', 12,  'Paris')
insert into Parts values('T6',  'Zahnrad',  'rot', 19, 'London')
go

insert into SupplierParts values('L1', 'T1', 300)
insert into SupplierParts values('L1', 'T2', 200)
insert into SupplierParts values('L1', 'T3', 400)
insert into SupplierParts values('L1', 'T4', 200)
insert into SupplierParts values('L1', 'T5', 100)
insert into SupplierParts values('L1', 'T6', 100)
insert into SupplierParts values('L2', 'T1', 300)
insert into SupplierParts values('L2', 'T2', 400)
insert into SupplierParts values('L3', 'T2', 200)
insert into SupplierParts values('L4', 'T2', 200)
insert into SupplierParts values('L4', 'T4', 300)
insert into SupplierParts values('L4', 'T5', 400)
go

-- Aufgabe A3

exec sp_addumpdevice @devtype = 'disk', 
                     @logicalname = 'BakCatalog', 
                     @physicalname = 'C:\Temp\backups\catalog.bak'
go

-- Aufgabe A4

--2. 10MB

--3.
backup database Catalog
to BakCatalog
with name = 'Be_Safe_Not_Sorry', init;
go

-- Aufgabe A5

insert into Parts values('T7',  'Feder',  'lila', 2, 'Paris')

backup database Catalog
to disk = 'C:\Temp\backups\catalog2.bak'
with differential, init;
go

--3: kleiner

-- Aufgabe A6

drop table SupplierParts;
drop table Suppliers;
drop table Parts;
go

use master;

restore database Catalog
from disk = 'C:\Temp\backups\catalog.bak'
with NORECOVERY
;
go

restore database Catalog
from disk = 'C:\Temp\backups\catalog2.bak'
;
go

use Catalog;
go

select *
  from Parts;
go

-- Aufgaben A8
delete from SupplierParts
delete from Suppliers;
delete from Parts;
go

use master;
go

restore database Catalog
from disk = 'C:\Temp\backups\catalog.bak'
with NORECOVERY
;
go

-- Aufgaben A9

use master;
drop database Catalog;

restore database Catalog
from disk = 'C:\Temp\backups\catalog.bak'
with move 'catalog_dat' to 'C:\Temp\backups\catalog.mdf',
     move 'catalog_log' to 'C:\Temp\backups\catalog_log.ldf';
;
go


-- Aufgabe A10

use Catalog;

CREATE TABLE i14086 
    (
     Name VARCHAR (32) NOT NULL
    )
    ON "default"
GO

insert into i14086 values ('Konstantin Lampalzer')

use master;
backup database Catalog
to disk = 'C:\Temp\backups\Sicherungsdatei.bak'
with init;
go

--restore database CatalogCopy
--from disk = 'C:\Temp\Sicherungsdateimitschüler.bak'
--;
--go

select *
  from sys.databases
;

drop database Catalog;

