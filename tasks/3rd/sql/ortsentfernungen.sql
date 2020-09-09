--create database ortsentf;
--go

-- Übungen:
-- 1. Erklären Sie alle Constraints in den DDL-Kommandos.
-- 2. Welches Constraint fehlt in "entfernt"? Ergänzen Sie das
--    fehlende Constraint und führen Sie die DDL-Befehle nochmals aus.
-- 3. Zeichnen Sie ein relationales Datenmodell (Notation siehe Skriptum
--    S. 85)
-- 4. Welchen Zweck haben "begin transaction" und "commit"?
--Zusammenfassen von Befehlen in eine Gruppe und dann alle gleichzeitig ausführen

use ortsentf;
go

-- Ortsentfernungen

drop table entfernt;
drop table ort;
go

create table ort (
    onr integer primary key,
    oname varchar(24) not null
);
go

create table entfernt (
    onr1 integer references ort,
    onr2 integer references ort,
    entfernung decimal(12, 2) not null check(entfernung > 0),
    check (onr1 != onr2),
	primary key(onr1, onr2)
);
go

-- Orte

set nocount on

begin transaction;

delete from ort;

insert into ort values (1,  'Wiener Neustadt');
insert into ort values (2,  'Mödling');
insert into ort values (3,  'Neunkirchen');
insert into ort values (4,  'Ebenfurth');
insert into ort values (5,  'Sollenau');
insert into ort values (6,  'Innsbruck');
insert into ort values (7,  'Katzelsdorf');
insert into ort values (8,  'Bad Fischau');
insert into ort values (9,  'Graz');
insert into ort values (10, 'Felixdorf');
insert into ort values (11, 'Steinabrückl');
insert into ort values (12, 'Theresienfeld');
insert into ort values (13, 'Pernitz');
insert into ort values (14, 'Gutenstein');
insert into ort values (15, 'Leoben');
insert into ort values (16, 'Amstetten');
insert into ort values (17, 'Gmunden');
insert into ort values (18, 'Salzburg');
insert into ort values (19, 'Enzesfeld');
insert into ort values (20, 'Leithaprodersdorf');
insert into ort values (21, 'Pfaffstätten');
insert into ort values (22, 'Traiskirchen');

commit;

-- Entfernungen

begin transaction;

delete from entfernt;


-- Wiener Neustadt

insert into entfernt values (1, 2, 46.9);  -- Mödling
insert into entfernt values (1, 3, 14.3);  -- Neunkirchen
insert into entfernt values (1, 4, 14.8);  -- Ebenfurth
insert into entfernt values (1, 5, 20.5);  -- Sollenau
insert into entfernt values (1, 6, 526);   -- Innsbruck
insert into entfernt values (1, 7, 4.7);   -- Katzelsdorf
insert into entfernt values (1, 8, 7.3);   -- Bad Fischau
insert into entfernt values (1, 9, 143);   -- Graz
insert into entfernt values (1, 10, 18.4); -- Felixdorf
insert into entfernt values (1, 11, 15.7); -- Steinabrückl
insert into entfernt values (1, 12, 8);    -- Theresienfeld
insert into entfernt values (1, 13, 32.2); -- Pernitz
insert into entfernt values (1, 14, 38.1); -- Gutenstein
insert into entfernt values (1, 15, 108);  -- Leoben
insert into entfernt values (1, 16, 180);  -- Amstetten
insert into entfernt values (1, 17, 286);  -- Gmunden
insert into entfernt values (1, 18, 345);  -- Salzburg
insert into entfernt values (1, 19, 25.3); -- Enzesfeld
insert into entfernt values (1, 20, 46.1); -- Leithaprodersdorf
insert into entfernt values (1, 21, 33.7); -- Pfaffstätten
insert into entfernt values (1, 22, 33.9); -- Traiskirchen

-- Mödling

