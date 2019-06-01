set nocount on;
go

use master;
go

create database Kryptosysteme;
go

use Kryptosysteme;
go
-- Vorarbeit

select top 1000 identity(int, 0, 1) as num
  into Numbers
  from sys.objects o1, sys.objects o2
;

alter table Numbers add primary key (num);
go

-- Aufgabe C1

-- DIE UNKE UNKT, DIE SPINNE SPINNT, UND SCHIEFE SCHEITEL KAEMMT DER WIND.
-- Die Unke unkt, die spinne spinnt, und schiefe Scheitel kämmt der Wind

-- Aufgabe C2

create function dbo.Caesar(    
    @Letter char,
    @Key integer
)
returns char
as
begin
	set @Letter = upper(@Letter);
	if ascii(@Letter) not between ascii('A') and ascii('Z')
	begin
		return @Letter
	end
	
	declare @Num integer = ascii(@Letter) + @Key;
	if @Num > ascii('Z')
	begin
		set @Num = @Num - 26
	end

	return char(@Num)
end
go

select substring('Kleopatra', num + 1, 1) as "Klartext",
       dbo.Caesar(substring('Kleopatra', num + 1, 1), 3) as "Schlüsseltext"
  from Numbers
 where num < len('Kleopatra')
;

select dbo.Caesar('K', 3),
       dbo.Caesar('l', 3),
       dbo.Caesar('e', 3),
       dbo.Caesar('o', 3),
       dbo.Caesar('p', 3),
       dbo.Caesar('a', 3),
       dbo.Caesar('t', 3),
       dbo.Caesar('r', 3),
       dbo.Caesar('a', 3)
;
go

-- Aufgabe C3

create function dbo.CaesarEncrypt(    
    @Message varchar(1024),
    @Key integer
)
returns varchar(1024)
as
begin

	declare @i int = 0;
	declare @output varchar(1024) = '';


	while @i <= len(@Message)
	begin
		set @output = @output + dbo.Caesar(substring(@Message, @i, 1), @Key);

		set @i = @i + 1;
	end
	return @output;

end
go

select dbo.CaesarEncrypt('Der Mohr hat seine Schuldigkeit getan.', 7);
go

-- 3 Bei einer A-N Verschl�sselung kommt bei verschachteltem Aufruf wieder der Klartext heraus.

select dbo.CaesarEncrypt(dbo.CaesarEncrypt('Der Mohr hat seine Schuldigkeit getan.', 13), 13);
go

-- C4

select dbo.CaesarEncrypt('RSVEUJNZIUUVIWRLCVWCVZJJZX ', num)
  from Numbers
 where num < 26  
;
go

-- ABENDS WIRD DER FAULE FLEISSIG
-- 10er Verschiebung

-- C5

create function dbo.CaesarAlphabet(
    @Key integer,
    @Separator varchar = ''
)
returns varchar(52)
as
begin

	declare @Ret varchar(52) = '';
	declare @i int = 0;

	while @i < 26
	begin

		set @Ret = @Ret + dbo.Caesar('A', @Key + @i) + @Separator;
		set @i = @i + 1;

	end

	return @Ret;

end
go

select dbo.CaesarAlphabet(3, '|');
go

select dbo.CaesarAlphabet(num, '|')
  from Numbers
 where num < 26;
go

-- C6

create table freqTable
(
	letter char(1),
	freq decimal(10,5)
);
go



insert into freqTable values ('a', 8.1);
insert into freqTable values ('b', 1.5);
insert into freqTable values ('c', 2.8);
insert into freqTable values ('d', 4.2);
insert into freqTable values ('e', 12.7);
insert into freqTable values ('f', 2.2);
insert into freqTable values ('g', 2.0);
insert into freqTable values ('h', 6.1);
insert into freqTable values ('i', 7.0);
insert into freqTable values ('j', 0.2);
insert into freqTable values ('k', 0.8);
insert into freqTable values ('l', 4.0);
insert into freqTable values ('m', 2.4);
insert into freqTable values ('n', 6.7);
insert into freqTable values ('o', 7.5);
insert into freqTable values ('p', 1.9);
insert into freqTable values ('q', 0.1);
insert into freqTable values ('r', 6.0);
insert into freqTable values ('s', 6.3);
insert into freqTable values ('t', 9.0);
insert into freqTable values ('u', 2.8);
insert into freqTable values ('v', 1.0);
insert into freqTable values ('w', 2.4);
insert into freqTable values ('x', 0.2);
insert into freqTable values ('y', 2.0);
insert into freqTable values ('z', 0.1);
go

