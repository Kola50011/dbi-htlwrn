clear screen;
set serveroutput on size unlimited;

-- Exercise 1

declare 
    function add_it(a number, b number)
      return number
    as
    begin
        return a + b;
    end;

    function add_it(a varchar, b varchar)
      return varchar
    as
    begin
        return a || b;
    end;
begin
  dbms_output.put_line(add_it(69, 96));
  dbms_output.put_line(add_it('test ', '123!'));
end;
/
show error

-- Exercise 2

create or replace package my_output
as
   procedure put_line (value_in in varchar2);

   procedure put_line (value_in in boolean);

   procedure put_line (
      value_in   in date,
      mask_in    in varchar2 default 'YYYY-MM-DD HH24:MI:SS');
end my_output;
/
show errors;

create or replace package body my_output
as
    procedure put_line (value_in in varchar2)
    as
    begin
        dbms_output.put_line(value_in);
    end;
  
    procedure put_line (value_in in boolean)
    is
    begin
        if (value_in) then
            dbms_output.put_line('True');
        else
            dbms_output.put_line('False');
        end if;  
    end;
  
   procedure put_line (
    value_in   in date,
    mask_in    in varchar2 default 'YYYY-MM-DD HH24:MI:SS')
  is
  begin
    dbms_output.put_line(to_char(value_in, mask_in));
  end;
end my_output;
/
show errors;

begin 
    my_output.put_line(sysdate, 'DD.MM.YYYY HH24:MI:SS');
end;
/