insert into entfernt values (2, 1, 46.9);  -- Wiener Neustadt
insert into entfernt values (2, 3, 53.2);  -- Neunkirchen
insert into entfernt values (2, 4, 30.9);  -- Ebenfurth
insert into entfernt values (2, 5, 31.2);  -- Sollenau
insert into entfernt values (2, 6, 476);   -- Innsbruck
insert into entfernt values (2, 7, 48.7);  -- Katzelsdorf
insert into entfernt values (2, 8, 38.3);  -- Bad Fischau
insert into entfernt values (2, 9, 182);   -- Graz
insert into entfernt values (2, 10, 32.8); -- Felixdorf
insert into entfernt values (2, 11, 37.3); -- Steinabrückl
insert into entfernt values (2, 12, 40.7); -- Theresienfeld
insert into entfernt values (2, 13, 52.8); -- Pernitz
insert into entfernt values (2, 14, 58.7); -- Gutenstein
insert into entfernt values (2, 15, 146);  -- Leoben
insert into entfernt values (2, 16, 130);  -- Amstetten
insert into entfernt values (2, 17, 236);  -- Gmunden
insert into entfernt values (2, 18, 296);  -- Salzburg
insert into entfernt values (2, 19, 27.8); -- Enzesfeld
insert into entfernt values (2, 20, 27.7); -- Leithaprodersdorf
insert into entfernt values (2, 21, 9.2);  -- Pfaffstätten
insert into entfernt values (2, 22, 8.7);  -- Traiskirchen


-- Neunkirchen

insert into entfernt values (3, 1, 14.3);   -- Wiener Neustadt
insert into entfernt values (3, 2, 54.5);   -- Mödling
insert into entfernt values (3, 4, 35.9);   -- Ebenfurth
insert into entfernt values (3, 5, 28.2);   -- Sollenau
insert into entfernt values (3, 6, 534);    -- Innsbruck
insert into entfernt values (3, 7, 17.4);   -- Katzelsdorf
insert into entfernt values (3, 8, 13.6);   -- Bad Fischau
insert into entfernt values (3, 9, 138);    -- Graz
insert into entfernt values (3, 10, 26.1);  -- Felixdorf
insert into entfernt values (3, 11, 23.3);  -- Steinabrückl
insert into entfernt values (3, 12, 26.7);  -- Theresienfeld
insert into entfernt values (3, 13, 39.8);  -- Pernitz
insert into entfernt values (3, 14, 45.8);  -- Gutenstein
insert into entfernt values (3, 15, 94.6);  -- Leoben
insert into entfernt values (3, 16, 187);   -- Amstetten
insert into entfernt values (3, 17, 293);   -- Gmunden
insert into entfernt values (3, 18, 353);   -- Salzburg
insert into entfernt values (3, 19, 32.9);  -- Enzesfeld
insert into entfernt values (3, 20, 57.1);  -- Leithaprodersdorf
insert into entfernt values (3, 21, 41.4);  -- Pfaffstätten
insert into entfernt values (3, 22, 41.5);  -- Traiskirchen

-- Ebenfurth

insert into entfernt values (4, 1, 13.8);   -- Wiener Neustadt
insert into entfernt values (4, 2, 31.7);   -- Mödling
insert into entfernt values (4, 3, 28.1);   -- Neunkirchen
insert into entfernt values (4, 5, 10.7);   -- Sollenau
insert into entfernt values (4, 6, 511);    -- Innsbruck
insert into entfernt values (4, 7, 16.1);   -- Katzelsdorf
insert into entfernt values (4, 8, 18.4);   -- Bad Fischau
insert into entfernt values (4, 9, 165);    -- Graz
insert into entfernt values (4, 10, 10.6);  -- Felixdorf
insert into entfernt values (4, 11, 16.3);  -- Steinabrückl
insert into entfernt values (4, 12, 10.3);  -- Theresienfeld
insert into entfernt values (4, 13, 35.5);  -- Pernitz
insert into entfernt values (4, 14, 41.4);  -- Gutenstein
insert into entfernt values (4, 15, 129);   -- Leoben
insert into entfernt values (4, 16, 165);   -- Amstetten
insert into entfernt values (4, 17, 270);   -- Gmunden
insert into entfernt values (4, 18, 330);   -- Salzburg
insert into entfernt values (4, 19, 18.5);  -- Enzesfeld
insert into entfernt values (4, 20, 13.3);  -- Leithaprodersdorf
insert into entfernt values (4, 21, 22.1);  -- Pfaffstätten
insert into entfernt values (4, 22, 20.4);  -- Traiskirchen

-- Sollenau