create function dbo.letterFrequency 
(
	@input varchar(64)
) 
returns @freq table
(
	letter char,
	freq decimal(10,5)
)
as
begin
	set @input = lower(@input);
	declare @len decimal (10, 5) = len(@input);

	insert into @freq values ('a', (len(@input) - len(replace(@input, 'a', '')) ) / @len * 100 );
	insert into @freq values ('b', (len(@input) - len(replace(@input, 'b', '')) ) / @len * 100 );
	insert into @freq values ('c', (len(@input) - len(replace(@input, 'c', '')) ) / @len * 100 );
	insert into @freq values ('d', (len(@input) - len(replace(@input, 'd', '')) ) / @len * 100 );
	insert into @freq values ('e', (len(@input) - len(replace(@input, 'e', '')) ) / @len * 100 );
	insert into @freq values ('f', (len(@input) - len(replace(@input, 'f', '')) ) / @len * 100 );
	insert into @freq values ('g', (len(@input) - len(replace(@input, 'g', '')) ) / @len * 100 );
	insert into @freq values ('h', (len(@input) - len(replace(@input, 'h', '')) ) / @len * 100 );
	insert into @freq values ('i', (len(@input) - len(replace(@input, 'i', '')) ) / @len * 100 );
	insert into @freq values ('j', (len(@input) - len(replace(@input, 'j', '')) ) / @len * 100 );
	insert into @freq values ('k', (len(@input) - len(replace(@input, 'k', '')) ) / @len * 100 );
	insert into @freq values ('l', (len(@input) - len(replace(@input, 'l', '')) ) / @len * 100 );
	insert into @freq values ('m', (len(@input) - len(replace(@input, 'm', '')) ) / @len * 100 );
	insert into @freq values ('n', (len(@input) - len(replace(@input, 'n', '')) ) / @len * 100 );
	insert into @freq values ('o', (len(@input) - len(replace(@input, 'o', '')) ) / @len * 100 );
	insert into @freq values ('p', (len(@input) - len(replace(@input, 'p', '')) ) / @len * 100 );
	insert into @freq values ('q', (len(@input) - len(replace(@input, 'q', '')) ) / @len * 100 );
	insert into @freq values ('r', (len(@input) - len(replace(@input, 'r', '')) ) / @len * 100 );
	insert into @freq values ('s', (len(@input) - len(replace(@input, 's', '')) ) / @len * 100 );
	insert into @freq values ('t', (len(@input) - len(replace(@input, 't', '')) ) / @len * 100 );
	insert into @freq values ('u', (len(@input) - len(replace(@input, 'u', '')) ) / @len * 100 );
	insert into @freq values ('v', (len(@input) - len(replace(@input, 'v', '')) ) / @len * 100 );
	insert into @freq values ('w', (len(@input) - len(replace(@input, 'w', '')) ) / @len * 100 );
	insert into @freq values ('x', (len(@input) - len(replace(@input, 'x', '')) ) / @len * 100 );
	insert into @freq values ('y', (len(@input) - len(replace(@input, 'y', '')) ) / @len * 100 );
	insert into @freq values ('z', (len(@input) - len(replace(@input, 'z', '')) ) / @len * 100 );
	return
end;
go

create function dbo.Crack
(
	@input varchar(64)
) 
returns varchar(64)
as
begin
	declare @minVal decimal(10, 5) = 10000;
	declare @minNum int = 1000;

	declare @i int = 0;
	while ( @i <= 26)
	begin
		declare @chi decimal(10, 5);

		select @chi = sum(power(os.freq - es.freq, 2) / es.freq)
		  from dbo.letterFrequency(dbo.CaesarEncrypt(@input, @i)) os, freqTable es
		 where es.letter = os.letter

		if ( @chi < @minVal )
		begin
			set @minVal = @chi;
			set @minNum = @i;
		end

		set @i = @i + 1;
	end	
	return dbo.CaesarEncrypt(@input, @minNum);
end;
go

select dbo.Crack('kdvnhoo lv ixq');
select dbo.Crack('vscd mywzboroxcsyxc kbo ecopev');
go

-- T1

create function dbo.KeyAsPermutation (
    @key varchar(128)
) returns table 
as 
return select top 99 percent *, row_number() over (order by Klartext asc) as "Position"
	     from (
			   select num "#",
			          substring(@key, num, 1) "Klartext"		   				
			   	 from Numbers
			   	where num <= len(@key)
			   	  and num > 0
			  ) as unordered
		order by Klartext
go

select * 
  from dbo.KeyAsPermutation('MEGABUCK');
go

-- T2

create function dbo.KeyAsPermutString (
    @key varchar(128)
) returns varchar(256)
as
begin
	declare @Position int;
	declare @Ret varchar(64);

	declare PermutCursor cursor 
	for
		select Position
		  from dbo.KeyAsPermutation(@key)
		 order by #
	;

	open PermutCursor;
	fetch PermutCursor into @Position;

	while @@fetch_status = 0
    begin
	    select @Ret = CONCAT(@Ret, @Position, '-');
		fetch PermutCursor into @Position;
    end;
    
	select @Ret = substring( @Ret, 0, len(@Ret));
    close PermutCursor;
    deallocate PermutCursor;

	return @Ret;
end
go

select dbo.KeyAsPermutString('MEGABUCK');
go

use master;
go

drop database Kryptosysteme;
go
