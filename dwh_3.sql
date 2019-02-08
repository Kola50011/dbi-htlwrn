drop table Verkaufszahl;
drop table Produkt;
drop table Ort;
drop table Zeit;

alter session
      set NLS_DATE_FORMAT = 'dd.mm.yyyy';
-- SET datestyle = "ISO, DMY";

create table ort (
    filiale varchar(32) primary key,
    stadt varchar(32) not null,
    region varchar(16) not null,
    land varchar(3) not null
);

create table zeit (
    datum date primary key,
    woche int not null,
    monat int not null,
    quartal int not null,
    jahr int not null
);

create table produkt (
    produkt varchar(32) primary key,
    marke varchar(32) not null,
    hersteller varchar(32) not null,
    produktgruppe varchar(32) not null
);

create table verkaufszahl (
    filiale varchar(32) not null references ort,
    produkt varchar(32) not null references produkt,
    datum date not null references zeit,
    anzahl int not null
);

insert into ort values('Hamburg', 'Hamburg', 'Nord', 'D');
insert into ort values('Leipzig', 'Leipzig', 'Ost', 'D');
insert into ort values('Stuttgart', 'Stuttgart', 'Süd', 'D');
insert into ort values('Bremen-Nord', 'Bremen', 'Nord', 'D');
insert into ort values('Bremen-Süd', 'Bremen', 'Nord', 'D');
insert into ort values('München', 'München', 'Süd', 'D');

insert into zeit values('5.1.2006', 1, 1, 1, 2006);
insert into zeit values('12.1.2006', 2, 1, 1, 2006);
insert into zeit values('13.2.2006', 7, 2, 1, 2006);
insert into zeit values('23.2.2006', 8, 2, 1, 2006);
insert into zeit values('4.3.2006', 9, 3, 2, 2006);
insert into zeit values('7.4.2006', 14, 4, 2, 2006);
insert into zeit values('25.4.2006', 17, 4, 2, 2006);

insert into produkt values('Pizza Funghi', 'Gourmet-Pizza', 'Frost GmbH', 'Tiefkühlkost');
insert into produkt values('Pizza Hawaii', 'Gourmet-Pizza', 'Frost GmbH', 'Tiefkühlkost');
insert into produkt values('Pizza Napoli', 'Pizza', 'TK-Pizza AG', 'Tiefkühlkost');
insert into produkt values('Pizza Vegetale', 'Good&Cheap', 'Frost GmbH', 'Tiefkühlkost');
insert into produkt values('Pizza Calzione', 'Pizza', 'TK-Pizza AG', 'Tiefkühlkost');

insert into verkaufszahl values('Hamburg', 'Pizza Funghi', '5.1.2006', 78);
insert into verkaufszahl values('Hamburg', 'Pizza Funghi', '12.1.2006', 67);
insert into verkaufszahl values('Leipzig', 'Pizza Hawaii', '12.1.2006', 42);
insert into verkaufszahl values('München', 'Pizza Calzione', '13.2.2006', 53);
insert into verkaufszahl values('Stuttgart', 'Pizza Napoli', '23.2.2006', 23);
insert into verkaufszahl values('Bremen-Nord', 'Pizza Funghi', '4.3.2006', 69);
insert into verkaufszahl values('Bremen-Süd', 'Pizza Vegetale', '7.4.2006', 45);
insert into verkaufszahl values('Stuttgart', 'Pizza Hawaii', '25.4.2006', 92);

-- 1)
select O.region, Z.quartal, P.marke, sum(V.anzahl) as "Anzahl"
  from ort O, zeit Z, produkt P, verkaufszahl V
 where O.filiale = V.filiale
   and P.produkt = V.produkt
   and Z.datum = V.datum
   and O.region = 'Nord'
   and Z.quartal in (1, 2)
   and P.marke in ('Gourmet-Pizza', 'Good&Cheap')
 group by O.region, Z.quartal, P.marke
 ;            

-- 2)
drop table bits;
create table bits as
select decode(P.marke, 'Gourmet-Pizza', 1, 0) as "B GourmetPizza",
       decode(P.marke, 'Good&Cheap', 1, 0) as "B GoodCheap",
       decode(z.quartal, 1, 1, 0) as "B Q2006Q1",
       decode(z.quartal, 2, 1, 0) as "B Q2006Q2",
       decode(O.region, 'Nord', 1, 0) as "B Nord",
       V.filiale, V.produkt, V.datum, V.anzahl
  from ort O, zeit Z, produkt P, verkaufszahl V
 where O.filiale = V.filiale
   and P.produkt = V.produkt
   and Z.datum = V.datum
;

select *
  from bits
;

-- 3)
CREATE OR REPLACE FUNCTION bitor(x NUMBER, y NUMBER) RETURN NUMBER DETERMINISTIC
IS
BEGIN
    RETURN x - bitand(x, y) + y;
END;
/

select bitand( bitand(
                bitor("B GourmetPizza", "B GoodCheap"),
                bitor("B Q2006Q1", "B Q2006Q2")
                ),
            "B Nord"
        ) as "B Res"
  from bits
;

-- 4)
select filiale, produkt, datum, anzahl
  from bits
 where bitand( bitand(
                bitor("B GourmetPizza", "B GoodCheap"),
                bitor("B Q2006Q1", "B Q2006Q2")
                ),
            "B Nord"
        ) = 1
;

-- 5)
select O.region, Z.quartal, P.marke, sum(B.anzahl) as "Anzahl"
  from bits B, ort O, zeit Z, produkt P
 where O.filiale = B.filiale
   and P.produkt = B.produkt
   and Z.datum = B.datum
   and bitand( bitand(
                "B GourmetPizza",
                bitor("B Q2006Q1", "B Q2006Q2")
                ),
            "B Nord"
        ) = 1
 group by O.region, Z.quartal, P.marke
;