insert into entfernt values (5, 1,  11.1);  -- Wr. Neustadt
insert into entfernt values (5, 2,  32.3);  -- Mödling
insert into entfernt values (5, 3,  28.4);  -- Neunkirchen
insert into entfernt values (5, 4,  10.7);  -- Ebenfurth
insert into entfernt values (5, 6,  490);   -- Innsbruck
insert into entfernt values (5, 7,  23.9);  -- Katzelsdorf
insert into entfernt values (5, 8,  10.7);  -- Bad Fischau
insert into entfernt values (5, 9,  157);   -- Graz
insert into entfernt values (5, 10, 2.1);   -- Felixdorf
insert into entfernt values (5, 11, 8.2);   -- Steinabrückl
insert into entfernt values (5, 12, 4.3);   -- Theresienfeld
insert into entfernt values (5, 13, 27.7);  -- Pernitz
insert into entfernt values (5, 14, 33.7);  -- Gutenstein
insert into entfernt values (5, 15, 122);   -- Leoben
insert into entfernt values (5, 16, 144);   -- Amstetten
insert into entfernt values (5, 17, 250);   -- Gmunden
insert into entfernt values (5, 18, 309);   -- Salzburg
insert into entfernt values (5, 19, 7.8);   -- Enzesfeld
insert into entfernt values (5, 20, 22.8);  -- Leithaprodersdorf
insert into entfernt values (5, 21, 15.6);  -- Pfaffstätten
insert into entfernt values (5, 22, 14.6);  -- Traiskirchen

-- Innsbruck

insert into entfernt values (6, 1,  523);   -- Wiener Neustadt
insert into entfernt values (6, 2,  476);   -- Mödling
insert into entfernt values (6, 3,  532);   -- Neunkirchen
insert into entfernt values (6, 4,  510);   -- Ebenfurth
insert into entfernt values (6, 5,  510);   -- Sollenau
insert into entfernt values (6, 7,  528);   -- Katzelsdorf
insert into entfernt values (6, 8,  517);   -- Bad Fischau
insert into entfernt values (6, 9,  458);   -- Graz
insert into entfernt values (6, 10, 512);   -- Felixdorf
insert into entfernt values (6, 11, 514);   -- Steinabrückl
insert into entfernt values (6, 12, 520);   -- Theresienfeld
insert into entfernt values (6, 13, 489);   -- Pernitz
insert into entfernt values (6, 14, 495);   -- Gutenstein
insert into entfernt values (6, 15, 418);   -- Leoben
insert into entfernt values (6, 16, 352);   -- Amstetten
insert into entfernt values (6, 17, 257);   -- Gmunden
insert into entfernt values (6, 18, 186);   -- Salzburg
insert into entfernt values (6, 19, 482);   -- Enzesfeld
insert into entfernt values (6, 20, 507);   -- Leithaprodersdorf
insert into entfernt values (6, 21, 475);   -- Pfaffstätten
insert into entfernt values (6, 22, 477);   -- Traiskirchen

-- Katzelsdorf

insert into entfernt values (7, 1, 4.7);    -- Wiener Neustadt
insert into entfernt values (7, 2, 48.2);   -- Mödling
insert into entfernt values (7, 3, 17.6);   -- Neunkirchen
insert into entfernt values (7, 4, 16.7);   -- Ebenfurth
insert into entfernt values (7, 5, 21.8);   -- Sollenau
insert into entfernt values (7, 6, 527);    -- Innsbruck
insert into entfernt values (7, 8, 12.8);   -- Bad Fischau
insert into entfernt values (7, 9, 146);    -- Graz
insert into entfernt values (7, 10, 19.7);  -- Felixdorf
insert into entfernt values (7, 11, 17.0);  -- Steinabrückl
insert into entfernt values (7, 12, 20.3);  -- Theresienfeld
insert into entfernt values (7, 13, 33.4);  -- Pernitz
insert into entfernt values (7, 14, 39.4);  -- Gutenstein
insert into entfernt values (7, 15, 111);   -- Leoben
insert into entfernt values (7, 16, 181);   -- Amstetten
insert into entfernt values (7, 17, 287);   -- Gmunden
insert into entfernt values (7, 18, 346);   -- Salzburg
insert into entfernt values (7, 19, 26.6);  -- Enzesfeld
insert into entfernt values (7, 20, 40.8);  -- Leithaprodersdorf
insert into entfernt values (7, 21, 35);    -- Pfaffstätten
insert into entfernt values (7, 22, 35.2);  -- Traiskirchen

-- Bad Fischau

