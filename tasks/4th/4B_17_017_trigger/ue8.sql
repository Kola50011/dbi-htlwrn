create database rec;
go

use rec;
go

alter database rec
set recursive_triggers on;

create table T1 (
	ebene int primary key
)
go

create trigger AfterInsT1
on T1
after insert
as
begin
	if(trigger_nestlevel() != 16)
	begin
		insert into T1 values (trigger_nestlevel());
	end

	else
	begin
		raiserror('Cannot insert above ebene 16', 16, 1);
	end

end
go

insert into T1 values (0);
go


select * from T1;
go

drop table T1;
go

use master;
go
;

drop database rec;
go
