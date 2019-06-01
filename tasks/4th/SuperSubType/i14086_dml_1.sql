use person

delete from Course;
delete from CourseInstructor;
delete from Manager;
delete from Customer;
delete from Employee;
delete from Person;
go

insert into Person values (1, 'Konstantin', '1231233');
insert into Person values (2, 'Joel', '1231233');
insert into Person values (3, 'Alex', '1231233');
insert into Person values (4, 'Aleks', '1231233');
insert into Person values (5, 'Bernd', '1231233');
insert into Person values (6, 'Berndt', '1231233');
insert into Person values (7, 'Marcel', '1231233');
insert into Person values (8, 'Matthias', '1231233');
insert into Person values (9, 'Sascha', '1231233');
go

insert into Employee values (1, GetDate(), 0.0);
insert into Employee values (2, GetDate(), 0.0);
insert into Employee values (3, GetDate(), 0.0);
insert into Employee values (4, GetDate(), 0.0);
insert into Employee values (5, GetDate(), 0.0);
insert into Employee values (6, GetDate(), 0.0);
go

insert into Customer values (7, 0.0, 'Sofort zu zahlen');
insert into Customer values (8, 0.0, 'Sofort zu zahlen');
insert into Customer values (9, 0.0, 'Sofort zu zahlen');
go

insert into Manager values (1, 5);
insert into Manager values (2, 562);
insert into Manager values (3, 34);
go

insert into CourseInstructor values (4, 100.0);
insert into CourseInstructor values (5, 100.0);
insert into CourseInstructor values (6, 100.0);
go

insert into Course values (1, 'Richtig geld ausgeben', GetDate(), 4);
insert into Course values (2, 'Richtig geld ausgeben', GetDate(), 5);
insert into Course values (3, 'Richtig geld ausgeben', GetDate(), 6);
go