insert into entfernt values (8, 1, 7.5);    -- Wiener Neustadt
insert into entfernt values (8, 2, 39);     -- Mödling
insert into entfernt values (8, 3, 13.6);   -- Neunkirchen
insert into entfernt values (8, 4, 18.5);   -- Ebenfurth
insert into entfernt values (8, 5, 10.8);   -- Sollenau
insert into entfernt values (8, 6, 518);    -- Innsbruck
insert into entfernt values (8, 7, 15.5);   -- Katzelsdorf
insert into entfernt values (8, 9, 149);    -- Graz
insert into entfernt values (8, 10, 8.7);   -- Felixdorf
insert into entfernt values (8, 11, 6.1);   -- Steinabrückl
insert into entfernt values (8, 12, 9.3);   -- Theresienfeld
insert into entfernt values (8, 13, 24);    -- Pernitz
insert into entfernt values (8, 14, 30);    -- Gutenstein
insert into entfernt values (8, 15, 113);   -- Leoben
insert into entfernt values (8, 16, 172);   -- Amstetten
insert into entfernt values (8, 17, 278);   -- Gmunden
insert into entfernt values (8, 18, 337);   -- Salzburg
insert into entfernt values (8, 19, 17.4);  -- Enzesfeld
insert into entfernt values (8, 20, 31.9);  -- Leithaprodersdorf
insert into entfernt values (8, 21, 25.8);  -- Pfaffstätten
insert into entfernt values (8, 22, 25.9);  -- Traiskirchen

-- Graz

insert into entfernt values (9, 1,  144);   -- Wiener Neustadt
insert into entfernt values (9, 2,  184);   -- Mödling
insert into entfernt values (9, 3,  139);   -- Neunkirchen
insert into entfernt values (9, 4,  165);   -- Ebenfurth
insert into entfernt values (9, 5,  157);   -- Sollenau
insert into entfernt values (9, 6,  459);   -- Innsbruck
insert into entfernt values (9, 7,  147);   -- Katzelsdorf
insert into entfernt values (9, 8,  149);   -- Bad Fischau
insert into entfernt values (9, 10, 155);   -- Felixdorf
insert into entfernt values (9, 11, 152);   -- Steinabrückl
insert into entfernt values (9, 12, 156);   -- Theresienfeld
insert into entfernt values (9, 13, 169);   -- Pernitz
insert into entfernt values (9, 14, 174);   -- Gutenstein
insert into entfernt values (9, 15, 60.5);  -- Leoben
insert into entfernt values (9, 16, 260);   -- Amstetten
insert into entfernt values (9, 17, 198);   -- Gmunden
insert into entfernt values (9, 18, 277);   -- Salzburg
insert into entfernt values (9, 19, 161);   -- Enzesfeld
insert into entfernt values (9, 20, 185);   -- Leithaprodersdorf
insert into entfernt values (9, 21, 169);   -- Pfaffstätten
insert into entfernt values (9, 22, 170);   -- Traiskirchen

-- Felixdorf

insert into entfernt values (10, 1,  18.4); -- Wiener Neustadt
insert into entfernt values (10, 2,  32.8); -- Moedling
insert into entfernt values (10, 3,  26.1); -- Neunkirchen
insert into entfernt values (10, 4,  10.6); -- Ebenfurth
insert into entfernt values (10, 5,  2.1);  -- Sollenau
insert into entfernt values (10, 6,  512);  -- Innsbruck
insert into entfernt values (10, 7,  19.7); -- Katzelsdorf
insert into entfernt values (10, 8,  8.7);  -- Bad Fischau
insert into entfernt values (10, 9,  155);  -- Graz
insert into entfernt values (10, 11, 6.1);  -- Steinabrückl
insert into entfernt values (10, 12, 2.7);  -- Theresienfeld
insert into entfernt values (10, 13, 24.2); -- Pernitz
insert into entfernt values (10, 14, 30.2); -- Gutenstein
insert into entfernt values (10, 15, 119);  -- Leoben
insert into entfernt values (10, 16, 165);  -- Amstetten
insert into entfernt values (10, 17, 268);  -- Gmunden
insert into entfernt values (10, 18, 331);  -- Salzburg
insert into entfernt values (10, 19, 7.2);  -- Enzesfeld
insert into entfernt values (10, 20, 23.1); -- Leithaprodersdorf
insert into entfernt values (10, 21, 20.2); -- Pfaffstätten
insert into entfernt values (10, 22, 20.8); -- Traiskirchen

-- Steinabrückl

