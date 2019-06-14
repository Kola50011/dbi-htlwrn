USE master
IF EXISTS(select * from sys.databases where name='person')
DROP DATABASE person
go

CREATE DATABASE person
go

use person


-- Generated by Oracle SQL Developer Data Modeler 17.2.0.188.1059
--   at:        2017-09-28 09:24:09 CEST
--   site:      SQL Server 2012
--   type:      SQL Server 2012



CREATE TABLE Course 
    (
     CourseID BIGINT NOT NULL , 
     Title VARCHAR (128) NOT NULL , 
     StartDate DATETIME NOT NULL , 
     CourseInstructor_PersonID BIGINT NOT NULL 
    )
    ON "default"
GO

ALTER TABLE Course ADD CONSTRAINT Course_PK PRIMARY KEY CLUSTERED (CourseID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE CourseInstructor 
    (
     PersonID BIGINT NOT NULL , 
     FeePerHour NUMERIC (10,2) NOT NULL 
    )
    ON "default"
GO

ALTER TABLE CourseInstructor ADD CONSTRAINT CourseInstructor_PK PRIMARY KEY CLUSTERED (PersonID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE Customer 
    (
     PersonID BIGINT NOT NULL , 
     Discount NUMERIC (5,2) NOT NULL , 
     TermsOfPayment VARCHAR (128) NOT NULL 
    )
    ON "default"
GO

ALTER TABLE Customer ADD CONSTRAINT Customer_PK PRIMARY KEY CLUSTERED (PersonID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE Employee 
    (
     PersonID BIGINT NOT NULL , 
     HiringDate DATE NOT NULL , 
     Salary NUMERIC (12,4) 
    )
    ON "default"
GO

ALTER TABLE Employee ADD CONSTRAINT Employee_PK PRIMARY KEY CLUSTERED (PersonID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE Manager 
    (
     PersonID BIGINT NOT NULL , 
     NumberAssistants INTEGER NOT NULL 
    )
    ON "default"
GO

ALTER TABLE Manager ADD CONSTRAINT Manager_PK PRIMARY KEY CLUSTERED (PersonID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
     ON "default" 
    GO

CREATE TABLE Person 
    (
     PersonID BIGINT NOT NULL , 
     Name VARCHAR (128) NOT NULL , 
     Phone VARCHAR (128) NOT NULL 
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
    ADD CONSTRAINT Course_CourseInstructor_FK FOREIGN KEY 
    ( 
     CourseInstructor_PersonID
    ) 
    REFERENCES CourseInstructor 
    ( 
     PersonID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE CourseInstructor 
    ADD CONSTRAINT CourseInstructor_Employee_FK FOREIGN KEY 
    ( 
     PersonID
    ) 
    REFERENCES Employee 
    ( 
     PersonID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Customer 
    ADD CONSTRAINT Customer_Person_FK FOREIGN KEY 
    ( 
     PersonID
    ) 
    REFERENCES Person 
    ( 
     PersonID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Employee 
    ADD CONSTRAINT Employee_Person_FK FOREIGN KEY 
    ( 
     PersonID
    ) 
    REFERENCES Person 
    ( 
     PersonID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Manager 
    ADD CONSTRAINT Manager_Employee_FK FOREIGN KEY 
    ( 
     PersonID
    ) 
    REFERENCES Employee 
    ( 
     PersonID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             11
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