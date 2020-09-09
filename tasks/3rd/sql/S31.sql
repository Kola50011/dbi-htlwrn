--create database S31;
use S31;

drop table Kurs;
drop table Führungskraft;
drop table Kursreferent;
drop table Mitarbeiter;


create table Mitarbeiter (
  PersNr integer primary key,
  Name   varchar(16) not null,
  Adresse varchar(64) not null
);

create table Führungskraft (
  PersNr integer primary key references Mitarbeiter,
  Überstundenpauschale integer null,
  AnzSekretärinnen integer null,
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

insert into Mitarbeiter values (1, 'Koka', 'Koka Straße 1, Somewhere In Nowhere');
insert into Mitarbeiter values (2, 'Grü', 'Heurigerstraße 1, Somewhere In Nowhere');
insert into Mitarbeiter values (3, 'Marcel', 'Straße 88, Braunau am Inn');
insert into Mitarbeiter values (4, 'Bernd', 'McDonalds Pottendorferstraße 45 1, Wiener Neustadt');
insert into Mitarbeiter values (5, 'Schädl', '****, Burgenland');
insert into Mitarbeiter values (6, 'Yunus', 'Istanbul, Türkei');

insert into Führungskraft values (1, 10000, 10, null);
insert into Führungskraft values (3, 100, 5, 'Führungsabteilung');
insert into Führungskraft values (4, 1, 1, 'Produkt Test');
insert into Führungskraft values (5, 1, 1, 'Zoll');
insert into Führungskraft values (6, 0, 0, 'Facility management');

insert into Kursreferent values (1, 1000, 4);
insert into Kursreferent values (2, 50, 10);
insert into Kursreferent values (3, 100, 1);
insert into Kursreferent values (4, 88, 5);
insert into Kursreferent values (6, 10, 100);

insert into Kurs values (1, '10.000 Euro in 30 Tagen mit nur 4 Euro Einsatz!', 1);
insert into Kurs values (2, 'Hygiene am Arbeitspatz', 4);
insert into Kurs values (3, 'Richtig Führen', 3);
insert into Kurs values (4, 'Türkisch für Anfänger', 6);
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

select Mitarbeiter.Name, Mitarbeiter.Adresse, Führungskraft.GeleiteteAbteilung, Führungskraft.AnzSekretärinnen
  from Mitarbeiter, Führungskraft
 where Mitarbeiter.PersNr = Führungskraft.PersNr
;

--use master;
--drop database S31;