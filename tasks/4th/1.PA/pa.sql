set nocount on
use pa;

-- Aufgabe 1
drop table DaysInMoth
go

create table DaysInMoth
(
	Month tinyint primary key,
	Days  tinyint
);
go

insert into DaysInMoth values(1, 31);
insert into DaysInMoth values(2, 29);
insert into DaysInMoth values(3, 31);
insert into DaysInMoth values(4, 30);
insert into DaysInMoth values(5, 31);
insert into DaysInMoth values(6, 30);
insert into DaysInMoth values(7, 31);
insert into DaysInMoth values(8, 31);
insert into DaysInMoth values(9, 30);
insert into DaysInMoth values(10, 31);
insert into DaysInMoth values(11, 30);
insert into DaysInMoth values(12, 31);
go

drop table DaysOfYear;
create table DaysOfYear
(
	Month tinyint check (Month > 0),
	DayOfMonth tinyint check (DayOfMonth > 0),
	WeekDay tinyint check (WeekDay > 0),
	DayOfYear int check (DayOfYear > 0),
	primary key (Month, DayOfMonth)
);
go

-- Aufgabe 2

declare @WeekDay tinyint = 7;
declare @Month tinyint = 1;
declare @DayOfMonth tinyint = 1;
declare @DayOfYear int = 1;
declare @DaysInCurrentMonth tinyint;

while @Month <= 12 and @DayOfMonth <= 31
begin
	insert into DaysOfYear values (@Month, @DayOfMonth, @WeekDay, @DayOfYear);

	select @DaysInCurrentMonth = Days
	  from DaysInMoth
	 where Month = @Month
	;

	if ( @DayOfMonth = @DaysInCurrentMonth )
		begin
		set @Month = @Month + 1;
		set @DayOfMonth = 1;
		end
	else
		begin
		set @DayOfMonth = @DayOfMonth + 1;
		end

	if (@WeekDay < 7)
		begin
		set @WeekDay = @WeekDay + 1;
		end
	else
		begin
		set @WeekDay = 1;
		end

	set @DayOfYear = @DayOfYear + 1;
end;
go

select *
  from DaysOfYear
 order by DayOfYear asc
;
go

-- Aufgabe 3

drop table DaysOfWeek;
create table DaysOfWeek
(
	Day tinyint primary key,
	Name varchar(16)
);
go

insert into DaysOfWeek values (1, 'Montag');
insert into DaysOfWeek values (2, 'Dienstag');
insert into DaysOfWeek values (3, 'Mittwoch');
insert into DaysOfWeek values (4, 'Donnerstag');
insert into DaysOfWeek values (5, 'Freitag');
insert into DaysOfWeek values (6, 'Samstag');
insert into DaysOfWeek values (7, 'Sonntag');
go

select Month, DayOfMonth,(
                         select Name
						   from DaysOfWeek
						  where Day = DaysOfYear.WeekDay
						 ) as "WeekDayName",
       DayOfYear
  from DaysOfYear
 order by DayOfYear asc
;
go

-- Aufgabe 4a
-- Wer ist f�r die Sicherung verantwortlich?
-- Wie h�ufig soll eine Datenbank gesichert werden?
-- Sollen alle Daten oder nur ein Teil davon gesichert werden?
-- Wie wird die Brauchbarkeit der Sicherungen �berpr�ft?
-- Wie lange dauert die Wiederherstellung der Datenbank? Anders gefragt: wie lange darf die Wiederherstellung dauern?
-- Wie lange ist der Aufbewahrungszeitraum f�r Sicherungen, d.h. wie weit zur�ck in die Vergangenheit soll man gehen k�nnen?
-- Auf welche Sicherungsmedien soll gesichert werden (B�nder, Festplatten, Netzlaufwerke)?
-- Wo werden �berall Sicherungsmedien aufbewahrt (Safe im Firmengeb�ude, Banksafe)?
-- Gegen welche Bedrohungsszenarien muss das Sicherungskonzept sch�tzen (Katastrophenplan)?
-- Wieviel Sicherheit kann oder will man sich leisten (Kostenfrage)?

-- Aufgabe 4b
-- B D F

-- Aufgabe 4c
-- A C F G J

backup database pa
to disk = 'C:\Temp\backups\pa.bak'
with name = 'reichstag_8888_FULL',
	 init
;
go

-- Aufgabe 5
create login calapp with password = 'topsecret',
       default_database = pa,
       check_expiration = off,
       check_policy = off;
go

create user calapp for login calapp;
go

create role powerusers;
go

grant select, insert, update, delete
   on DaysInMoth
   to powerusers;
go

alter role powerusers
 add member calapp;
go

alter role powerusers
 drop member calapp;
go

drop role powerusers;
go

drop user calapp;
go

drop login calapp;
go

-- Aufgabe 6

select distinct u1.CONSTRAINT_NAME
  from INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE u1,
       INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE u2	   
 where u1.TABLE_NAME = u2.TABLE_NAME
   and u1.COLUMN_NAME != u2.COLUMN_NAME
   and u1.CONSTRAINT_NAME not in (
                                 select rc.CONSTRAINT_NAME
								   from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
								 )
   and u1.CONSTRAINT_NAME = u2.CONSTRAINT_NAME                        
;
go