use person;
go

-- Alle Kunden
select *
  from Person
 where Discount is not null
   and TermsOfPayment is not null
;
go

-- Alle Mitarbeiter
select *
  from Person
 where NumberAssistants is not null
   or FeePerHour is not null
;
go

-- Alle Manager
select *
  from Person
 where NumberAssistants is not null
;
go

-- Alle Kurse (course)  mit allen Daten des jeweiligen Kursreferenten (course instructor).

select *
  from Person, Course
 where Course.Person_PersonID = Person.PersonID
;
go