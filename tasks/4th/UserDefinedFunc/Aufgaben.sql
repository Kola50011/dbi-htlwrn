set nocount on

-- Übung 1.1
select @@version, getdate(), system_user, user_name(), current_user, db_name();
go

-- Übung 1.2
begin transaction

create table FirstHundred
(
	number tinyint primary key
)
;

declare @num tinyint = 1;
while @num <= 100
begin
	insert into FirstHundred
	values
		(@num)
	set @num = @num + 1
end

select number, sqrt(number) as "sqrt"
from FirstHundred
;
go

rollback

-- Übung 2a.1

begin transaction

create table DecValues
(
	Val bigint primary key
)
;

declare @num tinyint = 0;
while @num <= 100
begin
	insert into DecValues
	values
		(@num)
	set @num = @num + 1
end
go

-- Übung 2a.2.NichtRekursiv

create function dbo.Dec2Hex(@Dec bigint)
returns varchar(16)
with schemabinding
as
begin
	declare @Hex varchar(16) = '';

	while @Dec >= 1
   begin
		set @Hex = substring('0123456789ABCDEF', @Dec % 16 + 1, 1) + @Hex;
		set @Dec = @Dec / 16;
	end

	return @Hex;
end
go

-- Übung 2a.2.Rekursiv

-- create function dbo.Dec2Hex(@Dec bigint)
-- returns varchar(16)
-- with schemabinding
-- as
-- begin
--     if (@Dec < 1)
--     begin
--         return '';
--     end
-- 
--     return dbo.Dec2Hex(@Dec / 16) + substring('0123456789ABCDEF', @Dec % 16 + 1, 1);
-- end
-- go

-- Übung 2a.3

select Val as "Dec", dbo.Dec2Hex(Val) as "Hex"
from DecValues
;
go

-- Übung 2b.1

create function dbo.Hex2Dec(@Hex varchar(100))
returns bigint
with schemabinding
as
begin
	declare @temp bigint;
	declare @Dec bigint;
	declare @i int = 1;
	declare @test varchar(1);
	declare @length int = LEN(@HEX);
	while @i <= @length
	begin
		set @test = SUBSTRING(@Hex, @i, 1)
		set @temp = case @test
		when 'A' then 10
		when 'B' then 11
		when 'C' then 12
		when 'D' then 13
		when 'E' then 14
		when 'F' then 15
		else SUBSTRING(@Hex, @i, 1)
		end

		if @Dec is null
		begin
			set @Dec = @temp * (power(16, @length - @i));
		end

		else if @Dec is not null
		begin
			set @Dec = @Dec + @temp * (power(16,@length - @i))
		end
		set @i+=1;
	end
	return @Dec;
end
;
go

-- Übung 2b.2

create function dbo.DigitSum(@Number bigint)
returns bigint
with schemabinding
as
begin
	declare @DigitSum bigint = 0;

	while @Number >= 1
    begin
		set @DigitSum = @DigitSum + @Number % 10;
		set @Number = @Number / 10;
	end

	return @DigitSum;
end
go

select Val as "Dec", dbo.Dec2Hex(Val) as "Hex", dbo.DigitSum(Val) as "Sum"
from DecValues
;
go

-- Übung 2b.3

create function dbo.DigitSumHex(@Hex varchar(16))
returns bigint
with schemabinding
as
begin
	declare @sum int = 0;
	declare @index int = 0;

	while @index < len(@Hex)
	begin
		set @sum = @sum + dbo.Hex2Dec(substring(@Hex, @index, 1));
		set @index = @index + 1;
	end
	return dbo.Dec2Hex(@sum)
end
go

-- Übung 2b.4

select Val as "Dec",
	dbo.Dec2Hex(Val) as "Hex",
	dbo.DigitSum(Val) as "Sum",
	dbo.DigitSumHex(Val) as "DigitSumHex",
	dbo.Hex2Dec(dbo.Dec2Hex(Val)) as "Hex2Dec"
from DecValues
;
go

-- Übung 2b.5
-- Vielleicht, ich weis es nicht, ich habe aber Überlegt anhand von 255 (0xFF)!
-- Nach kurzem Überlegen habe ich aufgegeben!

rollback;
go

-- Übung 3.1
drop function dbo.ROT13;
go

create function dbo.ROT13(@input varchar(4096))
returns varchar(4096)
with schemabinding
as
begin
	declare @index int = 0;
	declare @output varchar(4096) = '';

	declare @char varchar(1);
	declare @charCodeRot int;

	while @index < len(@input)
	begin
		set @char = substring(@input, @index + 1, 1);
		set @charCodeRot = ascii(@char) + 13;

		if ((@charCodeRot > ascii('z')) OR (ascii(@char) <= ascii('Z') AND @charCodeRot > ascii('Z')))
		begin
			set @charCodeRot = @charCodeRot - 26;
		end

		set @output = @output + char(@charCodeRot);
		set @index = @index + 1;
	end

	return @output;
end
go

-- Übung 3.2
use lt;

