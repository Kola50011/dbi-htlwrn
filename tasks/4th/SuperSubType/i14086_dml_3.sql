use person

delete from Course;
delete from Person;
go
insert into Person values (1, 'Sascha', '123457547', null, null, null, null, null, 0.0);
insert into Person values (2, 'Konstantin', '123457547', null, null, null, null, 100, null);
insert into Person values (3, 'Simon', '123457547', 0.0, 'Sofort zahlen!', null, null, null, null);
go

insert into Course values (1, 'Geld ausgeben', GetDate(), 1);
insert into Course values (2, 'Geld ausgeben', GetDate(), 1);
insert into Course values (3, 'Geld ausgeben', GetDate(), 1);
go