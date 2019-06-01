-- A 1.1

create login catusr with password = 'topsecret',
       default_database = Catalog,
       check_expiration = off,
       check_policy = off;
go

-- Error 4064

-- A 1.2

use Catalog
go

create user catusr for login catusr;
go

-- Man kriegt keinen Fehler

-- A 1.3

-- Msg 229, Level 14, State 5, Line 4
-- The SELECT permission was denied on the object 'Parts', database 'Catalog', schema 'dbo'.


-- A 1.4

grant select
   on Parts
   to catusr
;
go

-- A 1.5

revoke select
   on Parts
   to catusr
;
go

create role catalog_reader;
go

grant select
   on Parts
   to catalog_reader;
go

alter role catalog_reader
  add member catusr;
go

-- Ja

-- A 2.1

grant select
   on Suppliers
   to catalog_reader;
go

grant select
   on SupplierParts
   to catalog_reader;
go

-- A 2.2

create login catapp with password = 'topsecret',
       default_database = Catalog,
       check_expiration = off,
       check_policy = off;
go

create user catapp for login catapp;
go

alter role catalog_reader
  add member catapp;
go

-- Ja

-- A 2.3

create role catalog_writer;
go

grant delete, update
   on Parts
   to catalog_writer;
go

grant delete, update
   on Suppliers
   to catalog_writer;
go

grant delete, update
   on SupplierParts
   to catalog_writer;
go

alter role catalog_writer
  add member catusr;
go

-- A 2.4

-- Nein, kann er nicht

-- A 3.1

use Catalog
go

SELECT p.NAME
,m.NAME
FROM sys.database_role_members rm
JOIN sys.database_principals p
ON rm.role_principal_id = p.principal_id
JOIN sys.database_principals m
ON rm.member_principal_id = m.principal_id 


-- A 3.2

drop user catapp
GO

create user catapp for login catapp ;
go

select *
  from master.sys.server_principals
 where default_database_name = 'Catalog'
;
go

SELECT p.NAME
,m.NAME
FROM sys.database_role_members rm
JOIN sys.database_principals p
ON rm.role_principal_id = p.principal_id
JOIN sys.database_principals m
ON rm.member_principal_id = m.principal_id

-- A 3.3

drop login catapp;
go

drop user catapp;
go

-- A 3.4

alter role catalog_writer
  drop member catusr;
go

drop role catalog_writer;
go