drop table verkaufszahl;
drop table produkt;
drop table ort;
drop table zeit;

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

-- 3)
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
drop materialized view rmj;

create materialized view rmj as 
    select o.region, p.marke, z.jahr, sum(v.anzahl) as anzahl
      from verkaufszahl v join ort o on v.filiale = o.filiale
      join zeit z on v.datum = z.datum
      join produkt p on v.produkt = p.produkt
    group by o.region, p.marke, z.jahr
;

-- 2)
select o.region, z.jahr, p.hersteller
  from verkaufszahl v
       join ort o on v.filiale = o.filiale
       join zeit z on v.datum = z.datum
       join produkt p on v.produkt = p.produkt
 where o.region = 'Nord'
   and z.jahr = 2006
 group by o.region, z.jahr, p.hersteller
;

-- 3)
select o.region, z.jahr, p.hersteller
  from rmj
       join ort o on rmj.region = o.region
       join zeit z on rmj.jahr = z.jahr
       join produkt p on rmj.marke = p.marke
 where o.region = 'Nord'
   and z.jahr = 2006
 group by o.region, z.jahr, p.hersteller
;