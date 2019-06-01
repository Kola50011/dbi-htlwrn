create database rec;
go

use rec;
go

create table T1 (
	a int primary key
)

create table T2(
    a int primary key
	)
go

create table T3(
    a int primary key
	)
go

create trigger AfterInsUpDelT1
on T1
after insert, update, delete
as
begin

    if exists(select * from inserted)
    begin
        insert into T2 select * from inserted;
        insert into T3 select * from inserted;
    end

    if exists(select * from deleted)
    begin
        delete from T2 where T2.a = T2.a;
        delete from T3 where T3.a = T3.a;
    end

end
go

create trigger AfterInsUpDelT2
on T2
after insert, update, delete
as
begin

    if exists(select * from inserted)
    begin
        insert into T3 select * from inserted;
    end

    if exists(select * from deleted)
    begin
        delete from T3 where T3.a = T3.a;
    end

end
go

create trigger AfterInsUpDelT3
on T3
after insert, update, delete
as
begin

    if(trigger_nestlevel() < 2)
    begin
        raiserror('Cannot insert :(',16 ,1);
        rollback;
    end

end
go

drop trigger AfterInsUpDelT1;
go

drop trigger AfterInsUpDelT2;
go

drop trigger AfterInsUpDelT3;
go

drop table T2;
go

drop table T3;
go

use master;
go
;

drop database rec;
go
