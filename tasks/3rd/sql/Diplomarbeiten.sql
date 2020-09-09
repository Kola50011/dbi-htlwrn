use dpa;

drop table Student;
drop table Lehrer;

create table Lehrer (
  PersNr integer primary key,
  Name   varchar(16) not null
);

create table Student (
  MatrNr integer primary key,
  Name   varchar(16) not null,
  Betreuer integer references Lehrer null
);

insert into Lehrer values(1, '1');
insert into Lehrer values(2, '2');
insert into Lehrer values(3, '3');
insert into Lehrer values(4, '4');
insert into Lehrer values(5, '5');

insert into Student values(1, '1', 1);
insert into Student values(2, '2', 2);
insert into Student values(3, '3', 1);
insert into Student values(4, '4', null);
insert into Student values(5, '5', 2);

-- Nix join

select Name, (
             select count(Name)
			   from Student
			  where Betreuer = l.PersNr
			 )
  from Lehrer l
;

-- Inner Join

select *
  from student inner join lehrer on student.betreuer = lehrer.PersNr
;
go

-- Left Outer Join

select *
  from student left outer join lehrer on student.betreuer = lehrer.PersNr
;
go

-- Right Outer Join

select *
  from student right outer join lehrer on student.betreuer = lehrer.PersNr
;
go

--Full Outer Join

select *
  from student full outer join lehrer on student.betreuer = lehrer.PersNr
;
