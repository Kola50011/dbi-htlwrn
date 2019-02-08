-- 1)
drop table Ort_Produkt_Monat_Verkauf;

create table Ort_Produkt_Monat_Verkauf (
    Ort     varchar(64),
    Produkt varchar(64),
    Monat   varchar(64),
    Anzahl  int,
    primary key (Ort, Produkt, Monat)
);

insert into Ort_Produkt_Monat_Verkauf values('Stuttgart', 'Pizza Funghi',   '2006 - 1', 155);
insert into Ort_Produkt_Monat_Verkauf values('Stuttgart', 'Pizza Vegetale', '2006 - 1', 133);
insert into Ort_Produkt_Monat_Verkauf values('Stuttgart', 'Pizza Hawaii',   '2006 - 1', 89);
insert into Ort_Produkt_Monat_Verkauf values('Stuttgart', 'Pizza Funghi',   '2006 - 2', 141);
insert into Ort_Produkt_Monat_Verkauf values('Stuttgart', 'Pizza Vegetale', '2006 - 2', 112);
insert into Ort_Produkt_Monat_Verkauf values('Stuttgart', 'Pizza Hawaii',   '2006 - 2', 95);
insert into Ort_Produkt_Monat_Verkauf values('Frankfurt', 'Pizza Funghi',   '2006 - 1', 77);
insert into Ort_Produkt_Monat_Verkauf values('Frankfurt', 'Pizza Vegetale', '2006 - 1', 93);
insert into Ort_Produkt_Monat_Verkauf values('Frankfurt', 'Pizza Hawaii',   '2006 - 1', 102);
insert into Ort_Produkt_Monat_Verkauf values('Frankfurt', 'Pizza Funghi ',  '2006 - 2', 144);
insert into Ort_Produkt_Monat_Verkauf values('Frankfurt', 'Pizza Vegetale', '2006 - 2', 178);
insert into Ort_Produkt_Monat_Verkauf values('Frankfurt', 'Pizza Hawaii',   '2006 - 2', 177);

-- 2)
select Monat, Produkt, sum(Anzahl) as Anzahl
  from Ort_Produkt_Monat_Verkauf
 group by Monat, Produkt
;

-- 3)
select (case grouping(Monat) when 1 then 'Alle Monate' else Monat end) as Monat,
       (case grouping(Produkt) when 1 then 'Alle Produkte' else Produkt end) as Produkt
  from Ort_Produkt_Monat_Verkauf
 group by rollup (Monat, Produkt)
;

--4)
select decode(Ort, 'Stuttgart', 'Ja', 'Nein') "Ort"
  from Ort_Produkt_Monat_Verkauf
;

select (case grouping(Monat) when 1 then 'Alle Monate' else Monat end) as "Monat",
       (case grouping(Produkt) when 1 then 'Alle Produkte' else Produkt end) as "Monat",
       sum(Anzahl) as "Anzahl"
  from Ort_Produkt_Monat_Verkauf
 group by rollup (Monat, Produkt)
;

-- 5)
select (case grouping(Monat) when 1 then 'Alle Monate' else Monat end) as "Monat",
       grouping(Monat) as "G Monat",
       (case grouping(Produkt) when 1 then 'Alle Produkte' else Produkt end) as "Monat",
       grouping(Produkt) as "G Produkt",
       sum(Anzahl) as "Anzahl"
  from Ort_Produkt_Monat_Verkauf
 group by rollup (Monat, Produkt)
;

-- 6)
select Monat, Produkt,
       sum(Anzahl) as "Anzahl"
  from Ort_Produkt_Monat_Verkauf
 group by rollup (Monat, Produkt)
;

-- 7)
select (case grouping(Monat) when 1 then 'Alle Monate' else Monat end) as "Monat",
       (case grouping(Produkt) when 1 then 'Alle Produkte' else Produkt end) as "Monat",
       sum(Anzahl) as "Anzahl"
  from Ort_Produkt_Monat_Verkauf
 group by cube (Monat, Produkt)
;