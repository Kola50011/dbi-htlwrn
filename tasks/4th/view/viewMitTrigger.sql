create database books;
go

use books;
go

set nocount on;

create table _Books
(
  ISBN10 char(10) primary key,
  Author varchar(32) not null,
  Title varchar(48) not null,
  Language char(2),
  IsDeleted bit default 1,
  DeletedOn smalldatetime default null,
  DeletedBy varchar(32) default null
);

begin transaction;
insert into _Books (ISBN10, Author, Title, Language ) values ('014241493X', 'John Green', 'Paper Towns', 'en');
insert into _Books (ISBN10, Author, Title, Language ) values ('3446234770', 'John Green', 'Margos Spuren', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3746656367', 'Lion Feuchtwanger', 'Goya', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('374665632X', 'Lion Feuchtwanger', 'Der falsche Nero', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3518395041', 'Ernst Weiﬂ', 'Der arme Verschwender', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3551789762', 'Ryuichiro Utsumi', 'Von der Natur des Menschen', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3630620124', 'Ryunosuke Akutagawa', 'Rashomon', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3423136200', 'Antal Szerb', 'Reise im Mondlicht', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3423114118', 'Heimito von Doderer', 'Die Wasserf‰lle von Slunj', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3442453305', 'Sven Regener', 'Herr Lehmann', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3442730503', 'Haruki Murakami', 'Naokos L‰cheln', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('0416199259', 'Benjamin Hoff', 'The Tao of Pooh and the Te of Piglet', 'en');
insert into _Books (ISBN10, Author, Title, Language ) values ('0931137071', 'Geoffrey James', 'The Tao of Programming', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('140522310X', 'Andy Stanton', 'You''re a Bad Man, Mr Gum!', 'en');
insert into _Books (ISBN10, Author, Title, Language ) values ('3462034901', 'Joseph Roth', 'Die Geschichte von der 1002. Nacht', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3423107423', 'Italo Calvino', 'Der Ritter, den es nicht gab', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3257238606', 'Georges Simenon', 'Maigret und der Clochard', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3423138721', 'Walter Kappacher', 'Selina oder Das andere Leben', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3423135794', 'Leo Perutz', 'Die dritte Kugel', 'de');
insert into _Books (ISBN10, Author, Title, Language ) values ('3423131608', 'Leo Perutz', 'Der schwedische Reiter', 'de');
commit;
go

create trigger InsteadOfDel_Books
on _Books
instead of delete
as
begin
	update _Books
	   set _Books.IsDeleted = 0, _Books.DeletedOn = getdate(), _Books.DeletedBy = user_name()
	  from deleted
	 where deleted.ISBN10 = _Books.ISBN10
	;

end
;
go

create view Books
as select ISBN10, Author, Title, Language
     from _Books
	where IsDeleted = 1
;
go	

select *
  from Books
;
go

delete from Books;
go

select *
  from _Books
;
go

select *
  from Books
;

go
go
use master;
go

drop database books;
go