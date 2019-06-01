create or replace package htltools
as

    procedure fill_with_randoms(
      counts integer,
      len integer
    );
    
    function add2(
      summand1 varchar,
      summand2 varchar
    ) return varchar;
    
    procedure add_all_summands;
    
    procedure greeting(
      firstname varchar,
      lastname varchar,
      sex char := 'F',
      language char := 'de'
    );
    
    function multiply(
      factor1 integer,
      factor2 integer
    ) return integer;

end;
/
show error;