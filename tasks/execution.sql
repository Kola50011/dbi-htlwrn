if l_salary > 40000
then
   give_bonus (l_employee_id,500);
end if;

if l_salary > 40000 or l_salary 
is null
then
   give_bonus (l_employee_id,500);
end if;

if l_salary <= 40000
then
   give_bonus (l_employee_id, 0);
else
   give_bonus (l_employee_id, 500);
end if;

if nvl(l_salary,0) <= 40000
then
   give_bonus (l_employee_id, 0);
else
   give_bonus (l_employee_id, 500);
end if;

if l_salary between 10000 and 20000
then
   give_bonus(l_employee_id, 1000);
elsif l_salary > 20000
then
   give_bonus(l_employee_id, 500);
else
   give_bonus(l_employee_id, 0);
end if;

case l_employee_type
   when 's' 
   then
      award_bonus (l_employee_id);
   when 'h' 
   then
      award_bonus (l_employee_id);
   when 'c' 
   then
       award_commissioned_bonus (
          l_employee_id);
   else
       raise invalid_employee_type;
end case;

case
  when l_salary 
  between 10000 and 20000 
  then
    give_bonus(l_employee_id, 1500);
  when salary > 20000 
  then
    give_bonus(l_employee_id, 1000);
  else
    give_bonus(l_employee_id, 0);    
end case;

give_bonus(l_employee_id,
  case
     when l_salary 
     between 10000 and 20000 
     then 1500
     when l_salary > 40000 
     then 500
     else 0
  end);

  procedure display_multiple_years (
   start_year_in in pls_integer
  ,end_year_in   in pls_integer
)
is
begin
  for l_current_year 
  in start_year_in .. end_year_in
  loop
     display_total_sales 
             (l_current_year);
  end loop;
end display_multiple_years;

procedure display_multiple_years (
    start_year_in in pls_integer
   ,end_year_in in pls_integer
)
is
begin
  for l_current_year in (
     select * from sales_data
       where year 
       between start_year_in 
       and end_year_in)
  loop
     display_total_sales 
             (l_current_year);
  end loop;
end display_multiple_years;

procedure display_multiple_years (
   start_year_in in pls_integer
  ,end_year_in in pls_integer
)
is
  l_current_year 
          integer; /* not needed */
begin
  for l_current_year 
          in start_year_in 
             .. end_year_in

procedure display_multiple_years (
   start_year_in in pls_integer
  ,end_year_in   in pls_integer
)
is
   l_current_year pls_integer := start_year_in;
begin
   loop
      exit when l_current_year > end_year_in;
      display_total_sales (l_current_year);
      l_current_year :=  l_current_year + 1;
   end loop;
end display_multiple_years;

procedure display_multiple_years (
   start_year_in   in pls_integer
 , end_year_in     in pls_integer)
is
   cursor years_cur
   is
      select *
        from sales_data
       where year between start_year_in and end_year_in;

   l_year   sales_data%rowtype;
begin
   open years_cur;

   loop
      fetch years_cur into l_year;

      exit when years_cur%notfound;

      display_total_sales (l_year);
   end loop;

   close years_cur;
end display_multiple_years;

procedure display_multiple_years (
   start_year_in in pls_integer
  ,end_year_in   in pls_integer
)
is
   l_current_year pls_integer := start_year_in;
begin
   while (l_current_year <= end_year_in)
   loop
      display_total_sales (l_current_year);
      l_current_year :=  l_current_year + 1;
   end loop;
end display_multiple_years;

procedure display_multiple_years (
   start_year_in   in pls_integer
 , end_year_in     in pls_integer)
is
begin
   for l_current_year in start_year_in .. end_year_in
   loop
      display_total_sales_for_year (l_current_year);

      exit when total_sales_for_year (l_current_year) = 0;
   end loop;
end display_multiple_years;

procedure display_multiple_years (
   start_year_in   in pls_integer
 , end_year_in     in pls_integer)
is
   l_current_year pls_integer := start_year_in;
begin
   while ( l_current_year <= end_year_in
         and total_sales_for_year (l_current_year) > 0)
   loop
      display_total_sales_for_year (l_current_year);
       l_current_year := l_current_year + 1;
   end loop;
end display_multiple_years;

function total_sales (
   start_year_in   in pls_integer
 , end_year_in     in pls_integer)
   return pls_integer
is
   l_return   pls_integer := 0;
begin
   for l_current_year in start_year_in .. end_year_in
   loop
      if total_sales_for_year (l_current_year) = 0
      then
         return l_return;
      else
         l_return := 
            l_return + total_sales_for_year (l_current_year);
      end if;
   end loop;

   return l_return;
end total_sales;

function total_sales (
   start_year_in   in pls_integer
 , end_year_in     in pls_integer)
   return pls_integer
is
   l_current_year   pls_integer := start_year_in;
   l_return         pls_integer := 0;
begin
   while (l_current_year <= end_year_in 
      and total_sales_for_year (l_current_year) > 0)
   loop
      l_return := l_return + total_sales_for_year (l_current_year);
      l_current_year := l_current_year + 1;
   end loop;

   return l_return;
end total_sales;