--use master;
--drop DATABASE sf;
--create database sf;
use sf;
go

set nocount on

drop table besucht;
drop table kveranst;
drop table geeignet;
drop table setztvor;
drop table kurs;
drop table referent;
drop table person;
go

create table person
(
  pnr      integer primary key,
  fname    char(16) not null,
  vname    char(16) not null,
  ort      char(10) not null,
  land     char(3) check (land in ('A', 'D', 'F', 'GB', 'I', 'RUS'))
);
go

create table referent
(
  pnr      integer primary key references person,
  gebdat   date not null,
  seit     date not null,
  titel    char(6), -- NULL bedeutet kein Titel
  check (gebdat < seit)
);
go

create table kurs
(
  knr      integer primary key,
  bezeichn char(20) not null,
  tage     integer not null check (tage between 1 and 10),
  preis    money not null
);
go

create table setztvor
(
  knr      integer references kurs,
  knrvor   integer references kurs,
  primary key (knr, knrvor),
  check (knr <> knrvor) -- Ein Kurs kann sich nicht selbst als Voraussetzung haben
);
go

create table geeignet
(
  knr      integer references kurs,
  pnr      integer references referent,
  primary key (knr, pnr)
);
go

create table kveranst
(
  knr      integer references kurs,
  knrlfnd  integer,
  von      date not null,
  bis      date not null,
  ort      char(10) not null,
  plaetze  integer not null,
  pnr      integer references referent, -- nicht NOT NULL, da 0 bei (0, 1)
  primary key (knr, knrlfnd),
  check (von <= bis)
);
go

create table besucht
(
  knr      integer,
  knrlfnd  integer,
  pnr      integer references person,
  bezahlt  date, -- NULL bedeutet nicht bezahlt
  primary key (knr, knrlfnd, pnr),
  foreign key (knr, knrlfnd) references kveranst -- Zusammengesetzter FK, da der PK in kveranst ebenfalls zusammengesetzt ist
);
go

-- DML

begin transaction;

delete from besucht;
delete from kveranst;
delete from geeignet;
delete from setztvor;
delete from kurs;
delete from referent;
delete from person;
go

set dateformat dmy;

insert into person values (101, 'Bach',          'Johann Sebastian', 'Leipzig',  'D');
insert into person values (102, 'Händel',        'Georg Friedrich',  'London',   'GB');
insert into person values (103, 'Haydn',         'Joseph',           'Wien',     'A');
insert into person values (104, 'Mozart',        'Wolfgang Amadeus', 'Salzburg', 'A');
insert into person values (105, 'Beethoven',     'Ludwig van',       'Wien',     'A');
insert into person values (106, 'Schubert',      'Franz',            'Wien',     'A');
insert into person values (107, 'Berlioz',       'Hector',           'Paris',    'F');
insert into person values (108, 'Liszt',         'Franz',            'Wien',     'A');
insert into person values (109, 'Wagner',        'Richard',          'München',  'D');
insert into person values (110, 'Verdi',         'Giuseppe',         'Busseto',  'I');
insert into person values (111, 'Bruckner',      'Anton',            'Linz',     'A');
insert into person values (112, 'Brahms',        'Johannes',         'Wien',     'A');
insert into person values (113, 'Bizet',         'Georges',          'Paris',    'F');
insert into person values (114, 'Tschaikowskij', 'Peter',            'Moskau',   'RUS');
insert into person values (115, 'Puccini',       'Giacomo',          'Mailand',  'I');
insert into person values (116, 'Strauss',       'Richard',          'München',  'D');
insert into person values (117, 'Schönberg',     'Arnold',           'Wien',     'A');

insert into referent values (101, '21.03.1935', '01.01.1980', null);
insert into referent values (103, '01.04.1932', '01.01.1991', null);
insert into referent values (104, '27.01.1956', '01.07.1985', null);
insert into referent values (111, '04.09.1924', '01.07.1990', 'Mag');
insert into referent values (114, '25.04.1940', '01.07.1980', null);
insert into referent values (116, '11.06.1964', '01.01.1994', 'Dr');

insert into kurs values (1, 'Notenkunde',        2, 1400.00);
insert into kurs values (2, 'Harmonielehre',     3, 2000.00);
insert into kurs values (3, 'Rhythmik',          1,  700.00);
insert into kurs values (4, 'Instrumentenkunde', 2, 1500.00);
insert into kurs values (5, 'Dirigieren',        3, 1900.00);
insert into kurs values (6, 'Musikgeschichte',   2, 1400.00);
insert into kurs values (7, 'Komposition',       4, 3000.00);

