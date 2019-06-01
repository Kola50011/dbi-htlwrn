-- Aufgabe 2 1
use lt
go

drop procedure GetMinMaxOfColor;
go

create procedure GetMinMaxOfColor(
    @PartColor char(5),
    @MinAmount int output,
    @MaxAmount int output
)
as
begin
	select @MinAmount = min(Menge), @MaxAmount = max(Menge)
	  from lt, t
	 where lt.tnr = t.tnr
	   and t.farbe = @PartColor
	;	 
end;
go

-- Aufgabe 2 4

declare @MinAmount int;
declare @MaxAmount int;

exec GetMinMaxOfColor 'blau', @MinAmount output, @MaxAmount output;

-- Aufgabe 2 5

select @MinAmount as "Min", @MaxAmount as "Max";
go

-- Aufgabe 3

begin transaction
select * from t;

declare @count int = 0;
declare @unnoetig varchar(2);

declare RaisePriceCursor cursor
for
	select TNR
	  from t
	 order by TNR;
	
open RaisePriceCursor;
fetch RaisePriceCursor into @unnoetig;

while @@fetch_status = 0
begin
	if ( @count % 2 = 0 )
	begin
		update t
	       set preis = preis * 1.05
		 where current of RaisePriceCursor
	end
	set @count = @count + 1;
	fetch RaisePriceCursor into @unnoetig;
end;

close RaisePriceCursor;
deallocate RaisePriceCursor;

select * from t;
rollback
go

-- Aufgabe 4

drop procedure NameOfWeekDay;
go

create procedure NameOfWeekDay(
    @WeekDayNumber int,
    @WeekDayName varchar(15) output
)
as 
begin 
    set @WeekDayName = (case @WeekDayNumber
                             when 1 then 'Monday'
                             when 2 then 'Tuesday'
                             when 3 then 'Wednesday'
                             when 4 then 'Thursday'
                             when 5 then 'Friday'
                             when 6 then 'Saturday'
                             when 7 then 'Sunday'
                             else 'Error'
                        end
    );
    if @WeekDayName = 'Error'
    begin
     raiserror(50001, 16, 1);
     set @WeekDayName = '';
    end
end;
go

exec sp_addmessage 50001, 16, '@WeekDayNumber != 1-7', 'us_english', 'FALSE', 'replace';
go