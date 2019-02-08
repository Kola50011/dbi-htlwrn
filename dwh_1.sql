drop tablespace dwh including contents and datafiles cascade constraints;

create tablespace dwh
       datafile 'c:\oraclexe\app\oracle\oradata\xe\streets.dbf' 
       size 10m reuse 
       autoextend on maxsize 30m;

drop table Verkaufszahl;
drop table Produkt;
drop table Ort;
drop table Zeit;

create table Produkt (
    produkt         varchar(64) primary key,
    marke           varchar(64),
    hersteller      varchar(64),
    produktgruppe   varchar(54)
);

create table Ort (
    filiale varchar(64) primary key,
    stadt   varchar(64),
    region  varchar(64),
    land    varchar(64)
);

create table Zeit (
    datum   date primary key,
    woche   int,
    monat   int,
    quartal int,
    jahr    int
);

create table Verkaufszahl (
    filiale references Ort,
    produkt references Produkt,
    datum references Zeit,
    anzahl int    
);

insert into Ort values ('Hamburg', 'Hamburg', 'Nord', 'D');
insert into Ort values ('Leipzig', 'Leipzig', 'Ost', 'D');
insert into Ort values ('Stuttgart', 'Stuttgart', 'Süd', 'D');
insert into Ort values ('Bremen-Nord', 'Bremen', 'Nord', 'D');
insert into Ort values ('Bremen-Süd', 'Bremen', 'Nord', 'D');
insert into Ort values ('München', 'München', 'Süd', 'D');

insert into Produkt values ('Pizza Funghi', 'Gourmet-Pizza', 'Frost GmbH', 'Tiefkühlkost');
insert into Produkt values ('Pizza Hawaii', 'Gourmet-Pizza', 'Frost GmbH', 'Tiefkühlkost');
insert into Produkt values ('Pizza Napoli', 'Pizza', 'TK-Pizza AG', 'Tiefkühlkost');
insert into Produkt values ('Pizza Vegetale', 'Good&Cheap', 'Frost GmbH', 'Tiefkühlkost');
insert into Produkt values ('Pizza Calzione', 'Pizza', 'TK-Pizza AG', 'Tiefkühlkost');

insert into Verkaufszahl ('Hamburg', 'Pizza Funghi', '', 78);
insert into Verkaufszahl ('Hamburg', 'Pizza Funghi', '', 67);
insert into Verkaufszahl ('Leipzig', 'Pizza Hawaii', '', 42);
insert into Verkaufszahl ('München', 'Pizza Calzione', '', 53);
insert into Verkaufszahl ('Stuttgart', 'Pizza Napoli', '', 23);
insert into Verkaufszahl ('Bremen-Nord', 'Pizza Funghi', '', 69);
insert into Verkaufszahl ('Bremen-Süd', 'Pizza Vegetale', '', 45);
insert into Verkaufszahl ('Stuttgart', 'Pizza Hawaii', '', 92);
