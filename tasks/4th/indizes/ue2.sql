set nocount on;

use master;
go


create database indizes;
go

use indizes;
go

create table Foo
(
  Field1 int not null,
  Field2 varchar(10)
);
go

create unique nonclustered index IX_Foo_Field1
    on Foo(Field2);
go

insert into Foo values ( 10, 'Hello!');
insert into Foo values ( 10, 'Bye!'	 );
insert into Foo values ( 50, 'Hello!');
go

exec sp_spaceused Foo;
go

go
use master;
go

drop database indizes;
go
