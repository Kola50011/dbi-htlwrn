set nocount on;

drop table Books;
go

create table Books
(
    ISBN10      char(10)    primary key,
    Author      varchar(32) not null,
    Title       varchar(48) not null,
    Language    char(2)
);
go
 
set nocount on;
go

begin transaction
go

insert into Books values('014241493X', 'John_Green', 'Paper_Towns', 'de');
insert into Books values('3446234770', 'John_Green', 'Margos_Spuren', 'en');
insert into Books values('3746656367', 'Lion_Feuchtwagner', 'Goya', 'de');
insert into Books values('140522310X', 'sdfg', 'dfgh', 'de');
go

commit;
go

drop function dbo.ISBNCheckDigit;
go

-- Aufgabe 1a
create function dbo.ISBNCheckDigit(@ISBN char(10))
returns char
with schemabinding
begin
	declare @index tinyint = 1;
	declare @sum int = 0;

	while @index <= 9
	begin
		set @sum = @sum + (@index * convert(int, substring(@ISBN, @index, 1) ) );
		set @index = @index + 1;
	end
	declare @res int = @sum % 11;

	if @res < 10
	begin
		return convert(char(1), @res);
	end
	return 'X';
end
go

select dbo.ISBNCheckDigit('359629428?');
go

-- Aufgabe 1b
select ISBN10, dbo.ISBNCheckDigit(ISBN10) as "CheckDigit", Author, Title
  from Books
;
go

-- Aufgabe 2a
select ISBN10, dbo.ISBNCheckDigit(ISBN10) as "CheckDigit", Author, Title
  from Books
 where substring(ISBN10, 10, 1) != dbo.ISBNCheckDigit(ISBN10)
;
go

-- Aufgabe 2b
select ISBN10, dbo.ISBNCheckDigit(ISBN10) as "CheckDigit",
	   Error = case 
		when substring(ISBN10, 10, 1) != dbo.ISBNCheckDigit(ISBN10) then 'ERROR'
		else ''
	   end,
	   Author, Title
  from Books
;
go

-- Aufgabe 2c
select ISBN10,
	   SUBSTRING(ISBN10, 1, 9) + dbo.ISBNCheckDigit(ISBN10) as "CorrectISBN10",
	   Author, Title
  from Books
 where substring(ISBN10, 10, 1) != dbo.ISBNCheckDigit(ISBN10)
;
go

-- Aufgabe 2d
begin transaction
go

update Books set ISBN10 = SUBSTRING(ISBN10, 1, 9) + dbo.ISBNCheckDigit(ISBN10)
go

select ISBN10, dbo.ISBNCheckDigit(ISBN10) as "CheckDigit",
	   Error = case 
		when substring(ISBN10, 10, 1) != dbo.ISBNCheckDigit(ISBN10) then 'ERROR'
		else ''
	   end,
	   Author, Title
  from Books
;
go

rollback
go

-- Aufgabe 3a
drop table HTML;
create table HTML
(
	LineNumber	int primary key,
	Line		varchar(120) not null
)
;
go

-- Aufgabe 3b
drop procedure HTMLInsert;
go

create procedure HTMLInsert(@Line varchar(120))
as
begin
	declare @LineNumber int;
	select @LineNumber = count(*) + 1 from HTML;

	insert into HTML values (@LineNumber, @Line);
end
go

-- Aufgabe 3c
exec HTMLInsert '<html>'
exec HTMLInsert '<body>'
go

select *
  from HTML
;
go

delete HTML;
go

-- Aufgabe 4a
drop function dbo.TableLine;
go

create function dbo.TableLine(@ISBN10 char(10), @Author varchar(32),
                              @Title varchar(48), @Language char(2))
returns varchar(120)
with schemabinding
begin
	return '<tr><td>' + @ISBN10 + '</td><td>' + @Author + '</td><td>' + @Title + '</td><td>' + @Language + '</td></tr>'
end
go

-- Aufgabe 4b
drop procedure ConvertToHTML;
go

create procedure ConvertToHTML
as
begin
	declare @ISBN10 char(10);
	declare @Author varchar(32);
    declare @Title varchar(48);
	declare @Language char(2);
    declare @ToInsert varchar(120);

	exec HTMLInsert '<html>'
	exec HTMLInsert '<body>'
	exec HTMLInsert '<table>';

	declare BooksCursor cursor
		for select *
		      from Books
	;

	open BooksCursor;

	fetch BooksCursor
	 into @ISBN10, @Author, @Title, @Language

	while @@fetch_status = 0
	begin
		select @ToInsert = dbo.TableLine( @ISBN10, @Author, @Title, @Language )
		exec HTMLInsert @ToInsert;

		fetch BooksCursor
		 into @ISBN10, @Author, @Title, @Language
	end

	close BooksCursor;
	deallocate BooksCursor;

	exec HTMLInsert '</table>';
    exec HTMLInsert '</body>';
    exec HTMLInsert '</html>';
end
go

-- Aufgabe 4c
exec ConvertToHTML;
go

select *
  from HTML
 order by LineNumber
;
go