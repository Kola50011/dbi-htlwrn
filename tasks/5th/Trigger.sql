clear screen
set feedback on

drop table SupplierParts;
drop table Parts;
drop table Suppliers;

create table Suppliers
(
  SupplierID       char(2) primary key,
  SupplierName     char(6),
  SupplierCity     char(6),
  SupplierDiscount number(5, 2)  
 );

create table Parts
(
  PartID    char(2) primary key,
  PartName  char(8),
  PartColor char(5),
  PartPrice number(8, 2),
  PartCity  char(6)
);

create table SupplierParts
(
  SupplierID char(2) references Suppliers(SupplierID),
  PartID     char(2) references Parts(PartID),
  Amount     number(4),
  primary key (SupplierID, PartID)
 );
/

insert into Suppliers values('L1', 'Schmid', 'London', 20);
insert into Suppliers values('L2', 'Jonas', 'Paris', 10);
insert into Suppliers values('L3', 'Berger', 'Paris', 30);
insert into Suppliers values('L4', 'Klein', 'London', 20);
insert into Suppliers values('L5', 'Adam', 'Athen', 30);

insert into Parts values ('T1', 'Mutter', 'rot', 12, 'London');
insert into Parts values ('T2', 'Bolzen', 'gelb', 17, 'Paris');
insert into Parts values ('T3', 'Schraube', 'blau', 17, 'Rom');
insert into Parts values ('T4', 'Schraube', 'rot', 14, 'London');
insert into Parts values ('T5', 'Welle', 'blau', 12, 'Paris');
insert into Parts values ('T6', 'Zahnrad', 'rot', 19, 'London');

insert into SupplierParts values ('L1', 'T1', 300);
insert into SupplierParts values ('L1', 'T2', 200);
insert into SupplierParts values ('L1', 'T3', 400);
insert into SupplierParts values ('L1', 'T4', 200);
insert into SupplierParts values ('L1', 'T5', 100);
insert into SupplierParts values ('L1', 'T6', 100);
insert into SupplierParts values ('L2', 'T1', 300);
insert into SupplierParts values ('L2', 'T2', 400);
insert into SupplierParts values ('L3', 'T2', 200);
insert into SupplierParts values ('L4', 'T2', 200);
insert into SupplierParts values ('L4', 'T4', 300);
insert into SupplierParts values ('L4', 'T5', 400);

commit;

create or replace trigger parts_aft_upd_when
after update of PartColor
on parts
for each row
when (new.PartColor = 'pink')
begin
    dbms_output.put_line('I am a trigger and I hate PINK!');
end;
/
show errors

update SupplierParts set Amount = 88 where SupplierID = 'L1';
update SupplierParts set Amount = 88 where SupplierID = 'L2';

rollback;

-- Task 6

alter trigger parts_aft_upd_when disable;
update SupplierParts set Amount = 88 where SupplierID = 'L2';

alter trigger parts_aft_upd_when enable;
update SupplierParts set Amount = 88 where SupplierID = 'L2';

alter table Parts disable all triggers;
update SupplierParts set Amount = 88 where SupplierID = 'L2';

alter table Parts enable all triggers;
update SupplierParts set Amount = 88 where SupplierID = 'L2';

drop trigger parts_aft_upd_when;
update SupplierParts set Amount = 88 where SupplierID = 'L2';
