create tablespace streets
       datafile '\streets.dbf' 
       size 10m reuse 
       autoextend on maxsize 30m;
       
create user streets identified by topsecret
       default tablespace streets
       temporary tablespace temp
;

grant connect, resource to streets;