insert into entfernt values (11, 1, 10.3);    -- Wiener Neustadt
insert into entfernt values (11, 2, 37.8);    -- Mödling
insert into entfernt values (11, 3, 23.6);    -- Neunkirchen
insert into entfernt values (11, 4,  14);     -- Ebenfurth
insert into entfernt values (11, 5,  5.5);    -- Sollenau
insert into entfernt values (11, 6, 517);     -- Innsbruck
insert into entfernt values (11, 7, 19.1);    -- Katzelsdorf
insert into entfernt values (11, 8,  5.9);    -- Bad Fischau
insert into entfernt values (11, 9,  152);    -- Graz
insert into entfernt values (11, 10, 3.4);    -- Felixdorf
insert into entfernt values (11, 12, 6.1);    -- Theresienfeld
insert into entfernt values (11, 13, 21.3);   -- Pernitz
insert into entfernt values (11, 14, 27.2);   -- Gutenstein
insert into entfernt values (11, 15, 117);    -- Leoben
insert into entfernt values (11, 16, 171);    -- Amstetten
insert into entfernt values (11, 17, 277);    -- Gmunden
insert into entfernt values (11, 18, 336);    -- Salzburg
insert into entfernt values (11, 19, 5.9);    -- Enzesfeld
insert into entfernt values (11, 20, 26.1);   -- Leithaprodersdorf
insert into entfernt values (11, 21, 24.7);   -- Pfaffstätten
insert into entfernt values (11, 22, 24.8);   -- Traiskirchen

-- Theresienfeld

insert into entfernt values (12, 1, 6.9);     -- Wiener Neustadt
insert into entfernt values (12, 2, 37.8 );   -- Mödling
insert into entfernt values (12, 3,  27 );    -- Neunkirchen
insert into entfernt values (12, 4,   10.3);  -- Ebenfurth
insert into entfernt values (12, 5,   4.3);   -- Sollenau
insert into entfernt values (12, 6,   520);   -- Innsbruck
insert into entfernt values (12, 7,   10.4);  -- Katzelsdorf
insert into entfernt values (12, 8,   9.3);   -- Bad Fischau
insert into entfernt values (12, 9,   156);   -- Graz
insert into entfernt values (12, 10,  2.7);   -- Felixdorf
insert into entfernt values (12, 11,  8.4);   -- Steinabrückl
insert into entfernt values (12, 13,  26.3);  -- Pernitz
insert into entfernt values (12, 14,  32.2);  -- Gutenstein
insert into entfernt values (12, 15,  120);   -- Leoben
insert into entfernt values (12, 16,  174);   -- Amstetten
insert into entfernt values (12, 17,  280);   -- Gmunden
insert into entfernt values (12, 18,  339);   -- Salzburg
insert into entfernt values (12, 19,  9.8);   -- Enzesfeld
insert into entfernt values (12, 20,  23.6);  -- Leithaprodersdorf
insert into entfernt values (12, 21,  28);    -- Pfaffstätten
insert into entfernt values (12, 22,  28.1);  -- Traiskirchen

-- Pernitz

insert into entfernt values (13, 1,  30.2)    -- Wiener Neustadt
insert into entfernt values (13, 2,  54.5);   -- Mödling
insert into entfernt values (13, 3,  39.2);   -- Neunkirchen
insert into entfernt values (13, 4,  35.5);   -- Ebenfurth
insert into entfernt values (13, 5,  26.4);   -- Sollenau
insert into entfernt values (13, 6,   489);   -- Innsbruck
insert into entfernt values (13, 7,  34.7);   -- Katzelsdorf
insert into entfernt values (13, 8,  23.9);   -- Bad Fischau
insert into entfernt values (13, 9,   168);   -- Graz
insert into entfernt values (13, 10, 24.2);   -- Felixdorf
insert into entfernt values (13, 11, 21.3);   -- Steinabrückl
insert into entfernt values (13, 12, 26.3);   -- Theresienfeld
insert into entfernt values (13, 14,  6.1);   -- Gutenstein
insert into entfernt values (13, 15,  132);   -- Leoben
insert into entfernt values (13, 16,  143);   -- Amstetten
insert into entfernt values (13, 17,  249);   -- Gmunden
insert into entfernt values (13, 18,  309);   -- Salzburg
insert into entfernt values (13, 19, 33.3);   -- Enzesfeld
insert into entfernt values (13, 20, 48.9);   -- Leithaprodersdorf
insert into entfernt values (13, 21, 41.4);   -- Pfaffstätten
insert into entfernt values (13, 22, 41.5);   -- Traiskirchen

-- Gutenstein

