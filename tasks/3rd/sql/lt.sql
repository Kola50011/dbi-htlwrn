-- DDL
use lt;

IF OBJECT_ID('lt', 'U') IS NOT NULL
  DROP TABLE lt;
IF OBJECT_ID('l', 'U') IS NOT NULL
  DROP TABLE l;
IF OBJECT_ID('t', 'U') IS NOT NULL
  DROP TABLE t;

create table l (
  lnr    char(2) primary key not null,
  lname  varchar(6) not null,
  rabatt integer not null check(rabatt > 0),
  stadt  varchar(6) not null
);

create table t (
  tnr    char(2) primary key not null,
  tname  varchar(8) not null,
  farbe  varchar(5) not null,
  preis  decimal(4, 2) not null,
  stadt  varchar(6) not null
);

create table lt (
  lnr    char(2) references l,
  tnr    char(2) references t,
  menge  integer not null check(menge > 0),
  primary key(lnr, tnr)
);


-- DML

begin transaction;

delete from lt;
delete from l;
delete from t;

insert into l values ('L1', 'Schmid', 20, 'London');
insert into l values ('L2', 'Jonas' , 10, 'Paris' );
insert into l values ('L3', 'Berger', 30, 'Paris' );
insert into l values ('L4', 'Klein' , 20, 'London');
insert into l values ('L5', 'Adam'  , 30, 'Athen' );

insert into t values ('T1', 'Mutter'  , 'rot' , 12, 'London');
insert into t values ('T2', 'Bolzen'  , 'gelb', 17, 'Paris' );
insert into t values ('T3', 'Schraube', 'blau', 17, 'Rom'   );
insert into t values ('T4', 'Schraube', 'rot' , 14, 'London');
insert into t values ('T5', 'Welle'   , 'blau', 12, 'Paris' );
insert into t values ('T6', 'Zahnrad' , 'rot' , 19, 'London');

insert into lt valueS ('L1', 'T1', 300);
insert into lt valueS ('L1', 'T2', 200);
insert into lt valueS ('L1', 'T3', 400);
insert into lt valueS ('L1', 'T4', 200);
insert into lt valueS ('L1', 'T5', 100);
insert into lt valueS ('L1', 'T6', 100);
insert into lt valueS ('L2', 'T1', 300);
insert into lt valueS ('L2', 'T2', 400);
insert into lt valueS ('L3', 'T2', 200);
insert into lt valueS ('L4', 'T2', 200);
insert into lt valueS ('L4', 'T4', 300);
insert into lt valueS ('L4', 'T5', 400);

commit;


-- DQL
select l.lnr, lname, t.tnr, menge, tname
  from lt, l, t
 where l.lnr = lt.lnr and t.tnr = lt.tnr
   and menge > 100
;

select l.lnr, lname, t.tnr, menge, tname
  from lt
  join l on lt.lnr = l.lnr
  join t on lt.tnr = t.tnr
  where menge > 100
;

select l1.lnr, l2.lnr
  from lt l1, lt l2
 where l1.tnr = 'T1' and l2.tnr='T2' and l1.lnr = l2.lnr
;

select l1.lnr, l2.lnr
  from lt l1 join lt l2 on l1.lnr = l2.lnr
 where l1.tnr = 'T1'
   and l2.tnr = 'T2'
;

select l1.lnr, l2.lnr
  from l l1, l l2
 where l1.lnr < l2.lnr
   and l1.stadt = l2.stadt
;

select l1.lname, l2.lname
  from l l1 join l l2 on l1.lnr < l2.lnr
 where l1.stadt = l2.stadt
;

select distinct lt.lnr, l.lname 
  from lt, l
 where lt.lnr = l.lnr
   and (
        (
		lt.lnr in (
                  select lnr
				    from lt
				   where tnr = 'T1'
                   )
		and not
		lt.lnr in (
                  select lnr
				    from lt
				   where tnr = 'T2'
                   )
	    )
		or
		(
		lt.lnr in (
                  select lnr
				    from lt
				   where tnr = 'T2'
                   )
		and not
		lt.lnr in (
                  select lnr
				    from lt
				   where tnr = 'T1'
                   )
		)
	   )
;
go

select lnr
  from lt
 where tnr in('T1', 'T2')
except
select lt1.lnr
  from lt lt1
  join lt lt2 on lt1.lnr = lt2.lnr
 where lt1.tnr = 'T1'
   and lt2.tnr = 'T2'
;
go

select distinct lnr
  from lt
 where menge < all (
				  select menge
                    from lt
                   where lnr = 'L4'
                  )
;
go

select distinct lnr
  from lt
 where menge < any (
				  select menge
                    from lt
                   where lnr = 'L4'
                  )
;
go

select distinct lnr
  from lt
 where menge < (
				  select min(menge)
                    from lt
                   where lnr = 'L4'
                  )
;
go

-- LNR, LNAME von Lieferanten, die Teile geliefer haben

-- 1. JOIN
select distinct l.lnr, l.lname
  from l join lt on l.lnr = lt.lnr
;
go

-- 2. Sub-Select(nicht korreliert)
select lnr, lname
  from l
 where lnr in(
             select lnr
			   from lt
             )
;
go

-- 3. Sub-Select(korreliert - mit exists)
select lnr, lname
  from l
 where exists(
             select lnr
			   from lt
			  where l.lnr = lt.lnr
             )
;
go
 
 -- LNR, LNAME von Lieferanten, die keine Teile geliefer haben

 -- 1. Sub-Select(korreliert - mit exists)
select lnr, lname
  from l
 where not exists(
             select lnr
			   from lt
			  where l.lnr = lt.lnr
             )
;
go

-- 2. Sub-Select(nicht korreliert)
select lnr, lname
  from l
 where lnr not in(
             select lnr
			   from lt
             )
;
go

-- 3. Mit Mengenoperationen
select lnr, lname
  from l
except
select l.lnr, l.lname
  from lt, l
 where lt.lnr = l.lnr
;
go

select lt.lnr, sum(menge * preis) "Umsatz"
  from lt, t
 where lt.tnr = t.tnr
 group by lnr
union
select lnr, 0
  from l
 where lnr not in (
				select lnr from lt
				)
;
go

select lnr
  from lt
 where tnr = 'T1'
intersect
select lnr
  from lt
 where tnr = 'T2'
;

-- Alle Lieferanten + anzahl der Lieferungen
select l.lnr, l.lname,
      (select count(lt.lnr)
	     from lt
		where l.lnr = lt.lnr
	  ) as "anzahl"
  from l
 order by anzahl desc
;
go

-- Alle Lieferanten + anzahl der Lieferungen + menge
select l.lnr, l.lname,
      (select count(lt.lnr)
	     from lt
		where l.lnr = lt.lnr
	  ) as "anzahl",
      (select sum(lt.menge)
	     from lt
		where l.lnr = lt.lnr)
 as menge
  from l
 order by anzahl desc
;
go


go

select count(*)
  from 
	  (
	  select lnr
        from lt
       group by lnr
      having count(lnr) > 1
	  ) "_"
;
go

-- alle menge + 10 %
-- Preise der roten Teile * 2
-- Preise * 2 und Städte auf Wien
begin transaction

update lt
   set menge = menge * 1.1
;
update t
   set preis = preis * 2
 where farbe = 'rot'
;
update t
   set preis = preis * 2, stadt = 'Wien'
 where farbe = 'rot'
;

rollback

select * from t