insert into setztvor values (2, 1);
insert into setztvor values (3, 1);
insert into setztvor values (5, 2);
insert into setztvor values (5, 3);
insert into setztvor values (5, 4);
insert into setztvor values (7, 5);
insert into setztvor values (7, 6);

insert into geeignet values (1, 103);
insert into geeignet values (1, 114);
insert into geeignet values (2, 104);
insert into geeignet values (2, 111);
insert into geeignet values (3, 103);
insert into geeignet values (4, 104);
insert into geeignet values (5, 101);
insert into geeignet values (5, 114);
insert into geeignet values (6, 111);
insert into geeignet values (7, 103);
insert into geeignet values (7, 116);

insert into kveranst values (1, 1, '07.04.2003', '08.04.2003', 'Wien',    3, 103);
insert into kveranst values (1, 2, '23.06.2004', '24.06.2004', 'Moskau',  4, 114);
insert into kveranst values (1, 3, '10.04.2005', '11.04.2005', 'Paris',   3, null);
insert into kveranst values (2, 1, '09.10.2003', '11.10.2003', 'Wien',    4, 104);
insert into kveranst values (3, 1, '17.11.2003', '17.11.2003', 'Moskau',  3, 103);
insert into kveranst values (4, 1, '12.01.2004', '13.01.2004', 'Wien',    3, 116);
insert into kveranst values (4, 2, '28.03.2004', '29.03.2004', 'Wien',    4, 104);
insert into kveranst values (5, 1, '18.05.2004', '20.05.2004', 'Paris',   3, 101);
insert into kveranst values (5, 2, '23.09.2004', '26.09.2004', 'Wien',    2, 101);
insert into kveranst values (5, 3, '30.03.2005', '01.04.2005', 'Rom',     3, null);
insert into kveranst values (7, 1, '09.03.2005', '13.03.2005', 'Wien',    5, 103);
insert into kveranst values (7, 2, '14.09.2005', '18.09.2005', 'München', 4, 116);

insert into besucht values (1, 1, 108, '01.05.2003');
insert into besucht values (1, 1, 109, null);
insert into besucht values (1, 1, 114, null);
insert into besucht values (1, 2, 110, '01.07.2004');
insert into besucht values (1, 2, 112, '03.07.2004');
insert into besucht values (1, 2, 113, '20.07.2004');
insert into besucht values (1, 2, 116, null);
insert into besucht values (1, 3, 110, null);
insert into besucht values (2, 1, 105, '15.10.2003');
insert into besucht values (2, 1, 109, '03.11.2003');
insert into besucht values (2, 1, 112, '28.10.2003');
insert into besucht values (2, 1, 116, null);
insert into besucht values (3, 1, 101, null);
insert into besucht values (3, 1, 109, null);
insert into besucht values (3, 1, 117, '20.11.2003');
insert into besucht values (4, 1, 102, '20.01.2004');
insert into besucht values (4, 1, 107, '01.02.2004');
insert into besucht values (4, 1, 111, null);
insert into besucht values (4, 2, 106, '07.04.2004');
insert into besucht values (4, 2, 109, '15.04.2004');
insert into besucht values (5, 1, 103, null);
insert into besucht values (5, 1, 109, '07.06.2004');
insert into besucht values (5, 2, 115, '07.10.2004');
insert into besucht values (5, 2, 116, null);
insert into besucht values (7, 1, 109, '20.03.2005');
insert into besucht values (7, 1, 113, null);
insert into besucht values (7, 1, 117, '08.04.2005');

commit;

--4) + name
select distinct kurs.knr, kurs.bezeichn
  from setztvor, kurs
 where kurs.knr = setztvor.knr
;
go

--5)
select knr, bezeichn, preis, preis / tage as tagespreis
  from kurs
 where tage between 2 and 4
   and preis / tage <= 700
;
go

--6)
select fname
  from person
 where vname like '% %'
   and(
      lower(ort) like '%a%a%'
      or lower(ort) like '%e%e%'
      or lower(ort) like '%i%i%'
      or lower(ort) like '%o%o%'
      or lower(ort) like '%u%u%'
   )
;
go

--7)
select distinct pnr
  from besucht
 where bezahlt is null
 order by pnr asc
;
go

--8)
select knr, knrlfnd, DATEDIFF(day, von, bis)
  from kveranst
 where pnr in (103, 104)
   and ort = 'Wien'
;
go

--9)
select pnr
  from referent
 where datediff(year, gebdat, getDate()) > 75
 ;
 go

 --10)
