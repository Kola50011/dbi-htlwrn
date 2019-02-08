clear screen;
drop table employees;
create table employees(
    employee_id number(38),
    first_name varchar2(30),
    last_name varchar2(50)
);

create or replace procedure process_employee (
   employee_id_in in employees.employee_id%type)
is
   l_fullname varchar2(1);
begin
   select last_name || ',' || first_name
     into l_fullname
     from employees
    where employee_id = employee_id_in;
end;

-- 1
create or replace package employee_pkg
    as
        subtype fullname_t is varchar2 (1);
    
        function fullname (
           last_in  employees.last_name%type,
           first_in  employees.first_name%type)
           return fullname_t;
    
        function fullname (
           employee_id_in in employees.employee_id%type)
           return fullname_t;
    end employee_pkg;

--2
create or replace procedure process_employee (
   employee_id_in in employees.employee_id%type)
is
   l_name employee_pkg.fullname_t;
begin
   l_name := employee_pkg.fullname (employee_id_in);
end;

--3
create or replace package body employee_pkg
    as
       function fullname (
          last_in employees.last_name%type,
          first_in employees.first_name%type
       )
          return fullname_t
       is
       begin
         return last_in || ', ' || first_in;
      end;
    
      function fullname (employee_id_in in employees.employee_id%type)
         return fullname_t
      is
         l_fullname fullname_t;
      begin
         select fullname (last_name, first_name) into l_fullname
           from employees
          where employee_id = employee_id_in;
    
         return l_fullname;
       end;
    end employee_pkg;

--4
create or replace package plsql_limits
is
   c_varchar2_length constant 
      pls_integer := 32767;
   g_start_time pls_integer;
end;

--5
declare
   l_start   pls_integer;
begin
   l_start := DBMS_UTILITY.get_cpu_time;

   for indx in 1 .. 10000
   loop
      null;
   end loop;

   dbms_output.put_line (
      dbms_utility.get_cpu_time - l_start);
end;

--6
create or replace package timer_pkg
is
   procedure start_timer;

   procedure show_elapsed (message_in in varchar2 := null);
end timer_pkg;
/

create or replace package body timer_pkg
is
   g_start_time   number := null;

   procedure start_timer
   is
   begin
      g_start_time := dbms_utility.get_cpu_time;
   end;
   procedure show_elapsed (message_in in varchar2 := null)
   is
   begin
      dbms_output.put_line (
            message_in
         || ': '
         || TO_CHAR (DBMS_UTILITY.get_cpu_time - g_start_time));

      start_timer;
   end;
end timer_pkg;

--7
begin
   timer_pkg.start_timer;
   for indx in 1 .. 10000
   loop
      null;
   end loop;
   timer_pkg.show_elapsed ('10000 Nothings');
end;

--8
create or replace package my_output
is
   procedure put_string (value_in in varchar2);

   procedure put_boolean (value_in in varchar2);

   procedure put_date (
      value_in   in date,
      mask_in    in varchar2 default 'YYYY-MM-DD HH24:MI:SS');
end my_output;

