-- 1
DECLARE
   TYPE list_of_names_t IS TABLE OF VARCHAR2 (100);
 
   happyfamily   list_of_names_t := list_of_names_t ();
   children      list_of_names_t := list_of_names_t ();
   parents       list_of_names_t := list_of_names_t ();
BEGIN
   happyfamily.EXTEND (4);
   happyfamily (1) := 'Veva';
   happyfamily (2) := 'Chris';
   happyfamily (3) := 'Eli';
   happyfamily (4) := 'Steven';
 
   children.EXTEND;
   children (children.LAST) := 'Chris';
   children.EXTEND;
   children (children.LAST) := 'Eli';
 
   parents := happyfamily MULTISET EXCEPT children;
 
   FOR l_row IN 1 .. parents.COUNT
   LOOP
      DBMS_OUTPUT.put_line (parents (l_row));
   END LOOP;
END;
/

-- 2
CREATE OR REPLACE PROCEDURE show_contents (
   names_in IN DBMS_UTILITY.maxname_array)
IS
BEGIN
   FOR indx IN names_in.FIRST .. names_in.LAST
   LOOP
      DBMS_OUTPUT.put_line (names_in (indx));
   END LOOP;
END;
/

-- 3
CREATE OR REPLACE PROCEDURE show_contents (
   names_in IN DBMS_UTILITY.maxname_array)
IS
   l_index   PLS_INTEGER := names_in.LAST;
BEGIN
   WHILE (l_index IS NOT NULL)
   LOOP
      DBMS_OUTPUT.put_line (names_in (l_index));
      l_index := names_in.PRIOR (l_index);
   END LOOP;
END;
/

-- A
DECLARE
   l_names   DBMS_UTILITY.maxname_array;
BEGIN
   l_names (1) := 'Strawberry';
   l_names (10) := 'Blackberry';
   l_names (2) := 'Raspberry';

   FOR indx IN 1 .. l_names.COUNT
   LOOP
      DBMS_OUTPUT.put_line (l_names (indx));
   END LOOP;
END;
/

-- B
DECLARE
   l_names   DBMS_UTILITY.maxname_array;
BEGIN
   l_names (1) := 'Strawberry';
   l_names (10) := 'Blackberry';
   l_names (2) := 'Raspberry';

   indx := l_names.FIRST;

   WHILE (indx IS NOT NULL)
   LOOP
      DBMS_OUTPUT.put_line (l_names (indx));
      indx := l_names.NEXT (indx);
   END LOOP;
END;
/

-- C
DECLARE
   l_names   DBMS_UTILITY.maxname_array;
BEGIN
   l_names (1) := 'Strawberry';
   l_names (10) := 'Blackberry';
   l_names (2) := 'Raspberry';

   DECLARE
      indx   PLS_INTEGER := l_names.FIRST;
   BEGIN

      WHILE (indx IS NOT NULL)
      LOOP
         DBMS_OUTPUT.put_line (l_names (indx));
         indx := l_names.NEXT (indx);
      END LOOP;
   END;
END;
/

-- D
DECLARE
   l_names   DBMS_UTILITY.maxname_array;
BEGIN
   l_names (1) := 'Strawberry';
   l_names (10) := 'Blackberry';
   l_names (2) := 'Raspberry';

   FOR indx IN l_names.FIRST .. l_names.LAST
   LOOP
      DBMS_OUTPUT.put_line (l_names (indx));
   END LOOP;
END;
/