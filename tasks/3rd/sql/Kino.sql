--use master;
--drop database Kino;
--create database Kino;
use Kino;

drop table spieltMit;
drop table Vorstellung;
drop table Saal;
drop table Kino;
drop table Film;
drop table Mitwirkender;
go

create table Mitwirkender (
	MitwNR int primary key,
	Vorname varchar(32) not null,
	Nachname varchar(32) not null,
	GebDatum Date not null,
	TodDatum Date null,
	check ( GebDatum < TodDatum )
);
go

create table Film (
	FilmNR int primary key,
	Titel varchar(32) not null check (Titel != ''),
	Jahr int not null,
	Dauer int not null check (Dauer > 0),
	Regisseur int references Mitwirkender
);
go

create table spieltMit (
	FilmNR int references Film,
	MitwNR int references Mitwirkender,
	primary key (FilmNR, MitwNR)
);

create table Kino (
	KinoNR	int primary key,
	Name	varchar(32) not null check(Name != ''),
	Ort		varchar(32) not null check(Ort != ''),
	PLZ		int	not null
);

create table Saal (
	KinoNR int references Kino,
	SaalNR int,
	primary key (SaalNR, KinoNR)	
);
go

create table Vorstellung (
	KinoNR int,
	SaalNR int,
	Beginnzeipunkt Date not null,
	FilmNR int references Film,
	primary key (KinoNR, SaalNR, Beginnzeipunkt),
	foreign key (KinoNR, SaalNR) references Saal
);
go