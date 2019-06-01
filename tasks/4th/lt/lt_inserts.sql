use lt;
begin transaction;

delete from Liefert
delete from Lieferant
delete from Teil
go

insert into Lieferant values ('L1', 'Schmid', 20, 'London');
insert into Lieferant values ('L2', 'Jonas' , 10, 'Paris' );
insert into Lieferant values ('L3', 'Berger', 30, 'Paris' );
insert into Lieferant values ('L4', 'Klein' , 20, 'London');
insert into Lieferant values ('L5', 'Adam'  , 30, 'Athen' );

insert into Teil values ('T1', 'Mutter'  , 'rot' , 12, 'London');
insert into Teil values ('T2', 'Bolzen'  , 'gelb', 17, 'Paris' );
insert into Teil values ('T3', 'Schraube', 'blau', 17, 'Rom'   );
insert into Teil values ('T4', 'Schraube', 'rot' , 14, 'London');
insert into Teil values ('T5', 'Welle'   , 'blau', 12, 'Paris' );
insert into Teil values ('T6', 'Zahnrad' , 'rot' , 19, 'London');

insert into Liefert values ('L1', 'T1', 300);
insert into Liefert values ('L1', 'T2', 200);
insert into Liefert values ('L1', 'T3', 400);
insert into Liefert values ('L1', 'T4', 200);
insert into Liefert values ('L1', 'T5', 100);
insert into Liefert values ('L1', 'T6', 100);
insert into Liefert values ('L2', 'T1', 300);
insert into Liefert values ('L2', 'T2', 400);
insert into Liefert values ('L3', 'T2', 200);
insert into Liefert values ('L4', 'T2', 200);
insert into Liefert values ('L4', 'T4', 300);
insert into Liefert values ('L4', 'T5', 400);

commit;