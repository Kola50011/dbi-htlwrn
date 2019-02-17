-- 1)
drop table zeit;

alter session
      set NLS_DATE_FORMAT = 'dd.mm.yyyy';

create table zeit (
    datum date primary key,
    woche int not null,
    monat int not null,
    quartal int not null,
    jahr int not null
);

insert into zeit values('5.12.2006', 49, 12, 4, 2006);
insert into zeit values('12.1.2006',  6,  1, 1, 2006);
insert into zeit values('23.3.2006', 12,  3, 1, 2006);
insert into zeit values('4.5.2006' , 18,  5, 2, 2006);
insert into zeit values('7.1.2006' ,  6,  1, 1, 2006);
insert into zeit values('13.7.2006', 28,  7, 3, 2006);
insert into zeit values('7.8.2006' , 32,  8, 3, 2006);
insert into zeit values('13.5.2006', 19,  5, 2, 2006);

-- 2)
drop table bitmap;

create table bitmap (
    datum date primary key,
    B1  int not null,
    B2  int not null,
    B3  int not null,
    B4  int not null,
    B5  int not null,
    B6  int not null,
    B7  int not null,
    B8  int not null,
    B9  int not null,
    B10 int not null,
    B11 int not null,
    B12 int not null
);

insert into bitmap values ('5.12.2006', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1);
insert into bitmap values ('12.1.2006', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
insert into bitmap values ('23.3.2006', 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
insert into bitmap values ('4.5.2006' , 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1);
insert into bitmap values ('7.1.2006' , 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
insert into bitmap values ('13.7.2006', 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1);
insert into bitmap values ('7.8.2006' , 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1);
insert into bitmap values ('13.5.2006', 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1);

-- 4)
-- Bereich von Februar bis einschließlich Mai („Januar“ < x ≤ „Mai“)
select zeit.*
  from zeit, bitmap
 where zeit.datum = bitmap.datum
   and B1 = 0
   and B5 = 1
;

-- Bereich bis einschließlich Juni (x ≤ „Juni“)
select zeit.*
  from zeit, bitmap
 where zeit.datum = bitmap.datum
   and B6 = 1
;

-- Bereich ab August (x > „Juli“)
select zeit.*
  from zeit, bitmap
 where zeit.datum = bitmap.datum
   and B7 = 0
;