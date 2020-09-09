set nocount on

begin transaction;

IF OBJECT_ID('vname', 'U') IS NOT NULL
  DROP TABLE vname;
IF OBJECT_ID('nname', 'U') IS NOT NULL
  DROP TABLE nname;

create table vName (
  matnr  varchar(32) not null,
  vname  varchar(32) not null
);

create table nName (
  matnr  varchar(32) not null,
  nname  varchar(32) not null
);

insert into vName values('i14076','Matthias');
insert into vName values('i14086','Konstantin');

insert into nName values('i14076','Grill');
insert into nName values('i14086','Lampalzer');

select *
  from vName, nName
;

select *
  from vName, nName
 where vName.matnr = nName.matnr
;

select *
  from vName
  join nName
    on vName.matnr = nName.matnr
;