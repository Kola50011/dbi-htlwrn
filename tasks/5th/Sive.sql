drop table primes;
create table primes (
  v_value integer primary key
);

begin
  for i in 2..1000 loop
    insert into primes values(i);
  end loop;
end;
/

declare
  i integer := 2;
  j integer;
  n integer := 1000;
  sqrt_n float := sqrt(n);
begin
  while i < sqrt_n loop
    j := i + i;
    while j <= n loop
    
      delete
        from primes
       where v_value = j
      ;
       
       j := j + i;
    end loop;
    
    select min(v_value)
      into i
      from primes
     where v_value > i
    ;
  end loop;
end;
/
show errors;

select * from primes;

select count(*) "# Palindromes"
  from (
        select * 
          from primes
         where to_char(v_value) = reverse(to_char(v_value))
  );