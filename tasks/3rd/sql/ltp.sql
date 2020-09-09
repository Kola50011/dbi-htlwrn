set nocount on

use ltp;

IF OBJECT_ID('ltp', 'U') IS NOT NULL 
  DROP TABLE ltp;
IF OBJECT_ID('l', 'U') IS NOT NULL 
  DROP TABLE l; 
IF OBJECT_ID('t', 'U') IS NOT NULL 
  DROP TABLE t; 
IF OBJECT_ID('p', 'U') IS NOT NULL
  DROP TABLE p;

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

create table p (
  pnr    char(2) primary key not null,
  pname  varchar(15) not null,
  stadt  varchar(6) not null
);

create table ltp (
  lnr    char(2) references l,
  tnr    char(2) references t,
  pnr    char(2) references p,
  menge  integer not null check(menge > 0),
  primary key(lnr, tnr, pnr)
);


-- DML

begin transaction;

delete from ltp;
delete from l;
delete from t;
delete from p;

begin transaction

-- l
insert into l values('L1','Schmid',20,'London');
insert into l values('L2','Jonas',10,'Paris');
insert into l values('L3','Berger',30,'Paris');
insert into l values('L4','Klein',20,'London');
insert into l values('L5','Adam',30,'Athen');

-- t
insert into t values('T1','Mutter','rot',12,'London');
insert into t values('T2','Bolzen','gelb',17,'Paris');
insert into t values('T3','Schraube','blau',17,'Rom');
insert into t values('T4','Schraube','rot',14,'London');
insert into t values('T5','Welle','blau',12,'Paris');
insert into t values('T6','Zahnrad','rot',19,'London');

-- p
insert into p values('P1','Flugzeug','Paris');
insert into p values('P2','Schiff','Rom');
insert into p values('P3','Seilbahn','Athen');
insert into p values('P4','Schiff','Athen');
insert into p values('P5','Eisenbahn','London');
insert into p values('P6','Flugzeug','Oslo');
insert into p values('P7','Autobus','London');

-- ltp
insert into ltp values('L1','T1','P1',200);
insert into ltp values('L1','T1','P4',700);
insert into ltp values('L2','T3','P1',400);
insert into ltp values('L2','T3','P2',200);
insert into ltp values('L2','T3','P3',200);
insert into ltp values('L2','T3','P4',500);
insert into ltp values('L2','T3','P5',600);
insert into ltp values('L2','T3','P6',400);
insert into ltp values('L2','T3','P7',800);
insert into ltp values('L2','T5','P2',100);
insert into ltp values('L3','T3','P1',200);
insert into ltp values('L3','T4','P2',500);
insert into ltp values('L4','T6','P3',300);
insert into ltp values('L4','T6','P7',300);
insert into ltp values('L5','T1','P4',100);
insert into ltp values('L5','T2','P2',200);
insert into ltp values('L5','T2','P4',100);
insert into ltp values('L5','T3','P4',200);
insert into ltp values('L5','T4','P4',800);
insert into ltp values('L5','T5','P4',400);
insert into ltp values('L5','T5','P5',500);
insert into ltp values('L5','T5','P7',100);
insert into ltp values('L5','T6','P2',200);
insert into ltp values('L5','T6','P4',500);

commit
go

--Alle Projekte im Detail
select l.lnr, t.tnr, p.pnr, l.lname, t.tname, p.pname, l.stadt, l.rabatt, t.preis, ltp.menge
  from l, t, p, ltp
 where
      l.lnr = ltp.lnr
	  and t.tnr = ltp.tnr
	  and p.pnr = ltp.pnr
;

--Projekte in London im Detail
select l.lnr, t.tnr, p.pnr, l.lname, t.tname, p.pname, l.stadt, l.rabatt, t.preis, ltp.menge
  from l, t, p, ltp
 where
      l.lnr = ltp.lnr
	  and t.tnr = ltp.tnr
	  and p.pnr = ltp.pnr
	  and l.stadt = 'london'
;

--Nummern der Lieferanten die das projekt P2 beliefern
select ltp.lnr, ltp.tnr, ltp.pnr
  from ltp
 where ltp.pnr = 'P2'
;

--Lieferungen mit einer Menge im Bereich von 300 bis 750
select l.lnr, t.tnr, p.pnr, l.lname, t.tname, p.pname, l.stadt, l.rabatt, t.preis, ltp.menge
  from l, t, p, ltp
 where
      l.lnr = ltp.lnr
	  and t.tnr = ltp.tnr
	  and p.pnr = ltp.pnr
	  and ltp.menge between 300 and 750
;

--D
select distinct t.stadt, t.farbe
  from t
;

--E
select *
  from ltp
 where menge > 0
   and menge is not null
;

--F
select p.pnr, p.stadt
  from p
 where p.stadt like '_o%'
;