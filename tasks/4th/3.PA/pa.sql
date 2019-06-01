create database pa;
go

use pa;
go

set nocount on;
set dateformat dmy;

-- 3. Praktische Arbeit
-- Wie immer alle Lösungen ohne Haftung für richtigkeit

--License

 --           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 --                   Version 2, December 2004

 --Copyright (C) 2004 Sam Hocevar
 -- 14 rue de Plaisance, 75014 Paris, France
 --Everyone is permitted to copy and distribute verbatim or modified
 --copies of this license document, and changing it is allowed as long
 --as the name is changed.

 --           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 --  TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

 -- 0. You just DO WHAT THE FUCK YOU WANT TO.


-- Angabe

create table MonthNames
(
	MonthNum int primary key,
	NameDE varchar(10),
	NameEN varchar(10),
	NameFR varchar(10)
);
go

begin transaction;
insert into MonthNames values(5, 'Mai', 'May', 'mai');
insert into MonthNames values(6, 'Juni', 'June', 'juin');
insert into MonthNames values(7, 'Juli', 'July', 'juillet');
commit;
go

-- Aufgabe 1a

create function dbo.MonthName(@Month int, @Language char(2))
returns table as
return
	select case @Language
				when 'de' then NameDE
				when 'en' then NameEN
				when 'fr' then NameFR
		   end as "Name"
	  from MonthNames
	 where MonthNum = @Month
go

-- Aufgabe 1b

select * from dbo.MonthName(7, 'de');
select * from dbo.MonthName(7, 'en');
select * from dbo.MonthName(7, 'fr');
go

-- Aufgabe 2a

create function dbo.Translate(@Language char(2), @DE varchar(10), 
							  @EN varchar(10), @FR varchar(10))
returns varchar(10)
with schemabinding as
begin
	return case @Language
				when 'de' then @DE
				when 'en' then @EN
				when 'fr' then @FR
		   end
end
go

select dbo.Translate('fr', 'Sonntag', 'Sunday', 'Dimanche') "Translation";
go

-- Aufgabe 2b

create function dbo.WeekdayNames(@Language char(2))
returns @WeekDayName table
	(
		Day int,
		WeekDayName varchar(10)
	)
as
begin
	insert into @WeekDayName values ( 1, dbo.Translate(@Language, 'Sonntag'   , 'Sunday'   , 'Dimanche' ) );
	insert into @WeekDayName values ( 2, dbo.Translate(@Language, 'Montag'    , 'Monday'   , 'Lundi'    ) );
	insert into @WeekDayName values ( 3, dbo.Translate(@Language, 'Dienstag'  , 'Tuesday'  , 'Mardi'    ) );
	insert into @WeekDayName values ( 4, dbo.Translate(@Language, 'Mittwoch'  , 'Wednesday', 'Mercredi' ) );
	insert into @WeekDayName values ( 5, dbo.Translate(@Language, 'Donnerstag', 'Thrusday' , 'Jeudi'    ) );
	insert into @WeekDayName values ( 6, dbo.Translate(@Language, 'Freitag'   , 'Friday'   , 'Vendredi' ) );
	insert into @WeekDayName values ( 7, dbo.Translate(@Language, 'Samstag'   , 'Saturnday', 'Samedi'   ) );
	return
end
go

-- Aufgabe 2c

select *
  from dbo.WeekdayNames('fr')
;
go

-- Aufgabe 3a

create table MeterReadings
(
	ReadingDate date primary key,
	MeterReading float not null
);
go

create table KWhUsed
(
	ReadingDate date primary key,
	Month int not null,
	Year int not null,
	KWhUsed float null
);
go

create trigger AfterInsertMeterReadings
on MeterReadings
after insert as
begin
	-- Leichte, schönere, aber illegale Lösung -> top haben wir noch nicht gelernt
	--select top 1 @LastReading = MeterReadings.MeterReading
	--  from MeterReadings, inserted
	-- where MeterReadings.ReadingDate < inserted.ReadingDate
	-- order by MeterReadings.ReadingDate desc
	--;

	declare @LastReading float;
	declare @LastMonth int;
	declare @LastYear int;

	select @LastMonth = case month(ReadingDate)
				when 1 then 12
				else month(ReadingDate) - 1
		   end,
	       @LastYear = case month(ReadingDate)
				when 1 then year(ReadingDate) - 1
				else year(ReadingDate)
		   end
	  from inserted

	select @LastReading = MeterReading
	  from MeterReadings
	 where ReadingDate between datefromparts(@LastYear, @LastMonth, 1) and datefromparts(@LastYear, @LastMonth, 28)


	insert into KWhUsed
	select ReadingDate,
	       @LastMonth,
	       @LastYear,
		   case 
		        when inserted.MeterReading - @LastReading is null then 0
				else inserted.MeterReading - @LastReading
		   end
	  from inserted
end
go

-- Aufgabe 3b

insert into MeterReadings values ('2010-01-01', 15376.0);
insert into MeterReadings values ('2010-02-01', 15657.7);
insert into MeterReadings values ('2010-03-01', 15896.1);
insert into MeterReadings values ('2010-04-01', 16172.1);
go

select *
  from KWhUsed
;
go

-- Max verbrauch

-- EZ Lösung, illegal -> TOP
--select top 1 *
--  from KWhUsed
-- order by KWhsed desc
--;
--go

-- Hässliche Lösung ( Wie Bernd )
select *
  from KWhUsed
 where KWhUsed = (
				  select max(KWhUsed)
				    from KWhUsed
				 )
;
go

-- Aufgabe 4a

create trigger AfterInsUpdDelKWhUsed
on KWhUsed
after insert, update, delete as
begin
	if trigger_nestlevel() = 1
	begin
		raiserror('AfterInsUpdDelKWhUsed: Direct manipulation of KWhUsed not allowed!', 16, 1);
		rollback;
	end
end
go

-- Aufgabe 4b

--insert into KWhUsed values ( getdate(), 1, 1, 1);
--go
--update KWhUsed set year = 1;
--go
--delete KWhUsed
--go
--insert into MeterReadings values ('2010-05-01', 16192.1);
--go

--select *
--  from KWhUsed
--;
--go

-- Aufgabe 5a

create table TamperingLog
(
    ID int identity primary key,
    Date datetime not null default getdate(),
    LoginName varchar(32),
    EventType varchar(24),
    LogText xml
);
go

create trigger ProtectKWhUsed
on database
after drop_table, alter_table
as
begin
	declare @Data xml = eventdata();
	declare @Table varchar(64);
	
	select @Table = convert(varchar(64), @Data.query('data(/EVENT_INSTANCE/ObjectName)') );
	
	if @Table =  'KWhUsed'
	begin
		rollback
		insert into TamperingLog (LoginName, EventType, LogText)
		values (
				convert(varchar(32) ,@Data.query('data(/EVENT_INSTANCE/LoginName)')),
				convert(varchar(24), @Data.query('data(/EVENT_INSTANCE/EventType)')),
				@Data
			   )
		;
		raiserror('ProtectKWhUsed: Your attempt to tamper with KWhUsed has been logged!', 16, 1);		
	end
end
go

-- Aufgabe 5b

drop table KWhUsed;
go

alter table KWhUsed
 drop column Month
;
go

alter table MeterReadings
 drop column MeterReading
;
go

select *
  from TamperingLog
;
go
select *
  from MeterReadings
;
go

-- Reset
use master;
go

drop database pa;
go