insert into entfernt values (14, 1,  36.1);   -- Wiener Neustadt
insert into entfernt values (14, 2,  60.5);   -- Mödling
insert into entfernt values (14, 3,  45.2);   -- Neunkirchen
insert into entfernt values (14, 4,  41.5);   -- Ebenfurth
insert into entfernt values (14, 5,  32.3);   -- Sollenau
insert into entfernt values (14, 6,   495);   -- Innsbruck
insert into entfernt values (14, 7,  40.7);   -- Katzelsdorf
insert into entfernt values (14, 8,  29.9);   -- Bad Fischau
insert into entfernt values (14, 9,   174);   -- Graz
insert into entfernt values (14, 10, 30.2);   -- Felixdorf
insert into entfernt values (14, 11, 27.2);   -- Steinabrückl
insert into entfernt values (14, 12, 32.3);   -- Theresienfeld
insert into entfernt values (14, 13,  6.1);   -- Pernitz
insert into entfernt values (14, 15,  138);   -- Leoben
insert into entfernt values (14, 16,  149);   -- Amstetten
insert into entfernt values (14, 17,  255);   -- Gmunden
insert into entfernt values (14, 18,  315);   -- Salzburg
insert into entfernt values (14, 19, 39.3);   -- Enzesfeld
insert into entfernt values (14, 20, 54.8);   -- Leithaprodersdorf
insert into entfernt values (14, 21, 47.3);   -- Pfaffstätten
insert into entfernt values (14, 22, 47.4);   -- Traiskirchen

-- Leoben

insert into entfernt values (15, 1,  108);  -- Wiener Neustadt
insert into entfernt values (15, 2,  147);  -- Mödling
insert into entfernt values (15, 3,  94.6); -- Neunkirchen
insert into entfernt values (15, 4,  129);  -- Ebenfurth
insert into entfernt values (15, 5,  121);  -- Sollenau
insert into entfernt values (15, 6,  418);  -- Innsbruck
insert into entfernt values (15, 7,  110);  -- Katzelsdorf
insert into entfernt values (15, 8,  113);  -- Bad Fischau
insert into entfernt values (15, 9,  60.5); -- Graz
insert into entfernt values (15, 10, 119);  -- Felixdorf
insert into entfernt values (15, 11, 115);  -- Steinabrückl
insert into entfernt values (15, 12, 119);  -- Theresienfeld
insert into entfernt values (15, 13, 132);  -- Pernitz
insert into entfernt values (15, 14, 138);  -- Gutenstein
insert into entfernt values (15, 16, 128);  -- Amstetten
insert into entfernt values (15, 17, 158);  -- Gmunden
insert into entfernt values (15, 18, 238);  -- Salzburg
insert into entfernt values (15, 19, 126);  -- Enzesfeld
insert into entfernt values (15, 20, 150);  -- Leithaprodersdorf
insert into entfernt values (15, 21, 134);  -- Pfaffstätten
insert into entfernt values (15, 22, 134);  -- Traiskirchen

-- Amstetten

insert into entfernt values (16, 1,   177); -- Wiener Neustadt
insert into entfernt values (16, 2,   129); -- Mödling
insert into entfernt values (16, 3,   186); -- Neunkirchen
insert into entfernt values (16, 4,   163); -- Ebenfurth
insert into entfernt values (16, 5,   164); -- Sollenau
insert into entfernt values (16, 6,   353); -- Innsbruck
insert into entfernt values (16, 7,   181); -- Katzelsdorf
insert into entfernt values (16, 8,   171); -- Bad Fischau
insert into entfernt values (16, 9,   260); -- Graz
insert into entfernt values (16, 10,  165); -- Felixdorf
insert into entfernt values (16, 11,  170); -- Steinabrückl
insert into entfernt values (16, 12,  173); -- Theresienfeld
insert into entfernt values (16, 13,  143); -- Pernitz
insert into entfernt values (16, 14,  149); -- Gutenstein
insert into entfernt values (16, 15,  125); -- Leoben
insert into entfernt values (16, 17,  112); -- Gmunden
insert into entfernt values (16, 18,  172); -- Salzburg
insert into entfernt values (16, 19,  136); -- Enzesfeld
insert into entfernt values (16, 20,  160); -- Leithaprodersdorf
insert into entfernt values (16, 21,  128); -- Pfaffstätten
insert into entfernt values (16, 22,  131); -- Traiskirchen

-- Gmunden

