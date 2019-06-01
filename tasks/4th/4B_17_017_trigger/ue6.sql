-- create database ResidentRed
use ResidentRed

if object_id('ResidentRegistration ', 'U') is not null
begin
 drop table ResidentRegistration ;
end
go

create table ResidentRegistration
(
	SocialSecurityNumber char(13) primary key,
	FirstName varchar(32),
	Surname varchar(32),
	YearOfBirth int,
	MonthOfBirth int,
	DayOfBirth int,
	MaritalStatus varchar(16),
	Sprouse char(13) foreign key references ResidentRegistration,
	check( convert( int, substring(SocialSecurityNumber, 6, 2) ) = DayOfBirth),
	check( convert( int, substring(SocialSecurityNumber, 8, 2) ) = MonthOfBirth),
	check( convert( int, substring(SocialSecurityNumber, 10, 2) ) = YearOfBirth)
);
go

create trigger InsteadOfUpd
on ResidentRegistration
instead of update
as
begin
	declare @before varchar(16)
	declare @after varchar(16)

	select @before = MaritalStatus
	  from deleted

	select @after = MaritalStatus
	  from inserted

	if (@before = 'ledig' and @after = 'verheiratet') or 
	   (@before = 'verheiratet' and @after = 'geschieden') or
	   (@before = 'verheiratet' and @after = 'verwitwet') or
	   (@before = 'verwitwet' and @after = 'verheiratet') or
	   (@before = 'geschieden' and @after = 'verheiratet')
	begin
		return
	end
	else
	begin
		rollback
	end
end
go

insert into ResidentRegistration values('19284120200', 'a', 'a', 00, 02, 12, 'ledig', null);
insert into ResidentRegistration values('13671221090',' b', 'b', 90, 10, 22, 'ledig', null);
insert into ResidentRegistration values('93728230899', 'c','c', 99, 08, 23,'ledig', null);
insert into ResidentRegistration values('83290011198', 'd', 'd', 98, 11, 01, 'ledig', null);
insert into ResidentRegistration values('83290000000', 'd', 'd', 98, 11, 01, 'ledig', null);

update ResidentRegistration set Sprouse = '13671221090', MaritalStatus = 'verheiratet'  where FirstName = 'a'
update ResidentRegistration set Sprouse = '19284120200' where FirstName = 'b'