select pnr
  from besucht
union
select pnr
  from kveranst
 where not pnr is null
;
go

--11)
select kurs.knr, bezeichn, knrlfnd, von
  from kveranst, kurs
 where pnr is null
   and kurs.knr = kveranst.knr
;
go

--12)
select distinct kurs.knr, bezeichn, kveranst.knrlfnd, von
  from kveranst, kurs, besucht
 where kurs.knr = kveranst.knr
   and kveranst.knr = besucht.knr
   and kveranst.knrlfnd = besucht.knrlfnd
;
go

--13)
select distinct kurs.knr, bezeichn, kveranst.knrlfnd, von
  from kveranst, kurs, besucht
 where kurs.knr = kveranst.knr
   and kveranst.knr = besucht.knr
   and kveranst.knrlfnd = besucht.knrlfnd
   and not kveranst.pnr is null
;
go

--14)
select referent.pnr, person.fname, kurs.bezeichn
  from referent, besucht, person, kurs
 where referent.pnr = besucht.pnr
   and not bezahlt is null
   and person.pnr = referent.pnr
   and kurs.knr = besucht.knr
;
go

--15)
select bezeichn, pers.vname "vname bes", pers.fname "fname bes", ref.vname "vname ref", ref.fname "fname ref"
  from besucht, kurs, kveranst, person pers, person ref
 where besucht.knr = kurs.knr
   and kveranst.knr = besucht.knr
   and kveranst.knrlfnd = besucht.knrlfnd
   and besucht.pnr = pers.pnr
   and kveranst.pnr = ref.pnr
   order by bezeichn, von
;
go

--16)
select distinct bezeichn, von
  from referent, besucht, kurs, kveranst
 where referent.pnr = besucht.pnr
   and kurs.knr = besucht.knr
   and kveranst.knr = besucht.knr
   and kveranst.knrlfnd = besucht.knrlfnd
;
go

--17)
select besucht.pnr, von
  from besucht, kveranst, kurs
 where kveranst.knr = besucht.knr
   and kveranst.knrlfnd = besucht.knrlfnd
   and besucht.pnr = kveranst.pnr
   and kurs.knr = besucht.knr
;
go

--18)
select distinct fname
  from person, kurs, besucht b1, besucht b2
 where person.pnr = b1.pnr
   and person.pnr = b2.pnr
   and b1.knr = 1
   and b2.knr = 5
;
go

--19)
select bezeichn, von, bis, preis/tage "tagespreis"
  from kurs, kveranst, referent
 where preis/tage between 610 and 690
   and kurs.knr = kveranst.knr
   and referent.pnr = kveranst.pnr
   and titel is null
;
go

--20/a)
select distinct kveranst.knr, kveranst.knrlfnd, von, bis, bezahlt
  from kveranst, besucht
 where kveranst.knrlfnd = besucht.knrlfnd
   and besucht.knr = kveranst.knr
   and datediff(day, bezahlt, von) < 0
;
go

--20/b)
select distinct kveranst.knr, kveranst.knrlfnd, von, bis, bezahlt
  from kveranst, besucht
 where kveranst.knrlfnd = besucht.knrlfnd
   and besucht.knr = kveranst.knr
   and bezahlt between von and bis
;
go

--20/c)
select distinct kveranst.knr, kveranst.knrlfnd, von, bis, bezahlt
  from kveranst, besucht
 where kveranst.knrlfnd = besucht.knrlfnd
   and besucht.knr = kveranst.knr
   and datediff(day, bezahlt, von) > datediff(day, von, bis)
;
go

--21)
select fname
  from person, besucht, kveranst
 where person.pnr = besucht.pnr
   and kveranst.knr = besucht.knr
   and kveranst.knrlfnd = besucht.knrlfnd
   and kveranst.ort = person.ort
   and datediff(day, von, bis) >= 2
 order by fname
;
go

--22)
select kurs.bezeichn, kveranst.knrlfnd
  from kveranst, kurs, geeignet
 where kveranst.knr = kurs.knr
   and geeignet.pnr = kveranst.pnr
   and geeignet.knr = kveranst.knr
;
go

--23a)
select referent.pnr, person.vname, person.fname
  from kveranst, referent, person
 where kveranst.pnr = referent.pnr
   and kveranst.pnr = person.pnr
   and kveranst.von < referent.seit
;
go

--23b)
select referent.pnr, person.vname, person.fname
  from kveranst, referent, person
 where kveranst.pnr = referent.pnr
   and kveranst.pnr = person.pnr
   and kveranst.von > referent.seit
