USE master
IF EXISTS(select * from sys.databases where name='person')
DROP DATABASE person
go

CREATE DATABASE person
go

use person

-- Generated by Oracle SQL Developer Data Modeler 17.2.0.188.1059
--   at:        2017-09-28 09:27:13 CEST
--   site:      SQL Server 2012
--   type:      SQL Server 2012



CREATE TABLE Course 
    (
     CourseID BIGINT NOT NULL , 
     Title VARCHAR (128) NOT NULL , 
     StartDate DATETIME NOT NULL , 
     Person_PersonID BIGINT NOT NULL 
    )
    ON "default"
GO

ALTER TABLE Course ADD CONSTRAINT Course_PK PRIMARY KEY CLUSTERED (CourseID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE Person 
    (
     PersonID BIGINT NOT NULL , 
     Name VARCHAR (128) NOT NULL , 
     Phone VARCHAR (128) NOT NULL , 
     Discount NUMERIC (5,2) , 
     TermsOfPayment VARCHAR (128) , 
     HiringDate DATE , 
     Salary NUMERIC (12,4) , 
     NumberAssistants INTEGER , 
     FeePerHour NUMERIC (10,2) 
    )
    ON "default"
GO

ALTER TABLE Person ADD CONSTRAINT Person_PK PRIMARY KEY CLUSTERED (PersonID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

ALTER TABLE Course 
    ADD CONSTRAINT Course_Person_FK FOREIGN KEY 
    ( 
     Person_PersonID
    ) 
    REFERENCES Person 
    ( 
     PersonID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             2
-- CREATE INDEX                             0
-- ALTER TABLE                              3
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0