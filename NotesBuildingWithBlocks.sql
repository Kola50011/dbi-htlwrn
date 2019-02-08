alter user hr account unlock;
alter user hr identified by topsecret;

set serveroutput on size unlimited;

-- Prints Hello World

begin
  dbms_output.put_line('Hello World!');
end;
/

-- Prints Hello World with a var

declare
  l_message varchar2(100) := 'Hello World!';
begin
  dbms_output.put_line(l_message);
end;
/

-- Prints Hello World with an optional Exception handling block, 

declare
  l_message varchar2(100) := 'Hello World!';
begin
  dbms_output.put_line(l_message);
exception
  when others then
    dbms_output.put_line(sqlerrm);
end;
/

-- Nested block; Concats two variables and prints the result.
-- If an exception is thrown a formatted stack trace will be printed

declare
  l_message varchar2(100) := 'Hello';
begin
  declare
    l_message2 varchar2(100) := l_message || ' World!'; 
  begin
    dbms_output.put_line(l_message2);
  end;
exception
  when others then
    dbms_output.put_line(dbms_utility.format_error_stack);
end;
/

-- Creates a named procedure that prints Hello World

create or replace procedure 
hello_world
is
  l_message varchar2(100) := 'Hello World!';
begin
  dbms_output.put_line(l_message);
end hello_world;

begin
   hello_world;
end;
/

-- Creates a named procedure that prints Hello Universe

create or replace procedure 
hello_universe
is
  l_message varchar2(100) := 'Hello Universe!';
begin
  dbms_output.put_line(l_message); 
end hello_universe;
/

-- Creates a named function that takes a parameter;
-- The in keyword in the parameter list is the type of the parameter (in/out)

create or replace procedure 
hello_place(place_in in varchar2)
is
  l_message varchar2(100);
begin
  l_message  := 'Hello ' || place_in;
  dbms_output.put_line(l_message);
end hello_place;
/

begin
   hello_place('World');
   hello_place('Universe');
end;
/

-- Creates a named function that returns a string based on the input parameter

create or replace function 
hello_message(place_in in varchar2) 
return varchar2
is
begin
   return 'Hello ' || place_in;
end hello_message;
/

-- Assigns l_message the return value of the hello_message procedure

declare
  l_message varchar2(100);
begin
  l_message := hello_message('Universe');
end;
/

-- Creates a named procedure an immidiatelly prints the result of the return 
-- value of hello_message

create or replace procedure 
hello_place(place_in in varchar2)
is
begin
  dbms_output.put_line(hello_message(place_in));
end hello_place;
/

-- Inserts a row in a PL/SQL block

create table message_table(
    message_date date primary key,
    message_text varchar2(100)
);

begin
  insert into message_table(message_date, message_text)
              values(sysdate, hello_message('Chicago'));
end;
/

select * 
  from message_table;

drop table message_table;

-- Creates a procedure with the name hello_world that prints Hello World

create or replace procedure 
hello_world
is
begin
  dbms_output.put_line('Hello World!');
end hello_world;
/

-- Three valid procedure calls for the procedure hello_world

begin
   hello_world;
   HELLO_WORLD;
   "HELLO_WORLD";
end;
/

-- Invalid procedure call to hello_world as the double quotes make the 
-- procedure name case sensitive and they are upper case per default

-- begin
--    "hello_world";
-- end;

-- Creates a named procedure Hello_World which is case sensitive

create or replace procedure 
"Hello_World"
is
begin
  dbms_output.put_line('Hello World!');
end "Hello_World";
/

-- Queries the employees table an stores the name of the employee with the 
-- ID 138 into the variable l_name and prints it afterwards

declare
  l_name employees.last_name%type;
begin
  select last_name
    into l_name
    from employees
   where employee_id = 138;

  dbms_output.put_line(l_name);
end; 
/

-- Declares a variable with the same data type as employees.department_id and 
-- Initializes it with 10; Afterwards deletees every employy from Department 10
-- and prints the number of deleted rows afterwards;
-- Commented out because of integrity constraints

--declare
--  l_dept_id employees.department_id%type := 10;
--begin
--  delete from employees
--        where department_id = l_dept_id;
--
--  dbms_output.put_line(sql%rowcount);
--end;
--/

-- Variable same as before; Raises the salary of every employee of Department 10
-- by 20%

declare
  l_dept_id employees.department_id%type := 10;
begin
  update employees
     set salary = salary * 1.2
   where department_id = l_dept_id;

  dbms_output.put_line(sql%rowcount);
end;
/

-- Inserts a row into the employees table and prints the rowcount afterwards

begin
  insert into employees(employee_id, last_name, department_id, salary, email, hire_date, job_id)
       values(1000, 'Feuerstein', 10, 200000, 'email', sysdate, 'AD_VP');

  dbms_output.put_line(sql%rowcount);
end;
/
rollback;

-- Prints Hello World after the date 2011-01-01 (including); otherwise only Hello

declare
  l_message varchar2(100) := 'Hello';
  l_message2 varchar2(100) := ' World!';
begin
  if sysdate >= to_date('01-JAN-2011')
  then
    l_message2 := l_message || l_message2;
    dbms_output.put_line(l_message2);
  else
    dbms_output.put_line(l_message);
  end if;
end;
/

-- Does the same as before but this time with a nested block
-- Only after 2011-01-01 (exclusive)

declare
   l_message varchar2(100) := 'Hello';
begin
   if sysdate > to_date('01-JAN-2011')
   then
      declare
         l_message2 varchar2(100) := ' World!';
      begin
         l_message2 := l_message || l_message2;
         dbms_output.put_line(l_message2);
      end;
   else
      dbms_output.put_line(l_message);
   end if;
end;
/

-- Uses a nested block to print Hello World!; 
-- The nested block also handles any exception

declare
   l_message varchar2(100) := 'Hello';
begin
   declare
      l_message2 varchar2(5);
   begin
      l_message2 := 'World!';
      dbms_output.put_line(l_message || l_message2);
   exception
      when others
      then
         dbms_output.put_line(dbms_utility.format_error_stack);
   end;
   dbms_output.put_line(l_message);
end;
/