;
go

--24)
select person.pnr, person.fname
  from person, besucht, kveranst
 where besucht.pnr = person.pnr
   and kveranst.knrlfnd = besucht.knrlfnd
   and kveranst.knr = besucht.knr
   and kveranst.ort = 'Wien'
union
select person.pnr, person.fname
  from person, kveranst
 where person.pnr = kveranst.pnr
   and kveranst.ort = 'Wien'
;
go

--25)
select datediff(day, von, bis) "Wahre Dauer", tage
  from kveranst, kurs
 where kveranst.knr = kurs.knr
;
go

--26)
select distinct person.pnr, person.vname, person.fname
  from person, referent, kveranst
 where person.pnr = kveranst.pnr
   and referent.pnr = kveranst.pnr
   and datediff(year, gebdat, von) > 60
;
go

--27)
select  * 
  from setztvor, kveranst k, kveranst vor
 where setztvor.knr = k.knr
   and setztvor.knrvor = vor.knr
   and k.von > vor.von
   and k.ort = vor.ort
;
go

--28)
select distinct *
  from kveranst k, kveranst ueber
 where (ueber.von between k.von and k.bis
    or ueber.bis between k.von and k.bis)
   and (k.knr != ueber.knr
    or k.knrlfnd != ueber.knrlfnd)
;
go

--29)
select *
  from besucht, kveranst k, kveranst ueber, person
 where besucht.knr = k.knr
   and besucht.knrlfnd = k.knrlfnd
   and besucht.pnr = person.pnr
   and (ueber.von between k.von and k.bis
    or ueber.bis between k.von and k.bis)
   and (k.knr != ueber.knr
    or k.knrlfnd != ueber.knrlfnd)
;
go

--30)
select *
  from kveranst k, kveranst ueber, referent, person
 where k.pnr = person.pnr
   and k.pnr = referent.pnr
   and (k.knr != ueber.knr
    or k.knrlfnd != ueber.knrlfnd)
   and (ueber.von between k.von and k.bis
    or ueber.bis between k.von and k.bis)
;
go

-- 31)
select *
  from referent
 where not exists(
				 select pnr
				   from geeignet
				  where referent.pnr = geeignet.pnr
				 )
;
go

-- 32)
select *
  from kurs
 where preis <= (
				select preis
				  from kurs
				 where bezeichn = 'Dirigieren'
                )
;
go

-- 33)
select *
  from kurs
 where kurs.preis > (
                    select max(preis)
					  from kveranst, kurs
					 where kveranst.knr = kurs.knr
					   and kveranst.ort = 'Paris'
					)
;
go

-- 34)
select *
  from kurs
 where not exists(
                 select * 
				   from setztvor
				  where kurs.knr = setztvor.knr
                 )
;
go

-- 35)
select *
  from person
 where not exists (
                  select *
				    from besucht, kveranst
				   where besucht.pnr = person.pnr
				     and besucht.knr = kveranst.knr
					 and besucht.knrlfnd = kveranst.knrlfnd
					 and (
					     year(von) = 2003
						 or year(von) = 2005
						 or year(bis) = 2003
						 or year(bis) = 2005
					 )
                  )
;
go

-- 36)
select *
  from person
 where not exists (
                  select *
				    from besucht, kveranst
				   where besucht.pnr = person.pnr
				     and besucht.knr = kveranst.knr
					 and besucht.knrlfnd = kveranst.knrlfnd
					 and (
					     year(von) = 2003
						 or year(bis) = 2003
	  				 )
                  )
   and not exists (
                  select *
				    from besucht, kveranst
				   where besucht.pnr = person.pnr
				     and besucht.knr = kveranst.knr
					 and besucht.knrlfnd = kveranst.knrlfnd
					 and (
					     year(von) = 2005
						 or year(bis) = 2005
	  				 )
                  )
;
go

-- 37)
select *
  from person, besucht, kurs
 where besucht.pnr = person.pnr
   and besucht.knr = kurs.knr
   and kurs.preis < (select max(preis)
					   from kveranst, kurs
					  where kveranst.knr = kurs.knr
					    and kveranst.ort = 'Moskau'
                    )
;

-- Einfügen
insert into kurs values (8, 'Violine für Anfänger', 9, 3000.00);

select knr
  from kurs
 where knr = 8
;

select *
  from kurs
 where kurs.tage >= 4
;

update kurs
   set preis = preis * 1.1
 where tage >= 4
;

select *
  from kurs
 where kurs.tage >= 4
;

select * from kveranst for xml auto