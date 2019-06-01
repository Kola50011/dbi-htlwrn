clear screen
set serveroutput on
declare
    Pwd varchar(32) := 'topsecret';
    l_Length int := length(Pwd);
    l_Char char;
    IsLongEnough boolean := true;
    HasUpper boolean := false;
    HasLower boolean := false;
    HasDigit boolean := false;
begin
    if l_Length < 8 then
        IsLongEnough := false;
    end if;
    while l_Length > 0 and  not (HasUpper and HasLower and HasDigit)
    loop
        l_Char := substr(Pwd, l_Length, 1);
        if not HasUpper and instr('ABCDEFGHIJKLMNOPQRSTUVWXYZ', l_Char) != 0 then
          HasUpper := true;
        end if;
        if not HasLower and instr('abcdefghijklmnopqrstuvwxyz', l_Char) != 0 then
          HasLower := true;
        end if;
        if not HasDigit and instr('0123456789', l_Char) != 0 then
          HasDigit := true;
        end if;
        
        l_Length := l_Length - 1;
    end loop;
    
    if (IsLongEnough and HasUpper and HasLower and HasDigit)
    then
        dbms_output.put_line('True'); 
    else 
        dbms_output.put_line('False');
    end if;
end;
/
show errors