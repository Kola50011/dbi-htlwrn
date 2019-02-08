clear screen;
set serveroutput on size unlimited

-- 1
drop table summands;

create table summands(
    summands_id integer not null,
    summand1 varchar(4000) not null,
    summand2 varchar(4000) not null,
    total varchar(4000) not null
);

clear screen

create or replace procedure fillWithRandom(
  counts integer,
  len integer
)
is
    i integer := 0;
    val varchar(4000) := '';
begin
    delete from summands;
    while i < counts
    loop
        val := '0';
        while val = '0'
        loop
            val := round(dbms_random.value(0, 9));
        end loop;
    
        while length(val) < len
        loop
            val := val || round(dbms_random.value(0, 9));
        end loop;
        insert into summands values(i, val, 0, 0);
        i := i + 1;
    end loop;
end;
/

exec fillWithRandom(100, 30);

select * from summands;

-- 2
create or replace function addTwoVarchars(
    s1 varchar,
    s2 varchar
) return varchar
is
begin
    dbms_output.put_line(length(s1));
    dbms_output.put_line(substr(s1,0,1));   
    
    return '' || (cast(s1 as integer) + cast(s2 as integer));
end;
/

begin
    dbms_output.put_line(addTwoVarchars('1234', '1234'));
end;

-- 3

create or replace procedure add_all_summands
as
begin
    update summands
       set total = addTwoVarchars(summand1, summand2);
end;
/

exec add_all_summands;