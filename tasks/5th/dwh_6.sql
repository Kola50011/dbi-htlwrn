-- 1)
drop table produkt;
create table produkt (
  id int primary key,
  name varchar(64)
);

drop table produkt_neu;
create table produkt_neu (
  id int primary key,
  name varchar(64)
);

insert into produkt values (4711, 'Pizza Funghi');
insert into produkt values (4712, 'Pizza Quattro Stagione');
insert into produkt values (4713, 'Pizza Vegetale');

insert into produkt_neu values (4711, 'Pilz-Pizza');
insert into produkt_neu values (4712, 'Pizza Quattro Stagione');
insert into produkt_neu values (4713, 'Pizza Vegetale');
insert into produkt_neu values (4714, 'Pizza Hawaii');

-- 2)
merge into produkt P1
using ( select id, name
          from produkt_neu
      ) P2
   on ( P1.id = P2.id )
 when matched then
      update set P1 . name = P2. name
 when not matched then
      insert ( P1.id, P1.name) values ( P2.id, P2.name)
;

-- 4)
select *
  from produkt
;