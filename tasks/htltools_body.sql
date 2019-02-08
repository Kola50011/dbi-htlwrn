create or replace package body htltools
as

    procedure fill_with_randoms(
      counts integer,
      len integer
    )
    as
        temp varchar(4000);
        rand varchar(4000);
        temp1 varchar(4000);
        rand1 varchar(4000);
    begin
        delete from summands;
        
        for i in 1 ..counts loop
        
            for j in 1..len loop
                temp:=round(dbms_random.value(0,9));
                temp1:=round(dbms_random.value(0,9));
                
                if j = 1 then
                
                    while (temp = '0') loop
                            temp := round(dbms_random.value(0,9));
                    end loop;
                    
                    while (temp1 = '0') loop
                            temp1 := round(dbms_random.value(0,9));
                    end loop;    
                end if;
                
                rand := rand || temp;
                rand1 := rand1 || temp1;
            end loop;
            
                insert into summands values (i,rand,rand1,0);
                rand := '';
                rand1 := '';
        end loop;
        
    end;
    
    function add2(
      summand1 varchar,
      summand2 varchar
    ) return varchar 
    as
    begin
        return summand1+summand2;
    end;
    
    procedure add_all_summands
    as 
        resul varchar(4000);
    begin
    
        for sumrow in (select * from summands) loop
            resul := add2(sumrow.summand1, sumrow.summand2);
            
            update summands set total = resul 
             where id = sumrow.id;
        end loop;
        
    end;
    
    procedure greeting(
        firstname varchar,
        lastname varchar,
        sex char := 'F',
        language char := 'de'
    )
    as
    begin
        case language 
            when 'de' then 
                        case sex
                            when 'F' then dbms_output.put_line('Sehr geehrte Frau ' || firstname || ' ' || lastname || '!');
                            when 'M' then dbms_output.put_line('Sehr geehrter Herr ' || firstname || ' ' || lastname || '!');
                        end case;
            when 'en' then 
                        case sex
                            when 'F' then dbms_output.put_line('Dear misses ' || firstname || ' ' || lastname || '!');
                            when 'M' then dbms_output.put_line('Dear mister ' || firstname || ' ' || lastname || '!');
                        end case;
        end case;
    end;
    
    function multiply(
      factor1 integer,
      factor2 integer
    ) return integer
    as
        ret_sum integer default 0;
    begin
        for idx in 1..factor2 loop
            ret_sum := ret_sum + factor1;
        end loop;
        
        return ret_sum;
    end;

end htltools;
/
show error;