select LName as "Klartext", dbo.ROT13(LName) as "verschleiert"
from Lieferant

use master;

-- Übung 5
-- 1. Weil Funktionen deterministisch sein mÜssen
-- 2. 

-- Übung 6
SELECT OBJECTPROPERTY(OBJECT_ID('DigitSum'), 'IsDeterministic') as "Ist Deterministisch"
;
go

-- Übung 7

use lt;
drop function PartsOfCityOfSupplier;
go

create function PartsOfCityOfSupplier(@LNr varchar(25))
returns table as
return
  select distinct Teil.TName, Teil.Farbe
    from Liefert, Lieferant L1, Lieferant L2, Teil
   where L2.LNr = @LNr
  	 and L2.Stadt = L1.Stadt
  	 and Teil.TNR = Liefert.Teil_TNR
  	 and Liefert.Lieferant_LNR = L1.LNr;
go

select *
  from dbo.PartsOfCityOfSupplier('L3');
go

-- Übung 8

use lt;
drop function dbo.Range;
go

create function dbo.Range(
  @From int,
  @To int,
  @Step int
) returns @Range table
(
	Value int
)
as
begin
	if @To < @From
	begin
		return;
	end

	if @Step = 0
	begin
		return;
	end

	declare @num int = @From;
	while @num <= @To
	begin
		insert into @Range values (@num);
		set @num = @num + @Step;
	end

	return;
end
go

select *
from dbo.Range(100, 150, 10);
go

select *
from dbo.Range(200, 100, 5);

select *
from dbo.Range(1, 10, 0);
go

-- Übung 9a
drop function dbo.DaysOfMonthOfYear;
go
drop function dbo.GetFebDays;
go

create function dbo.GetFebDays(@Year int)
returns int
with schemabinding
as
begin
	if @Year % 400 = 0
	begin
		return 29
	end
	if @Year % 100 = 0
	begin
		return 28
	end
	if @Year % 4 = 0
	begin
		return 29
	end
	return 28
end
go

drop function dbo.MonthDaysOfYear;
go

create function dbo.MonthDaysOfYear(
   @Year int
) returns @DaysInMonth table
(
	Month tinyint,
	Days tinyint
)
as
begin
	insert into @DaysInMonth values (1, 31);
	insert into @DaysInMonth
	values
		(2, dbo.GetFebDays(@Year))
	insert into @DaysInMonth
	values
		(3, 31)
	insert into @DaysInMonth
	values
		(4, 30)
	insert into @DaysInMonth
	values
		(5, 31)
	insert into @DaysInMonth
	values
		(6, 30)
	insert into @DaysInMonth
	values
		(7, 31)
	insert into @DaysInMonth
	values
		(8, 31)
	insert into @DaysInMonth
	values
		(9, 30)
	insert into @DaysInMonth
	values
		(10, 31)
	insert into @DaysInMonth
	values
		(11, 30)
	insert into @DaysInMonth
	values
		(12, 31)
	return
end
go

select Month, Days
from dbo.MonthDaysOfYear(2011);
go

-- Übung 9b

drop function dbo.MonthDaysOfYear;
go

create function dbo.MonthDaysOfYear(
   @Year int
) returns @DaysInMonth table
(
	Month tinyint,
	Days tinyint
)
as
begin
	declare @num int = 1;
	while @num <= 12
	begin
		insert into @DaysInMonth
		values
			(@num, case
				   when @num in (1, 3, 5, 7, 8, 10, 12) then 31
				   when @num in (4, 6, 9, 11          ) then 30
				   when @num = 2 then dbo.GetFebDays(@Year)
				   end
			)
		set @num = @num + 1
	end
	return
end
go

select Month, Days
from dbo.MonthDaysOfYear(2011);
go

-- Übung 9d

drop function dbo.MonthDaysOfYear;
go

create function MonthDaysOfYear(@Year int)
returns table as
return
	select r.Value as Month
         , case
		   when r.Value in (1, 3, 5, 7, 8, 10, 12) then 31
		   when r.Value in (4, 6, 9, 11          ) then 30
		   when r.Value = 2 then dbo.GetFebDays(@Year)
		   end as Days
	from dbo.Range(1, 12, 1) r
go

select Month, Days
from dbo.MonthDaysOfYear(2011);
go

-- Übung 10

select r.Value as Year
    , (select Days
         from dbo.MonthDaysOfYear(r.Value)
        where Month = 2
	  ) as "Days in February"
  from dbo.Range(2000, 2012, 1) r

-- Übung 11a

select r1.Value as Year,
      (select Days
	     from dbo.MonthDaysOfYear(r1.Value)
	    where Month = 2
	  ) as "Days in February",
      (select Days
	     from dbo.MonthDaysOfYear(r1.Value + 100)
	    where Month = 2
	  ) as "Days in February",
	  r1.Value + 100 as Year
  from dbo.Range(1900, 1912, 1) r1
go

-- Übung 11b
-- Da 1900 nicht ganzzahlig durch 4 teilbar ist, 2000 aber schon

