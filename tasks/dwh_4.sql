-- 3)
drop table verkaufszahl;
drop table produkt;
drop table zeit;
drop table ort;

set datestyle = "ISO, DMY";

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
) partition by range (datum);

create table verkaufszahl_vor_2005 partition of verkaufszahl
   for values from ('01-01-1990') to ('31-12-2004');

create table verkaufszahl_2005 partition of verkaufszahl
   for values from ('01-01-2005') to ('31-12-2005');

create table verkaufszahl_2006 partition of verkaufszahl
   for values from ('01-01-2006') to ('31-12-2006');

create table verkaufszahl_nach_2006 partition of verkaufszahl
   for values from ('01-01-2007') to ('31-12-2020');

-- 4)

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