insert into entfernt values (17, 1,  279);    -- Wiener Neustadt
insert into entfernt values (17, 2,  232);    -- Mödling
insert into entfernt values (17, 3,  252);    -- Neunkirchen
insert into entfernt values (17, 4,  266);    -- Ebenfurth
insert into entfernt values (17, 5,  266);    -- Sollenau
insert into entfernt values (17, 6,  526);    -- Innsbruck
insert into entfernt values (17, 7,  284);    -- Katzelsdorf
insert into entfernt values (17, 8,  273);    -- Bad Fischau
insert into entfernt values (17, 9,  198);    -- Graz
insert into entfernt values (17, 10, 268);    -- Felixdorf
insert into entfernt values (17, 11, 270);    -- Steinabrückl
insert into entfernt values (17, 12, 276);    -- Theresienfeld
insert into entfernt values (17, 13, 245);    -- Pernitz
insert into entfernt values (17, 14, 251);    -- Gutenstein
insert into entfernt values (17, 15, 159);    -- Leoben
insert into entfernt values (17, 16, 108);    -- Amstetten
insert into entfernt values (17, 18, 75.9);   -- Salzburg
insert into entfernt values (17, 19, 238);    -- Enzesfeld
insert into entfernt values (17, 20, 263);    -- Leithaprodersdorf
insert into entfernt values (17, 21, 231);    -- Pfaffstätten
insert into entfernt values (17, 22, 233);    -- Traiskirchen

-- Salzburg

insert into entfernt values (18, 1,   342);   -- Wiener Neustadt
insert into entfernt values (18, 2,   295);   -- Mödling
insert into entfernt values (18, 3,   351);   -- Neunkirchen
insert into entfernt values (18, 4,   329);   -- Ebenfurth
insert into entfernt values (18, 5,   329);   -- Sollenau
insert into entfernt values (18, 6,   190);   -- Innsbruck
insert into entfernt values (18, 7,   346);   -- Katzelsdorf
insert into entfernt values (18, 8,   326);   -- Bad Fischau
insert into entfernt values (18, 9,   277);   -- Graz
insert into entfernt values (18, 10,  331);   -- Felixdorf
insert into entfernt values (18, 11,  333);   -- Steinabrückl
insert into entfernt values (18, 12,  338);   -- Theresienfeld
insert into entfernt values (18, 13,  308);   -- Pernitz
insert into entfernt values (18, 14,  314);   -- Gutenstein
insert into entfernt values (18, 15,  237);   -- Leoben
insert into entfernt values (18, 16,  171);   -- Amstetten
insert into entfernt values (18, 17,  75.8);  -- Gmunden
insert into entfernt values (18, 19,  301);   -- Enzesfeld
insert into entfernt values (18, 20,  325);   -- Leithaprodersdorf
insert into entfernt values (18, 21,  294);   -- Pfaffstätten
insert into entfernt values (18, 22,  296);   -- Traiskirchen

-- Enzesfeld

insert into entfernt values (19, 1, 22.8);   -- Wiener Neustadt
insert into entfernt values (19, 2, 28.9);   -- Mödling
insert into entfernt values (19, 3, 31.9);   -- Neunkirchen
insert into entfernt values (19, 4, 18.4);   -- Ebenfurth
insert into entfernt values (19, 5, 7.7);    -- Sollenau
insert into entfernt values (19, 6, 483);    -- Innsbruck
insert into entfernt values (19, 7, 27.3);   -- Katzelsdorf
insert into entfernt values (19, 8, 16.9);   -- Bad Fischau
insert into entfernt values (19, 9, 161);    -- Graz
insert into entfernt values (19, 10, 7.2);   -- Felixdorf
insert into entfernt values (19, 11, 6.8);   -- Steinabrückl
insert into entfernt values (19, 12, 8.8);   -- Theresienfeld
insert into entfernt values (19, 13, 31.4);  -- Pernitz
insert into entfernt values (19, 14, 37.4);  -- Gutenstein
insert into entfernt values (19, 15, 125);   -- Leoben
insert into entfernt values (19, 16, 137);   -- Amstetten
insert into entfernt values (19, 17, 243);   -- Gmunden
insert into entfernt values (19, 18, 302);   -- Salzburg
insert into entfernt values (19, 20, 31.1);  -- Leithaprodersdorf
insert into entfernt values (19, 21, 15.7);  -- Pfaffstätten
insert into entfernt values (19, 22, 15.8);  -- Traiskirchen

-- Leithaprodersdorf

