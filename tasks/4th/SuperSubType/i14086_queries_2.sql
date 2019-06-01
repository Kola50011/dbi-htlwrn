use person;
go

-- Alle Kunden
select *
  from Customer
;
go

-- Alle Mitarbeiter
select *
  from CourseInstructor
;
select *
  from Manager
;
go

-- Alle Manager
select *
  from Manager
;
go

-- Alle Kurse (course)  mit allen Daten des jeweiligen Kursreferenten (course instructor).

select *
  from CourseInstructor, Course
 where Course.CourseInstructor_PersonID = CourseInstructor.PersonID
;
go