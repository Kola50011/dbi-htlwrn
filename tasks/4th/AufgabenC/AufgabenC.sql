use master;
drop database Catalog;

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

alter database Catalog
  set recovery full;
go

-- Aufgaben C1
backup database Catalog
to disk = 'C:\Temp\backups\catalog_full.bak'
with name = 'CATALOG_FULL_WE', init;
go

select *
  from Parts;
go

-- Aufgaben C2
insert into Parts values ('T8', 'Niete', 'gelb', 3.50, 'London');
go

backup database Catalog
to disk = 'C:\Temp\backups\catalog_diff.bak'
with name = 'CATALOG_MO_DIFF', init, DIFFERENTIAL;
go

-- Aufgaben C3
insert into Parts values ('T9', 'Scheibe', 'cyan', 5.00, 'London');
go

backup database Catalog
to disk = 'C:\Temp\backups\catalog_diff.bak'
with name = 'CATALOG_DI_DIFF', DIFFERENTIAL;
go

-- Aufgaben C4

insert into Parts values ('TA', 'Ring', 'grau', 1.75, 'London');
go

backup log Catalog
to disk = 'C:\Temp\backups\catalog_mi_log.bak'
with name = 'CATALOG_MI_LOG', init;
go

insert into Parts values ('TB', 'Haken', 'orange', 2.90, 'Paris');
go

-- Aufgaben C5

use Catalog;
go

select *
  from Parts;
go

--	Msg 0, Level 11, State 0, Line 186
-- The connection is broken and recovery is not possible.  The client driver attempted to recover the connection one or more times and all attempts failed.  Increase the value of ConnectRetryCount to increase the number of recovery attempts.


-- Aufgabe C6

backup log catalog
to disk = 'C:\Temp\backups\catalog_log_postcrash.bak'
with name = 'CATALOG_LOG_POSTCRASH', init, no_truncate;
go


-- Aufgabe C7

use master;
drop database Catalog;

restore database Catalog
from disk = 'C:\Temp\backups\catalog_full.bak'
with norecovery;
go

restore headeronly
from disk = 'C:\Temp\backups\catalog_diff.bak'
;
go

restore database Catalog
from disk = 'C:\Temp\backups\catalog_diff.bak'
with norecovery, file = 2
;
go

restore log Catalog
from disk = 'C:\Temp\backups\catalog_mi_log.bak'
with norecovery;
go

restore database Catalog
from disk = 'C:\Temp\backups\catalog_log_postcrash.bak'
with recovery;
go

-- Aufgabe C8

use Catalog;
go

select *
  from Parts
go
