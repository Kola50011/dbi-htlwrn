use lt;
--.Übung 1
-- b
drop view LTX;
go

create view LTX
AS
select lt.*, l.lname, t.tname
  from l, t, lt
  where lt.lnr = l.lnr
    and lt.tnr = t.tnr
;
go

-- Übung 2
-- a
select *
  from information_schema.columns
 where table_name = 'L'
;
go

--b
select *
  from information_schema.columns
 where column_name = 'STADT'
;

--c
select count(*)
  from information_schema.columns
 where table_name = 'lt'
;
go

--d
select count(*), table_name
 from information_schema.columns
group by table_name
;
go

--e
select count(*)
  from information_schema.table_constraints
 where table_name = 'lt'
   and CONSTRAINT_TYPE = 'FOREIGN KEY'
;
go

--f
select table_name
  from information_schema.table_constraints
 where CONSTRAINT_TYPE = 'PRIMARY KEY'
 group by table_name
 having count(*) > 1
 ;
 go

 --g
 select table_name
  from information_schema.table_constraints
 where CONSTRAINT_TYPE = 'FOREIGN KEY'
 group by table_name
 having count(*) > 1
 ;
 go

 --h
 select distinct table_name
   from information_schema.table_constraints
  where table_name not in (
						    select table_name
							  from information_schema.table_constraints
							 where CONSTRAINT_TYPE = 'UNIQUE'
							 group by table_name
					      )
 ;
 go

 --i
 select view_table_usage.table_name
   from information_schema.view_table_usage
  where VIEW_NAME = 'LTX'
;
go

 --j
 select view_table_usage.VIEW_NAME
   from information_schema.view_table_usage
;
go

 --k
  select tu1.VIEW_NAME
   from information_schema.view_table_usage tu1, information_schema.view_table_usage tu2
  where tu1.VIEW_NAME = tu2.VIEW_NAME
    and tu1.table_name = 'l'
	and tu2.table_name = 't'
;
go

--l
select table_name, count(*) as "anzahl"
  from information_schema.columns
 where DATA_TYPE = 'decimal'
 group by table_name
;
go

--m
select table_name, column_name
  from information_schema.columns
 where IS_NULLABLE = 'NO'
;
go

--n
select *
  from information_schema.constraint_column_usage
 where column_name = 'stadt'
   and CONSTRAINT_NAME like 'CK%'
;
go

--o
select distinct tc.table_name
  from information_schema.REFERENTIAL_CONSTRAINTS rc, information_schema.table_constraints tc
 where rc.UNIQUE_CONSTRAINT_NAME = tc.CONSTRAINT_NAME
   and rc.CONSTRAINT_NAME like 'FK%'
;
go
