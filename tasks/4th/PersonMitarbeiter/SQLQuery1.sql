-- 1A

create database PersonMitarbeiter
go
use PersonMitarbeiter
go

create table Person (
  PNr int primary key,
  Name varchar(32) not null,
  telefonnr varchar(32) not null
);
go

create table Mitarbeiter (
  PNr int primary key references Person,
  Eintrittsdat Date not null,
  Gehalt int not null
);
go

create table Kunde (
  PNr int primary key references Person,
  Rabatt int not null,
  Zahlungsbed varchar(64) not null
);
go

set dateformat dmy;

insert into Person values(1, 'Konstantin', '0699 1825 1387');
insert into Person values(2, 'Joel', '0800 800 800');
insert into Person values(3, 'Aleks', '0900 88 88 88');
insert into Person values(4, 'Grü', '0678 910 1112 13');
insert into Person values(5, 'Simon', '0699 6969 6969');
insert into Person values(6, 'Bend', '0699 ich bin fett');

insert into Mitarbeiter values(1, '21.03.1935', 100000);
insert into Mitarbeiter values(2, '01.04.1932', -10000);
insert into Mitarbeiter values(3, '27.01.1956', 100000);

insert into Kunde values(4, 0, 'Sofort zu zahlen');
insert into Kunde values(5, 0, '');
insert into Kunde values(6, 0, 'Inkassobüro eigeschaltet');

select *
  from Person, Mitarbeiter, Kunde
;
go

use master
drop database PersonMitarbeiter
go

-- 2

create database PersonMitarbeiter
go
use PersonMitarbeiter
go

create table Mitarbeiter (
  PNr int primary key,
  Name varchar(32) not null,
  telefonnr varchar(16) not null,
  Eintrittsdat Date not null,
  Gehalt int not null
);
go

create table Kunde (
  PNr int primary key,
  Name varchar(32) not null,
  telefonnr varchar(32) not null,
  Rabatt int not null,
  Zahlungsbed varchar(64) not null
);
go

set dateformat dmy;

insert into Mitarbeiter values(1, 'Konstantin', '0699 1825 1387', '21.03.1935', 100000);
insert into Mitarbeiter values(2, 'Joel', '0800 800 800', '01.04.1932', -10000);
insert into Mitarbeiter values(3, 'Aleks', '0900 88 88 88', '27.01.1956', 100000);

insert into Kunde values(4, 'Grü', '0678 910 1112 13', 0, 'Sofort zu zahlen');
insert into Kunde values(5, 'Simon', '0699 6969 6969', 0, '');
insert into Kunde values(6, 'Bend', '0699 ich bin fett', 0, 'Inkassobüro eigeschaltet');

select *
  from Mitarbeiter, Kunde
;
go

use master
drop database PersonMitarbeiter
go

-- 3

create database PersonMitarbeiter
go
use PersonMitarbeiter
go

create table Person (
  PNr int primary key,
  Name varchar(32) not null,
  telefonnr varchar(32) not null,
  Eintrittsdat Date null,
  Gehalt int null,
  Rabatt int null,
  Zahlungsbed varchar(64) null
);
go

insert into Person values(1, 'Konstantin', '0699 1825 1387', '21.03.1935', 100000, null, null);
insert into Person values(2, 'Joel', '0800 800 800', '01.04.1932', -10000, null, null);
insert into Person values(3, 'Aleks', '0900 88 88 88', '27.01.1956', 100000, null, null);
insert into Person values(4, 'Grü', '0678 910 1112 13', null, null, 0, 'Sofort zu zahlen');
insert into Person values(5, 'Simon', '0699 6969 6969', null, null, 0, '');
insert into Person values(6, 'Bend', '0699 ich bin fett', null, null, 0, 'Inkassobüro eigeschaltet');

select *
  from Person;

use master
drop database PersonMitarbeiter
go