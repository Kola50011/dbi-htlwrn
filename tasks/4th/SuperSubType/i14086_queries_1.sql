use person;
go

-- Alle Kunden
select *
  from Person, Customer
 where Customer.PersonID = Person.PersonID
;
go

-- Alle Mitarbeiter
select *
  from Person, Employee
 where Employee.PersonID = Person.PersonID
;
go

-- Alle Manager
select *
  from Person, Manager
 where Manager.PersonID = Person.PersonID
;
go

-- Alle Kurse (course)  mit allen Daten des jeweiligen Kursreferenten (course instructor).

select *
  from Person, CourseInstructor, Course
 where Course.CourseInstructor_PersonID = Person.PersonID
   and Course.CourseInstructor_PersonID = CourseInstructor.PersonID
;
go