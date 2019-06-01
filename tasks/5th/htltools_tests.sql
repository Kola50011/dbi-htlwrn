exec htltools.fill_with_randoms(100,30);
select * from summands;

exec htltools.fill_with_randoms(200,50);
select * from summands;

exec htltools.fill_with_randoms(100,30);
select * from summands;

exec htltools.fill_with_randoms(200,50);
select * from summands;

select htltools.add2('10','11') as total from dual;
select htltools.add2('69','96') as total from dual;

exec htltools.fill_with_randoms(10, 3);
exec htltools.add_all_summands;
select * from summands;

exec htltools.greeting('Max', 'Mustermann', 'M');

select htltools.multiply(5, 4), 5 * 4
  from dual;
select htltools.multiply(69, 96), 69 * 96
  from dual;