-- Übung 12

create function dbo.DaysOfMonthOfYear(
  @Year int, 
  @Month tinyint
) returns int
with schemabinding
as
begin
	return case 
	       when @Month in (1, 3, 5, 7, 8, 10, 12) then 31
	       when @Month in (4, 6, 9, 11          ) then 30
	       when @Month = 2 then dbo.GetFebDays(@Year)
	       end
end
go

select Value + 1900 "Year", 
       dbo.DaysOfMonthOfYear(Value + 1900, 2) "Days in February",
       dbo.DaysOfMonthOfYear(Value + 2000, 2) "Days in February", 
       Value + 2000 "Year"
  from dbo.Range(0, 12, 1);
go

-- Übung 13a

drop function dbo.DateRange;
go

create function dbo.DateRange(
   @Year int,
   @Month int
) returns @MonthDays table
(
	Days varchar(116)
)
as
begin
	declare @Days int = dbo.DaysOfMonthOfYear(@Year, @Month);
	declare @Day int = 1;

	while @Day <= @Days
	begin
		insert into @MonthDays values (str(@Year) + '-' + 
		                               right('0000'+ cast(@Month as varchar(2) ), 2) + '-' +
									   right('0000'+ cast(@Day   as varchar(2) ), 2) );
		set @Day = @Day + 1;
	end
	return
end
go

select * from DateRange(2015, 2);
go

drop function dbo.DateRange;
go

-- Übung 13b

create function dbo.DateRange(
   @Year int,
   @Month int
) returns table as
return 
  select str(@Year) + '-' + 
	   right('0000'+ cast(   @Month as varchar(2) ), 2) + '-' +
	   right('0000'+ cast(Day.Value as varchar(2) ), 2) as "Days"
   from dbo.Range(1, dbo.DaysOfMonthOfYear(@Year, @Month), 1) as Day
go

select * from DateRange(2015, 2);
go

-- Übung 14

set datefirst 1;
go

drop function dbo.Calendar;
go

create function dbo.Calendar(
   @Year int,
   @Month int
) returns @Cal table
(
	Mo varchar(2),
	Tu varchar(2),
	We varchar(2),
	Th varchar(2),
	Fr varchar(2),
	Sa varchar(2),
	Su varchar(2)
)
as
begin
	declare @Mo varchar(2) = '';
	declare @Tu varchar(2) = '';
	declare @We varchar(2) = '';
	declare @Th varchar(2) = '';
	declare @Fr varchar(2) = '';
	declare @Sa varchar(2) = '';
	declare @Su varchar(2) = '';

	declare @Days int = dbo.DaysOfMonthOfYear(@Year, @Month);
	declare @Day int = 1;
	declare @dw int;

	while @Day <= @Days
	begin
		set @dw = datepart( dw, datefromparts(@Year, @Month, @Day ) );
		
		if @dw = 1
			set @Mo = @Day;
		if @dw = 2
			set @Tu = @Day;
		if @dw = 3
			set @We = @Day;
		if @dw = 4
			set @Th = @Day;
		if @dw = 5
			set @Fr = @Day;
		if @dw = 6
			set @Sa = @Day;

		if @dw = 7
		begin
			set @Su = @Day;
			insert into @Cal values (@Mo, @Tu, @We, @Th, @Fr, @Sa, @Su);

			set @Mo = ''
			set @Tu = ''
			set @We = ''
			set @Th = ''
			set @Fr = ''
			set @Sa = ''
			set @Su = ''
		end

		set @Day = @Day + 1;
	end

	if @Su = ''
		insert into @Cal values (@Mo, @Tu, @We, @Th, @Fr, @Sa, @Su);
	return
end
go

select *
  from dbo.Calendar(2011, 2);
go

-- Übung 15

drop function dbo.Calendar;
go

create function dbo.Calendar(
   @Year int,
   @Month int
) returns table as
return
	select *, datepart( ww, datefromparts(@Year, @Month, Day.Value ) ) "Week"
	  from dbo.Range(1, dbo.DaysOfMonthOfYear(@Year, @Month), 1) as Day
go

select *
  from dbo.Calendar(2011, 2);
go

-- Übung 16

drop function dbo.SplitString;
go

create function dbo.SplitString(
   @Input varchar(128),
   @Splitter int
) returns @Split table
( 
	Part varchar(16)
)
begin
	declare @ToInsert varchar(32) = '';
	declare @Pos int = 1;

	while @Pos <= len(@Input)
	begin
		declare @Current varchar(1) = substring(@Input, @Pos, 1);
		
		if @Current = ' '
		begin
			insert into @Split values (@ToInsert);
			set @ToInsert = '';
		end
		else
		begin
			set @ToInsert = @ToInsert + @Current;
		end

		set @Pos = @Pos + 1;
	end

	insert into @Split values (@ToInsert);	

	return
end
go

select *
  from dbo.SplitString('Ein Satz mit fünf Wörtern.', ' ');
go