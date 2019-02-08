create tablespace nov7
       datafile 'c:\oraclexe\app\oracle\oradata\xe\nov7.dbf' 
       size 10m reuse 
       autoextend on maxsize 30m;

create user nov7 identified by nov7
       default tablespace nov7
       temporary tablespace temp
;

create table summands(
    id integer primary key,
    summand1 varchar(4000) not null,
    summand2 varchar(4000) not null,
    total varchar(4000) not null
);