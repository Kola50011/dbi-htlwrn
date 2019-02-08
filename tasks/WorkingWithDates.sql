-- Listing 1
DECLARE
   l_today_date        DATE := SYSDATE;
   l_today_timestamp   TIMESTAMP := SYSTIMESTAMP;
   l_today_timetzone   TIMESTAMP WITH TIME ZONE := SYSTIMESTAMP;
   l_interval1         INTERVAL YEAR (4) TO MONTH := '2011-11';
   l_interval2         INTERVAL DAY (2) TO SECOND := '15 00:30:44';
BEGIN
   null;
END;
/

-- Listing 2
BEGIN
  DBMS_OUTPUT.put_line (SYSDATE);
  DBMS_OUTPUT.put_line (SYSTIMESTAMP);
  DBMS_OUTPUT.put_line (SYSDATE - SYSTIMESTAMP);
END;
/

-- Listing 3
BEGIN
   DBMS_OUTPUT.put_line (
      ADD_MONTHS (TO_DATE ('31-jan-2011', 'DD-MON-YYYY'), 1));
   DBMS_OUTPUT.put_line (
      ADD_MONTHS (TO_DATE ('27-feb-2011', 'DD-MON-YYYY'), -1));
   DBMS_OUTPUT.put_line (
      ADD_MONTHS (TO_DATE ('28-feb-2011', 'DD-MON-YYYY'), -1));
END;
/


-- Other examples
BEGIN
   DBMS_OUTPUT.put_line (
     TO_CHAR (SYSDATE));
   DBMS_OUTPUT.put_line (
     TO_CHAR (SYSTIMESTAMP));
END;
/

BEGIN
   DBMS_OUTPUT.put_line (
TO_CHAR (SYSDATE, 
'Day, DDth Month YYYY'));
END;
/

BEGIN
  DBMS_OUTPUT.put_line (
    TO_CHAR (SYSDATE, 
'Day, DDth Month YYYY', 
'NLS_DATE_LANGUAGE=Spanish'));
END;
/

BEGIN
  DBMS_OUTPUT.put_line (
     TO_CHAR (SYSDATE, 
'FMDay, DDth Month YYYY'));
END;
/

BEGIN
  DBMS_OUTPUT.put_line (
    TO_CHAR (SYSDATE, 
'YYYY-MM-DD HH24:MI:SS'));
END;
/

DECLARE
  l_date   DATE;
BEGIN
  l_date := TO_DATE ('12-JAN-2011');
END	;

DECLARE
  l_date   DATE;
BEGIN
  l_date := TO_DATE ('January 12 2011');
END;
/

DECLARE
   l_date1   DATE := SYSDATE;
   l_date2   DATE := SYSDATE + 10;
BEGIN
   DBMS_OUTPUT.put_line (
      l_date2 - l_date1);
   DBMS_OUTPUT.put_line (
      l_date1 - l_date2);
END;

-- Q1
CREATE OR REPLACE FUNCTION plch_first_day (date_in IN DATE)
   RETURN DATE
IS
BEGIN
   RETURN TRUNC (date_in);
END;
/

CREATE OR REPLACE FUNCTION plch_first_day (date_in IN DATE)
   RETURN DATE
IS
BEGIN
   RETURN TRUNC (date_in, 'MM');
END;
/


CREATE OR REPLACE FUNCTION plch_first_day (date_in IN DATE)
   RETURN DATE
IS
BEGIN
   RETURN TRUNC (date_in, 'MONTH');
END;
/

CREATE OR REPLACE FUNCTION plch_first_day (date_in IN DATE)
   RETURN DATE
IS
BEGIN
   RETURN TO_DATE (TO_CHAR (date_in, 'YYYY-MM') 
|| '-01', 'YYYY-MM-DD');
END;
/
