--create database Authors
use Authors

if object_id('TitlesAuthors', 'U') is not null
begin
   drop table TitlesAuthors;
end
go

if object_id('Titles', 'U') is not null
begin
   drop table Titles;
end
go

if object_id('Authors', 'U') is not null
begin
   drop table Authors;
end
go

create table Titles
(
  ISBN10 char(10) primary key,
  Title varchar(48) not null,
  Language char(2)
);

create table Authors
(
  AuthorCode int primary key,
  AuthorName varchar(32) not null
);
go

create table TitlesAuthors
(
  ISBN10 char(10) references Titles(ISBN10),
  AuthorCode int references Authors(AuthorCode)
  primary key (ISBN10, AuthorCode)
);
go

set nocount on;
go

begin transaction;

insert into Authors values (1, 'Leo Perutz');
insert into Authors values (2, 'Paul Frank');
insert into Authors values (3, 'John Green');
insert into Authors values (4, 'Benjamin Hoff');
insert into Authors values (5, 'Geoffrey James');
insert into Authors values (6, 'Andy Stanton');
insert into Authors values (7, 'Georges Simenon');
insert into Authors values (8, 'Italo Calvino');
insert into Authors values (9, 'Heimito von Doderer');
insert into Authors values (10, 'Antal Szerb');
insert into Authors values (11, 'Walter Kappacher');
insert into Authors values (12, 'Sven Regener');
insert into Authors values (13, 'Haruki Murakami');
insert into Authors values (14, 'Joseph Roth');
insert into Authors values (15, 'Ernst Weiß');
insert into Authors values (16, 'Ryuichiro Utsumi');
insert into Authors values (17, 'Ryunosuke Akutagawa');
insert into Authors values (18, 'Lion Feuchtwanger');
commit;
go

begin transaction;

insert into Titles values ('014241493X', 'Paper Towns', 'en');
insert into Titles values ('0416199259', 'The Tao of Pooh and the Te of Piglet', 'en');
insert into Titles values ('0931137071', 'The Tao of Programming', 'de');
insert into Titles values ('1405223103', 'You''re a Bad Man, Mr Gum!', 'en');
insert into Titles values ('3257238606', 'Maigret und der Clochard', 'de');
insert into Titles values ('3423107421', 'Der Ritter, den es nicht gab', 'de');
insert into Titles values ('3423114118', 'Die Wasserfälle von Slunj', 'de');
insert into Titles values ('3423131608', 'Der schwedische Reiter', 'de');
insert into Titles values ('3423135794', 'Die dritte Kugel', 'de');
insert into Titles values ('3423136200', 'Reise im Mondlicht', 'de');
insert into Titles values ('3423138726', 'Selina oder Das andere Leben', 'de');
insert into Titles values ('3426601001', 'Das Mangobaumwunder', 'de');
insert into Titles values ('3442453305', 'Herr Lehmann', 'de');
insert into Titles values ('3442730503', 'Naokos Lächeln', 'de');
insert into Titles values ('3446234772', 'Margos Spuren', 'de');
insert into Titles values ('3462034901', 'Die Geschichte von der 1002. Nacht', 'de');
insert into Titles values ('3518395041', 'Der arme Verschwender', 'de');
insert into Titles values ('3551789762', 'Von der Natur des Menschen', 'de');
insert into Titles values ('3630620124', 'Rashomon', 'de');
insert into Titles values ('374665632X', 'Der falsche Nero', 'de');
insert into Titles values ('3746656362', 'Goya', 'de');

commit;
go

begin transaction;

insert into TitlesAuthors values ('014241493X', 3);
insert into TitlesAuthors values ('0416199259', 4);
insert into TitlesAuthors values ('0931137071', 5);
insert into TitlesAuthors values ('1405223103', 6);
insert into TitlesAuthors values ('3257238606', 7);
insert into TitlesAuthors values ('3423107421', 8);
insert into TitlesAuthors values ('3423114118', 9);
insert into TitlesAuthors values ('3423131608', 1);
insert into TitlesAuthors values ('3423135794', 1);
insert into TitlesAuthors values ('3423136200', 10);
insert into TitlesAuthors values ('3423138726', 11);
insert into TitlesAuthors values ('3426601001', 1);
insert into TitlesAuthors values ('3426601001', 2);
insert into TitlesAuthors values ('3442453305', 12);
insert into TitlesAuthors values ('3442730503', 13);
insert into TitlesAuthors values ('3446234772', 3);
insert into TitlesAuthors values ('3462034901', 14);
insert into TitlesAuthors values ('3518395041', 15);
insert into TitlesAuthors values ('3551789762', 16);
insert into TitlesAuthors values ('3630620124', 17);
insert into TitlesAuthors values ('374665632X', 18);
insert into TitlesAuthors values ('3746656362', 18);

commit;
go

create trigger AfterInsUpdAuthors
on Authors
after insert, update
as
begin
    raiserror('%d Zeile(n) wurden geändert.', 0, 1, @@rowcount);
end
go

create trigger AfterDelAuthors
on Authors
after delete
as
begin
    raiserror('%d Zeile(n) wurden aus dieser Tabelle gelöscht.', 
              0, 1, @@rowcount);
end
go

--insert into TitlesAuthors values ( 'asd', 1 )

--select * from sys.foreign_keys;
--go

--begin transaction

--alter table Authors.dbo.TitlesAuthors
-- drop constraint FK__TitlesAut__ISBN1__3A81B327;

--insert into TitlesAuthors values ( 'asd', 1 )

--rollback
--go

create trigger AfterInsUpdTitlesAuthors
on TitlesAuthors
after insert, update
as
begin
    if exists (select 1
                 from inserted
                where inserted.AuthorCode not in (select AuthorCode
                                                    from Authors)
               )
    begin
        raiserror('AuthorCode nicht in Authors enthalten!', 16, 1);
        rollback transaction;
    end
    
    if exists (select 1
                 from inserted
                where inserted.ISBN10 not in (select ISBN10
                                                    from Titles)
               )
    begin
        raiserror('ISBN10 nicht in Titles enthalten!', 16, 1);
        rollback transaction;
    end
end
go

create trigger AuthorsDelete
on Authors
after delete
as
begin
	if exists (select *
				 from deleted, TitlesAuthors
			    where TitlesAuthors.AuthorCode = deleted.AuthorCode
	)
	begin
        raiserror('Author hat nochimmer n Buch in der DB!', 16, 1);
        rollback transaction;		
	end

end
go

create trigger TitlesDelete
on Titles
after delete
as
begin
	if exists (select *
				 from deleted, TitlesAuthors
			    where TitlesAuthors.ISBN10 = deleted.ISBN10
	)
	begin
        raiserror('Buch hat nochimmer n Buch in der DB!', 16, 1);
        rollback transaction;		
	end

end
go