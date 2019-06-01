set nocount on;

use master;
go

create database pa;
go

use pa;
go

-- Angabe und Vorarbeiten

create table _SaunaUsage (
	FromDate smalldatetime,
	ToDate smalldatetime,
	Name varchar(16),
	primary key (FromDate)
);
go

begin transaction;

insert into _SaunaUsage values ('2007-05-08 19:00', '2007-05-08 21:30', 'Eggert'   );
insert into _SaunaUsage values ('2007-05-15 19:30', '2007-05-15 21:30', 'Eggert'   );
insert into _SaunaUsage values ('2007-07-09 21:00', '2007-07-09 23:00', 'Trimmel'  );
insert into _SaunaUsage values ('2007-08-30 19:00', '2007-08-30 22:00', 'Lamprecht');

commit;
go

-- Aufgabe 1a

create index IX_SaunaUsage_Name
    on _SaunaUsage (Name)
;
go

-- Aufgabe 1b
drop index IX_SaunaUsage_Name
  on _SaunaUsage
;
go

-- Aufgabe 1c BEHI
-- B - Ein Index kann mit dem Stichwortverzeichnis eines Buches verglichen werden
-- E - Die Daten einer Tabelle sind physisch so organisiert wie der gruppierte ( clustered ) index
-- H - Indizes beschleunigen Abfragen, verlangsamen jedoch DML-Operationen
-- I - Für die Constraints PRIMARY KEY und UNIQUE wird automatisch ein Index erstellt

-- Aufgabe 1d ACFJ
-- A - Spalten, die häufig in Abfragen vorkommen, sollten indiziert werden.
-- C - Bei kleinen Tabellen ist ein Full Table Scan effizienter als ein Zugriff über Indizes
-- F - Enthält eine Spalte viele unterschiedliche Wertausprägungen, sollte die Spalte indiziert werden
-- J - Wird ein zusammengesetzter Index auf den Spalten PartName, PartColor und PartCity angelegt, kann bei Suchen nach PartName und PartColor effizient gesucht werden.

-- Aufgabe 2a
create table LoggedIn (
	Name varchar(16)
);
go

-- Aufgabe 2b 
create procedure LogOff
as
begin
	delete from LoggedIn;
end;
go


create procedure Login (
	@Name varchar(16)
)
as
begin
	exec LogOff;
	insert into LoggedIn values (@Name);
end;
go

-- Aufgabe 2c
create function dbo.Who()
returns varchar(16)
as
begin
	declare @Name varchar(16) = (
								  select Name
			                        from LoggedIn
								);

	if @Name is null
	begin
		return '';
	end

	return @Name;
end;
go

select dbo.Who();
exec Login 'ADLF';
select dbo.Who();
exec Login 'GOEB';
select dbo.Who();
exec LogOff;
select dbo.Who();
go

-- Aufgabe 2d
create trigger AfterInsLoggedIn
on LoggedIn
after insert
as
begin
	declare @CurrentCount int = (
						          select count(*)
						            from LoggedIn
						        );
	declare @InsertCount int = (
						         select count(*)
						             from inserted
						       );

	if @CurrentCount > 1 or @InsertCount > 1
	begin
		raiserror('AfterInsLoggedIn: Only one row permitted in table LoggedIn.', 0, 1);
		rollback;
	end
end;
go

--insert into LoggedIn values ('ADLF');
--insert into LoggedIn values ('GOEB');
--go

--insert into LoggedIn values ('ADLF'), ('GOEB');
--go

-- Aufgabe 3a
create view SaunaUsage
as select _SaunaUsage.Name, FromDate, ToDate, datediff (mi, FromDate, ToDate) / 60.0 "Hours"
     from _SaunaUsage
    where  _SaunaUsage.Name = dbo.Who()
go

-- Aufgabe 3b
exec Login Eggert;
select *
  from SaunaUsage
 order by FromDate desc
;
go

-- Aufgabe 3c ADH
-- A - Um über eine View Daten azusehen, benötigt der Benutzer die Leseberechtigung auf die View, nicht jedoch auf die zugrunde liegenden Basistabllen
-- D - Eine View führt die Abfrage jedesmal aus, beötigt aber so gut wie keine Speicherplatz ( außer für das DDL-Komanndo ) 
-- H - Ein INSERT über eine View mit verborgenen Spalten ist möglich, wenn die Spalten NULL enthalten dürfen oder ein Default-Wert für die Spalte existiert

-- Aufgabe 4a
create function dbo.SaunaBilling (
	@Year int, @Price decimal(8, 2)
) returns @Billing table
	(
	  Year int,
	  Name varchar(16),
	  Visits int,
	  TotalHours decimal(8, 2),
	  Amount decimal(10, 2)
	)
as
begin
	insert into @Billing values (@Year, '', 0, 0.0, 0.0);

	declare @Name varchar(16);
	declare @Hours decimal(10, 2);

	declare	SaunaUsageCursor cursor
	for
		select Name, Hours
		  from SaunaUsage
		 where datepart(yy, FromDate) = @Year
	;

	open SaunaUsageCursor;
	fetch SaunaUsageCursor into @Name, @Hours;

    while @@fetch_status = 0
	begin
		update @Billing
		   set Name = @Name,
			   Visits = Visits + 1,
			   TotalHours = TotalHours + @Hours,
			   Amount = TotalHours * @Price + @Hours * @Price
		;

		fetch SaunaUsageCursor into @Name, @Hours;
	end;
	close SaunaUsageCursor;
	deallocate SaunaUsageCursor;
	return
end;
go

exec Login 'Eggert';
select *
  from dbo.SaunaBilling(2007, 1.0)
;
go


go
use master;
go
drop database pa;
go