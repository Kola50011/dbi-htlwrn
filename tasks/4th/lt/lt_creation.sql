--create database lt;
use lt;

drop TABLE Liefert
drop TABLE Lieferant
drop TABLE Teil
go

-- Error while generating DDL for Teil. See log file for details.

CREATE TABLE Lieferant 
    (
     LNR VARCHAR (2) NOT NULL , 
     LName VARCHAR (16) NOT NULL , 
     Rabatt INTEGER NOT NULL , 
     Stadt VARCHAR (16) NOT NULL 
    )
    ON "default"
GO

ALTER TABLE Lieferant ADD CONSTRAINT Lieferant_PK PRIMARY KEY CLUSTERED (LNR)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE Liefert 
    (
     Lieferant_LNR VARCHAR (2) NOT NULL , 
     Teil_TNR VARCHAR (2) NOT NULL , 
     Menge INTEGER NOT NULL 
    )
    ON "default"
GO

ALTER TABLE Liefert ADD CONSTRAINT Liefert_PK PRIMARY KEY CLUSTERED (Lieferant_LNR, Teil_TNR)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE Teil 
    (
     TNR VARCHAR (2) NOT NULL , 
     TName VARCHAR (16) NOT NULL , 
     Farbe VARCHAR (4) NOT NULL , 
     Preis INTEGER NOT NULL , 
     Stadt VARCHAR (16) NOT NULL 
    )
    ON "default"
GO

ALTER TABLE Teil ADD CONSTRAINT Teil_PK PRIMARY KEY CLUSTERED (TNR)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

ALTER TABLE Liefert 
    ADD CONSTRAINT Liefert_Lieferant_FK FOREIGN KEY 
    ( 
     Lieferant_LNR
    ) 
    REFERENCES Lieferant 
    ( 
     LNR 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Liefert 
    ADD CONSTRAINT Liefert_Teil_FK FOREIGN KEY 
    ( 
     Teil_TNR
    ) 
    REFERENCES Teil 
    ( 
     TNR 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO