use sf;

begin transaction;

delete from besucht;
delete from kveranst;
delete from geeignet;
delete from setztvor;
delete from kurs;
delete from referent;
delete from person;
go

set dateformat dmy;

insert into person values (101, 'Bach',          'Johann Sebastian', 'Leipzig',  'D');
insert into person values (102, 'Händel',        'Georg Friedrich',  'London',   'GB');
insert into person values (103, 'Haydn',         'Joseph',           'Wien',     'A');
insert into person values (104, 'Mozart',        'Wolfgang Amadeus', 'Salzburg', 'A');
insert into person values (105, 'Beethoven',     'Ludwig van',       'Wien',     'A');
insert into person values (106, 'Schubert',      'Franz',            'Wien',     'A');
insert into person values (107, 'Berlioz',       'Hector',           'Paris',    'F');
insert into person values (108, 'Liszt',         'Franz',            'Wien',     'A');
insert into person values (109, 'Wagner',        'Richard',          'München',  'D');
insert into person values (110, 'Verdi',         'Giuseppe',         'Busseto',  'I');
insert into person values (111, 'Bruckner',      'Anton',            'Linz',     'A');
insert into person values (112, 'Brahms',        'Johannes',         'Wien',     'A');
insert into person values (113, 'Bizet',         'Georges',          'Paris',    'F');
insert into person values (114, 'Tschaikowskij', 'Peter',            'Moskau',   'RUS');
insert into person values (115, 'Puccini',       'Giacomo',          'Mailand',  'I');
insert into person values (116, 'Strauss',       'Richard',          'München',  'D');
insert into person values (117, 'Schönberg',     'Arnold',           'Wien',     'A');

insert into referent values (101, '21.03.1935', '01.01.1980', null);
insert into referent values (103, '01.04.1932', '01.01.1991', null);
insert into referent values (104, '27.01.1956', '01.07.1985', null);
insert into referent values (111, '04.09.1924', '01.07.1990', 'Mag');
insert into referent values (114, '25.04.1940', '01.07.1980', null);
insert into referent values (116, '11.06.1964', '01.01.1994', 'Dr');

insert into kurs values (1, 'Notenkunde',        2, 1400.00);
insert into kurs values (2, 'Harmonielehre',     3, 2000.00);
insert into kurs values (3, 'Rhythmik',          1,  700.00);
insert into kurs values (4, 'Instrumentenkunde', 2, 1500.00);
insert into kurs values (5, 'Dirigieren',        3, 1900.00);
insert into kurs values (6, 'Musikgeschichte',   2, 1400.00);
insert into kurs values (7, 'Komposition',       4, 3000.00);

insert into setztvor values (2, 1);
insert into setztvor values (3, 1);
insert into setztvor values (5, 2);
insert into setztvor values (5, 3);
insert into setztvor values (5, 4);
insert into setztvor values (7, 5);
insert into setztvor values (7, 6);

insert into geeignet values (1, 103);
insert into geeignet values (1, 114);
insert into geeignet values (2, 104);
insert into geeignet values (2, 111);
insert into geeignet values (3, 103);
insert into geeignet values (4, 104);
insert into geeignet values (5, 101);
insert into geeignet values (5, 114);
insert into geeignet values (6, 111);
insert into geeignet values (7, 103);
insert into geeignet values (7, 116);

insert into kveranst values (1, 1, '07.04.2003', '08.04.2003', 'Wien',    3, 103);
insert into kveranst values (1, 2, '23.06.2004', '24.06.2004', 'Moskau',  4, 114);
insert into kveranst values (1, 3, '10.04.2005', '11.04.2005', 'Paris',   3, null);
insert into kveranst values (2, 1, '09.10.2003', '11.10.2003', 'Wien',    4, 104);
insert into kveranst values (3, 1, '17.11.2003', '17.11.2003', 'Moskau',  3, 103);
insert into kveranst values (4, 1, '12.01.2004', '13.01.2004', 'Wien',    3, 116);
insert into kveranst values (4, 2, '28.03.2004', '29.03.2004', 'Wien',    4, 104);
insert into kveranst values (5, 1, '18.05.2004', '20.05.2004', 'Paris',   3, 101);
insert into kveranst values (5, 2, '23.09.2004', '26.09.2004', 'Wien',    2, 101);
insert into kveranst values (5, 3, '30.03.2005', '01.04.2005', 'Rom',     3, null);
insert into kveranst values (7, 1, '09.03.2005', '13.03.2005', 'Wien',    5, 103);
insert into kveranst values (7, 2, '14.09.2005', '18.09.2005', 'München', 4, 116);

insert into besucht values (1, 1, 108, '01.05.2003');
insert into besucht values (1, 1, 109, null);
insert into besucht values (1, 1, 114, null);
insert into besucht values (1, 2, 110, '01.07.2004');
insert into besucht values (1, 2, 112, '03.07.2004');
insert into besucht values (1, 2, 113, '20.07.2004');
insert into besucht values (1, 2, 116, null);
insert into besucht values (1, 3, 110, null);
insert into besucht values (2, 1, 105, '15.10.2003');
insert into besucht values (2, 1, 109, '03.11.2003');
insert into besucht values (2, 1, 112, '28.10.2003');
insert into besucht values (2, 1, 116, null);
insert into besucht values (3, 1, 101, null);
insert into besucht values (3, 1, 109, null);
insert into besucht values (3, 1, 117, '20.11.2003');
insert into besucht values (4, 1, 102, '20.01.2004');
insert into besucht values (4, 1, 107, '01.02.2004');
insert into besucht values (4, 1, 111, null);
insert into besucht values (4, 2, 106, '07.04.2004');
insert into besucht values (4, 2, 109, '15.04.2004');
insert into besucht values (5, 1, 103, null);
insert into besucht values (5, 1, 109, '07.06.2004');
insert into besucht values (5, 2, 115, '07.10.2004');
insert into besucht values (5, 2, 116, null);
insert into besucht values (7, 1, 109, '20.03.2005');
insert into besucht values (7, 1, 113, null);
insert into besucht values (7, 1, 117, '08.04.2005');

commit;