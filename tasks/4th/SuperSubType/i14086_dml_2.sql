use person;
go

delete from Course;
delete from CourseInstructor;
delete from Manager;
delete from Customer;
go

insert into Customer values (1, 0.0, 'Sofort Zahlen!', 'Konstantin', '89137123');
insert into Customer values (2, 0.0, 'Sofort Zahlen!', 'Joel', '89137123');
insert into Customer values (3, 0.0, 'Sofort Zahlen!', 'Alex', '89137123');

go

insert into Manager values (4, 10, 'Konstantin', '23152243', GetDate(), 0.0 );
insert into Manager values (5, 10, 'Joel', '23152243', GetDate(), 0.0 );
insert into Manager values (6, 10, 'Alex', '23152243', GetDate(), 0.0 );
go

insert into CourseInstructor values (7, 100.0, 'Joel', '1234123', GetDate(), 100.0);
insert into CourseInstructor values (8, 100.0, 'Alex', '1234123', GetDate(), 100.0);
insert into CourseInstructor values (9, 100.0, 'Konstantin', '1234123', GetDate(), 100.0);
go

insert into Course values (1, 'Richtig geld ausgeben', GetDate(), 7);
insert into Course values (2, 'Richtig geld ausgeben', GetDate(), 8);
insert into Course values (3, 'Richtig geld ausgeben', GetDate(), 9);
go