insert into entfernt values (20, 1, 27.6);   -- Wiener Neustadt
insert into entfernt values (20, 2, 28.0);   -- Mödling
insert into entfernt values (20, 3, 56.5);   -- Neunkirchen
insert into entfernt values (20, 4, 13.8);   -- Ebenfurth
insert into entfernt values (20, 5, 23.3);   -- Sollenau
insert into entfernt values (20, 6, 507);    -- Innsbruck
insert into entfernt values (20, 7, 40.6);   -- Katzelsdorf
insert into entfernt values (20, 8, 32.3);   -- Bad Fischau
insert into entfernt values (20, 9, 185);    -- Graz
insert into entfernt values (20, 10, 23.1);  -- Felixdorf
insert into entfernt values (20, 11, 26.6);  -- Steinabrückl
insert into entfernt values (20, 12, 24.1);  -- Theresienfeld
insert into entfernt values (20, 13, 49.3);  -- Pernitz
insert into entfernt values (20, 14, 55.4);  -- Gutenstein
insert into entfernt values (20, 15, 150);   -- Leoben
insert into entfernt values (20, 16, 161);   -- Amstetten
insert into entfernt values (20, 17, 267);   -- Gmunden
insert into entfernt values (20, 18, 326);   -- Salzburg
insert into entfernt values (20, 19, 30.6);  -- Enzesfeld
insert into entfernt values (20, 21, 22.6);  -- Pfaffstätten
insert into entfernt values (20, 22, 21.0);  -- Traiskirchen

-- Pfaffstätten

insert into entfernt values (21, 1,  31.6);  -- Wiener Neustadt
insert into entfernt values (21, 2,  9.2);   -- Mödling
insert into entfernt values (21, 3,  40.6);  -- Neunkirchen
insert into entfernt values (21, 4,  22.7);  -- Ebenfurth
insert into entfernt values (21, 5,  18.7);  -- Sollenau
insert into entfernt values (21, 6,  475);   -- Innsbruck
insert into entfernt values (21, 7,  36.1);  -- Katzelsdorf
insert into entfernt values (21, 8,  25.7);  -- Bad Fischau
insert into entfernt values (21, 9,  169);   -- Graz
insert into entfernt values (21, 10, 20.2);  -- Felixdorf
insert into entfernt values (21, 11, 24.7);  -- Steinabrückl
insert into entfernt values (21, 12, 28.1);  -- Theresienfeld
insert into entfernt values (21, 13, 40.2);  -- Pernitz
insert into entfernt values (21, 14, 46.1);  -- Gutenstein
insert into entfernt values (21, 15, 134);   -- Leoben
insert into entfernt values (21, 16, 129);   -- Amstetten
insert into entfernt values (21, 17, 235);   -- Gmunden
insert into entfernt values (21, 18, 294);   -- Salzburg
insert into entfernt values (21, 19, 15.2);  -- Enzesfeld
insert into entfernt values (21, 20, 22.8);  -- Leithaprodersdorf
insert into entfernt values (21, 22, 2.9);   -- Traiskirchen

-- Traiskirchen

insert into entfernt values (22, 1,  32.2);  -- Wiener Neustadt
insert into entfernt values (22, 2,  8.7);   -- Mödling
insert into entfernt values (22, 3,  41.2);  -- Neunkirchen
insert into entfernt values (22, 4,  21.1);  -- Ebenfurth
insert into entfernt values (22, 5,  19.2);  -- Sollenau
insert into entfernt values (22, 6,  478);   -- Innsbruck
insert into entfernt values (22, 7,  36.7);  -- Katzelsdorf
insert into entfernt values (22, 8,  26.3);  -- Bad Fischau
insert into entfernt values (22, 9,  170);   -- Graz
insert into entfernt values (22, 10, 20.8);  -- Felixdorf
insert into entfernt values (22, 11, 25.3);  -- Steinabrückl
insert into entfernt values (22, 12, 28.7);  -- Theresienfeld
insert into entfernt values (22, 13, 40.8);  -- Pernitz
insert into entfernt values (22, 14, 46.7);  -- Gutenstein
insert into entfernt values (22, 15, 134);   -- Leoben
insert into entfernt values (22, 16, 131);   -- Amstetten
insert into entfernt values (22, 17, 237);   -- Gmunden
insert into entfernt values (22, 18, 297);   -- Salzburg
insert into entfernt values (22, 19, 15.8);  -- Enzesfeld
insert into entfernt values (22, 20, 21.2);  -- Leithaprodersdorf
insert into entfernt values (22, 21, 2.8);   -- Pfaffstätten


commit;
go

select onr1, onr2, entfernt
  from entfernt
