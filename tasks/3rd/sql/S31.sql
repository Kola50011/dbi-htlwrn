--create database S31;
use S31;

drop table Kurs;
drop table F�hrungskraft;
drop table Kursreferent;
drop table Mitarbeiter;


create table Mitarbeiter (
  PersNr integer primary key,
  Name   varchar(16) not null,
  Adresse varchar(64) not null
);

create table F�hrungskraft (
  PersNr integer primary key references Mitarbeiter,
  �berstundenpauschale integer null,
  AnzSekret�rinnen integer null,
  GeleiteteAbteilung varchar(32) null
);

create table Kursreferent (
  PersNr integer primary key references Mitarbeiter,
  Stundenkosten integer not null,
  GehalteneKursstunden integer not null
);

create table Kurs (
  KNr integer primary key,
  Titel varchar(128) not null,
  PersNr integer references Kursreferent
);

insert into Mitarbeiter values (1, 'Koka', 'Koka Stra�e 1, Somewhere In Nowhere');
insert into Mitarbeiter values (2, 'Gr�', 'Heurigerstra�e 1, Somewhere In Nowhere');
insert into Mitarbeiter values (3, 'Marcel', 'Stra�e 88, Braunau am Inn');
insert into Mitarbeiter values (4, 'Bernd', 'McDonalds Pottendorferstra�e 45 1, Wiener Neustadt');
insert into Mitarbeiter values (5, 'Sch�dl', '****, Burgenland');
insert into Mitarbeiter values (6, 'Yunus', 'Istanbul, T�rkei');

insert into F�hrungskraft values (1, 10000, 10, null);
insert into F�hrungskraft values (3, 100, 5, 'F�hrungsabteilung');
insert into F�hrungskraft values (4, 1, 1, 'Produkt Test');
insert into F�hrungskraft values (5, 1, 1, 'Zoll');
insert into F�hrungskraft values (6, 0, 0, 'Facility management');

insert into Kursreferent values (1, 1000, 4);
insert into Kursreferent values (2, 50, 10);
insert into Kursreferent values (3, 100, 1);
insert into Kursreferent values (4, 88, 5);
insert into Kursreferent values (6, 10, 100);

insert into Kurs values (1, '10.000 Euro in 30 Tagen mit nur 4 Euro Einsatz!', 1);
insert into Kurs values (2, 'Hygiene am Arbeitspatz', 4);
insert into Kurs values (3, 'Richtig F�hren', 3);
insert into Kurs values (4, 'T�rkisch f�r Anf�nger', 6);
insert into Kurs values (5, 'Kochkurs', 2);

select Name, Adresse
  from Mitarbeiter
;

select count(*) as 'Anzahl Mitarbeiter'
 from Mitarbeiter
;

select Kurs.Titel, Mitarbeiter.Name, Kursreferent.Stundenkosten
  from Kurs, Mitarbeiter, Kursreferent
 where Kurs.PersNr = Mitarbeiter.PersNr
   and Kurs.PersNr = Kursreferent.PersNr
;

select Mitarbeiter.Name, Mitarbeiter.Adresse, Kursreferent.Stundenkosten, Kursreferent.GehalteneKursstunden
  from Mitarbeiter, Kursreferent
 where Mitarbeiter.PersNr = Kursreferent.PersNr
;

select Mitarbeiter.Name, Mitarbeiter.Adresse, F�hrungskraft.GeleiteteAbteilung, F�hrungskraft.AnzSekret�rinnen
  from Mitarbeiter, F�hrungskraft
 where Mitarbeiter.PersNr = F�hrungskraft.PersNr
;

--use master;
--drop database S31;