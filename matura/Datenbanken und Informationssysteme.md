# Datenbanken und Informationssysteme

Allgemein:

- Immer eine Kontext in dem die Fragen gestellt werden
    - z.B.: Sie arbeiten in Firma xy

- Zur Vorbereitung ein gutes zusammenhängendes Beispiel für
    - 1 : 1 Beziehung (Person - Führerschein, Angestellter - Abteilung)
    - 1 : n Beziehung (Schüler - Schule)
    - m : n Beziehung (Lehrer unterrichtet Schüler)

- Beispiele für die Befehlsgruppen wären auch nicht schlecht

- Lieferanten Datenbank anschauen und üben
- Schulungsfirma Datenbank anschauen und üben
- Chiffrierscheibe mitnehmen http://d474base.eu/xwiki/bin/download/DBI4UE/KRYPTO1/chiffrierscheibe.pdf
- Oracle-Architektur
- Datawarehouse-Referenz Modell
- Multidimensionale Modellierung
- XML-Technologien

## 1. Daten- und Informationsmodellierung

### GROUP BY(+ Erweiterungen im DWH) und Aggregatfunktionen(Kapitel 2 im Skriptum und Taschenbuch DB S. 45)

- Eine Aggregatfunktion fasst mehrere Elemente einer Spalte zu einem Element zusammen
- `Group by` ohne Aggregatfunktion macht wenig Sinn
- Alle Datensätze, die den gleichen Wert haben, werden zusammengefasst 
- Fehler wenn im `group by` nicht alle Spalten, die im `select` ohne Aggregatfunktion stehen, drin sind
- Having:
    - `Where` nach dem gruppieren
    - Aggregatfunktion
    - Kann auch ohne group by verwendet werden
- OLAP:
    - `Rollup`
        - Wechselt eine Hierarchieebene nach oben (Aggregiert)
    - `Drilldown`
        - Wechselt eine Hierarchieebene nach unten
    - `Cube`
        - Bildet mehr Zwischenwerte als Rollup

- Bei der Matura steht dann ein Ergebnis einer Abfrage und man muss feststellen können, welche group by Klausel angewandt wurde (Es können auch fehlerhafte Group by Klauseln kommen)
    - Beispiele Seite 457 in der Bibel
        - Decode (Oracle)
            - Wie ein If
            - Wenn beim grouping eine 1 herauskommt wird 'Alle Monate' hingeschrieben

```sql=
group by rollup(a, b, c)
-- {a}
-- {a, b}
-- {a, b, c}
-- {} <- Leere Menge

group by cube(a, b, c) -- Jedes mit jedem
-- {a}
-- {b}
-- {c}
-- {a, b}
-- {b, c}
-- {a, c}
-- {a, b, c}
-- {} <-- Leere Menge
```

### Mehrwertige Beziehungen

Eine bestimmte Klasse nimmt am Beziehungstyp unterrichtet kein oder mehr mals teil.
Bei mehrwertigen Beziehungen ist *max* immer *n*, sonst wäre es ersetzbar.

Beispiel unterrichtet(Beziehungen dargestellt als Menge von Tupeln):
{('5BHIF','HP', 'POS', 7), ('5BHIF', 'SM', 'AM', 2)}

### Konzeptionelles Datenmodell (Taschenbuch Datenbanken S.45)

Ablauf:

1. Anforderungsanalyse
1. Konzeptionelles Datenmodell
    - Sagt nichts über Datenbankmodell aus
    - Möglichkeiten:
        - ERD
            - Enthält Entities und Beziehungen
            - *Beziehungen ist eine Menge von Tupeln*
            - Informatiker können mit Nicht-Informatikern kommunizieren
            - **Wichtige Notationen: Cheng-Min-Max & Bachman Symbol Notation**
            - *Dreieck: Überlagerte Entitytypen/Super-Sub-Typen*
                - *Dreieck leer: Disjunkt -> Es kann nur eines von beiden sein*
                - *Einfacher Strich: Partiell (Es muss nicht unbedingt ein Sub-Typ sein)*
                - *Doppelter Strich: Total (Es muss ein Sub-Typ sein)*
        - UML
        - ORM (Object Relational Mapping)
    - Man möchte für die Aufgabenstellung relevante Daten abbilden
    - *Grad: Wie viele Entities an einer Beziehung teilnehmen*
    - *Kardinalität: Min-Max Verhältnis `m:n`, `1:n`, `1:1`*
    - *Doppelt umrandete Symbole: Weak -> Das Doppelt umrandete Entity ist ohne das einfach umrandete Entity nicht eindeutig.
        - Einfach umrandeter Entitytyp ist das identifizierende Entity
        - Doppel umrandete Bezihung ist der identifizierende Beziehungstyp

### Weiterführende ER-Modellierung (Seite 29)

#### Überlagerte Enitity-Typen

- Super-/Subtyp; Generalisierung bzw. Spezialisierung
- Zur übersichtlicheren/vereinfachten Darstellung in ERDs
- Implementierung wird komplizierter
- Disjointness Constraint
    - disjunkt (nicht ausgefülltes Dreieck)
        - Ein Supertyp kann sich nur genau einmal spezialisieren
    - nicht disjunkt (ausgefülltes Dreieck)
        - Ein Supertyp kann auch mehrere Spezialisierungen haben (z.B.: Person ist Spieler und Schiedsrichter)
- Completeness Constraint
    - total (doppelte Linie über Dreieck)
        - Jeder Supertyp muss sich spezialisieren (z.B.: Es gibt keine Personen die nicht entweder Spieler oder Schiedsrichter sind)
    - partiell (einfache Linie über Dreieck)
        - Supertypen können auch nicht spezialisiert sein
- Implementierung
    - Eine Tabelle für alle Entity-Typen
        - Viel null
        - Keine Redundanzen
        - Alle Informationen über einen Entity in einer Tabelle
        - Sub-Entity-Typ herausfinden ist schwierig
    - Eine Tabelle für jeden Sub-Entity-Typen
        - Redundanzen wenn nicht disjunkt
        - Funktioniert nicht wirklich bei partiell
        - Man hat fast alle Daten direkt in der Tabelle
    - Eine Tabelle pro Entity-Typ (Recommended)
        - Keine Redundanzen
        - Joins werden benötigt, um alle Daten eines Elements zu erhalten
        - Foreign keys bei den Sub-Typen

## 2. Relationales Datenmodell

### Befehlsgruppen

- DDL (Data Definition Language)
    - create
    - alter
    - drop

```sql=
create table student (
    studid    varchar(6)  not null primary key
,   firstname varchar(32) not null
,   lastname  varchar(32) not null
);
```

- DML (Data Manipulation Language)
    - insert
    - update
    - delete

```sql=
insert into student 
    (studid, firstname, lastname) 
values
    ('i13075', 'Paul', 'Häusler')
,   ('i14076', 'Matthias', 'Grill')
;
```

- DQL (Data Query Language)
    - select

```sql=
select *
  from student
;

-- Beispiel für select mit allen Klauseln

select    -- Auswahl der Spalten (Projektion)
  from    -- Auswahl der Tabellen und evt. join
 where    -- Auswahl der Datensätze, Filter (Restriktion)
 group by -- Gruppierung nach Eigenschaften
having    -- Where nach Gruppierung
 order by -- Sotierung nach Eigenschaften
```

- DCL (Data Control Language)
    - grant
    - revoke

```sql=
grant select, insert
   on student 
   to i14076
;
```

- TCL (Transaction Control Language)
    - begin transaction
    - savepoint
    - commit
    - rollback

```sql=
<Oracle SQL Server>
insert ....;
savepoint Zustand1;
insert ....;
savepoint Zustand2;
insert ....;
savepoint Zustand3;
update ....;
rollback to Zustand2;
```

### NULL und dreiwertige Logik (Hillebrand: Kapitel 8.5.20)

> An dieser Stelle ist kein Wert vorhanden

- Null ist kein Wert
- Null sollte vermieden werden
- Wenn null in der Where-Bedingung wird es nicht ausgegeben
- Im Gegensatz zum where akzeptiert check null
- Coalesce
    - Nimmt beliebig viele Parameter
    - Gibt den ersten zurück der nicht null ist
- nvl (Oracle)
    - Wie coalesce nur mit 2 Parametern
- Aggregatfunktionen:
```sql=
-- Preis enthält NUR null Einträge
max(preis)   -- Null
count(preis) -- 0
count(*)     -- Anzahl aller Datensätze inkl. null
```

- Unique und null
    - MS SQL-Server: Null darf nur ein mal enthalten sein
- PL-SQL
    - Wenn Variable nur deklariert wird -> Null

- Bei logischen Operatoren -> Dreiwertige Logik (3VL):
![](https://i.imgur.com/fFUf8Ws.png)

### Trigger & Subselects

- Subselects in der From-Klausel (Inline-view)
    - Beim SQL-Server Namen für die Subselects vergeben (Ansonsten Fehler), nur beim select. Z.b.:
    ```SQL
    select
      SalesOrderNumber,
      SubTotal,
      OrderDate,
     (
     select sum(OrderQty)
       from Sales.SalesOrderDetail
      where SalesOrderID = 43659
     ) as TotalQuantity
      from Sales.SalesOrderHeader
     where SalesOrderID = 43659;
    ```
    - Alle Spalten im Subselect müssen Namen haben
- Subselects in der Where-Klausel
    - Bei Vergleichen: Eine Spalte, Ein Datensatz
    - `in`
        - Es wird überprüft ob der Datensatz in der Menge enthalten ist
    - `Not in`
        - Gegenteil von in
    -  `Exists`
        -  Schaut ob die Abfrage ein Ergebnis zurückliefert 
- Korreliertes Subselect
    - Wenn im Subselect Spalten verwenden vom äußeren Select, ansonsten wäre es ein nicht korreliertes subselect
    - Hier gibts Beispiele mit Fehlerfindung (Lösung muss gefunden werden)
        - "Welche Lieferanten liefern Teil 1 und Teil 2"
        - Mit subselects lösbar
    - Beispiele wo man es ein mal mit korrelierten und ein mal mit nicht korreliierten subselect lösen muss

- Subselects im Skriptum wirklich ausprobieren und üben

### Mengenoperationen

- Union (Vereinigung): `union`
- Intersect (Durschnitt): `intersect`
- Minus(Oracle)/Except (Mengensubstraktion): `minus`/`except`

### Cursor in T-SQL

- Abfolge eines Cursors (in T-SQL)
    - Deklarieren
    - Öffnen
    - Fetch
    - Überprüfen (`@@fetch_status`)
    - Verarbeiten
        - Am ende noch ein Fetch
    - Close
    - Deallocate

```sql
declare @count int = 0;
declare @unnoetig varchar(2);

declare RaisePriceCursor cursor
for
	select TNR
	  from t
	 order by TNR;
	
open RaisePriceCursor;
fetch RaisePriceCursor into @unnoetig;

while @@fetch_status = 0
begin
	if ( @count % 2 = 0 )
	begin
		update t
	       set preis = preis * 1.05
		 where current of RaisePriceCursor
	end
	set @count = @count + 1;
	fetch RaisePriceCursor into @unnoetig;
end;

close RaisePriceCursor;
deallocate RaisePriceCursor;
```

### Cursor in PL-SQL
- Abfolge eines Cursors (in PL/SQL)
    - Automatischer Cursor (`%type` & `%row_type` anschauen!!!)

```sql
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
```

## 3. Datensicherheit und Datenschutz

### Transaktionen (S. 101)

Transaktion: Daten von einem konsistenten Zustand in einen anderen bringen; Logische zusammenhängende Daten setzen; Alles oder Nichts (A von ACID)

### TCL (Transaction Control Language)

- `begin transaction`: Explizit eine Transaktion beginnen
    - Bei Oracle ist man immer automatisch in einer Transaktion
        - Immer in einer expliziten Transaktion
        - Oracle verwendet MVCC (Multi-Version-Concurrency-Control)/Snapshot-Basiert -> Bekommt alte Datensätze vom Undo-Log (Problem mit Snapshot too old (Keine Daten im Undo-Log))
        - Oracle sperrt nicht beim lesen -> Kein commit; keiner kann neue Daten lesen
        - Bei zu langen Transaktionen wird das Undo-Log sehr groß/übergeht
            - Öfters commiten
    - SQL Server:
        - Jeder DML-Command ist in einer impliziten Transaktion;
            - Bei beliebig vielen Datensätzen eine Transaktion
            - kein `rollback`
            - Performance einbußen wenn man immer implizite Transaktionen verwendet
        - Explizite Transaktion mit `begin transaction`
            - `rollback` möglich
        - SQL Server sperrt beim lesen
- `commit`
- `rollback`
- `savepoint`: Unterteilt Transaktion in mehere Teile; Man kann zu einzelnen Savepoints zurückrollen

```sql=
<Oracle SQL Server>
insert ....;
savepoint Zustand1;
insert ....;
savepoint Zustand2;
insert ....;
savepoint Zustand3;
update ....;
rollback to Zustand2;
```
```sql=
<SQL Server>
begin transaction;
insert ....;
save transaction Zustand1;
insert ....;
save transaction Zustand2;
insert ....;
save transaction Zustand3;
insert ....;
rollback Zustand1;
```

Wenn man zum Zustand1 zurückrollt gehen Zustand2 und Zustand3 verloren.
            

### Unterschiede SQL-Server & Oracle SQL

### Isolation Levels (S. 118)

Isolation Levels immer für eine Session.

Probleme wenn unkoordinierter Mehrbenutzerbetrieb:

- `dirty read`: Wenn Datensätze gelesen werden, die eigentlich nicht mehr existieren (`rollback`)
- `nonrepeatable read`: Wenn man bei 2 Mal lesen 2 verschiedene werte kriegt:
    - l1: 1
    - l2: 2
- `phantom read`: Wenn man verschieden viele Datensätze bei 2 gleichen lesevorgängen einliest
    - l1: 5 Zeilen
    - l2: 10 Zeilen
    - Tritt bei `insert`, `update` und `delete` auf
        - Update: Wenn sich ein Wert ändert, welcher beim Select in der where klausel abgefragt wird (Preis > 40)
- `lost update`
    - T1: liest
    - T2: liest
    - T1: update auf Datensatz
    - T2: update auf selben Datensatz -> überschreibt Update von T1
- `inconsistent analysis`
    - T1: Bildet z.B.: `sum`
    - T2: Ändert Daten von T1, die schon gelesen wurden und auch noch von T1 gelesen werden müssen

Während man Änderungen durchführt sind andere Transaktionen von diesen Änderungen abgeschottet.
Setzen via: `set transaction isolation level <level>` (Nur das Leseverhalten!)

Isolation levels (Teilweise in SQL Norm)(**Tabelle!!!!!!**):

- *Serializable*: Kein Phänomen kann eintreten; Ganze Tabelle wird bis zum Ende der Transaktion gesperrt;
- *Repeatable Read*: Holt sich Sperre; Gibt Sperre erst am Ende der Transaktion frei (Strict Two-Phase Locking);
- *Read commited*: Standardeinstellung in SQL-Server; Holt sich Sperre zum lesen; Gibt Sperre nach Lesevorgang wieder frei;
- *Read uncommited*: Holt sich keine Sperren; Alles kann auftreten;

![](https://i.imgur.com/0JPncIG.png)

MS-SQL spezifische Isolation levels:

- Snapshot
    - Wie bei Oracle MVCC
    - Schreibt Daten vor dem Undo-Log in die TMP-DB

### Views (S.78)

> Die Abfrage wird unter einem bestimmten Name abgespeichert; Verwendbar wie eine Tabelle

```sql=
create view rt
as 
select *
  from t
 where farbe = 'rot';
```

Verwendung für:

- Sicherheitskonzept (Nicht alle User sehen alle Daten)

Einfügen mit Einschränkungen:

- Geht nicht wenn View ein Join hat und das `insert` mehrere Tabellen betrifft
- Geht nicht wenn Aggregatfunktion dabei ist - Oder wenn `group by` dabei ist
- Geht nicht wenn berechnete Spalten dabei sind - Beim `insert` dabei ist
- Wenn Mengenoperationen dabei sind
    - `union`
    - `except`/`minus` (Oracle)
    - `intersect`

Man kann auf Views *Trigger* definieren (`instead` DML Trigger).

**Beispiel**: Mit Hilfe einer View, einem Table und einem Trigger die Daten nur als gelöscht markieren und nicht wirklich aus der Tabelle raus löschen. Der `instead of` Trigger verhindert das Löschen und markiert in einer extra Spalte den Datensatz als gelöscht. Die View zeigt dann nur alle an die keine Markierung in der deleted Spalte haben.

*Materialized View*: View, deren Daten aus dem `select` gespeichert werden (verbraucht viel Speicher). Unterschied *Materialized View* und *`select into/create table as select`*: Query Optimizer kann *Materialized View* bei der Optimierung verwenden (*Snapshot* besserer Begriff).

### Kryptologie

- **Klartext**: Unverschlüsselter Text
- **Schlüsseltext**: Verschlüsselter Text
- **Verschlüsselung**: Mathematische Funktion -> f(Klartext, Schlüssel): Schlüsseltext

> Kryptologie ist die Wissenschaft der Verschlüsselung und der Entschlüsselung von Informationen
> 

#### Teilbereiche

- Kryptographie -> Entwurf von Kryptosystemen
- Kryptoanalyse -> Entschlüsselung (Ohne den Schlüssel zu kennen)
- Steganographie -> Verstecken von Information (Informationen in Bild)

#### Methoden

- Transpositionsverfahren (Die Reihenfolge der zeichen, oder Zeichengruppen des Klartexts wird verändert)
- Substitutionsverfahren (Ersetzt ein Zeichen eines Alphabetes mit einem anderen)

#### Charakterisierung der Methoden
- Monoalphabetisch (Es gibt nur ein Schlüsselalphabet -> Es wird ein Zeichen immer durch das selbe ersetzt)
- Polyalphabetisch (Mehrere Alphabete)
- Mono/Polygraphisch (Es werden ein/mehrere Zeichen genommen und verschlüsselt)
- Mono/Bi/Polypartit (Aus einem Klartextzeichen entsteht ein/zwei/mehrere Zeichen)

> Die Menge aller möglichen Schlüssel ist der Schlüsselraum
> 

#### Verfahren

- Symmetrisches Verfahren (Selber Schlüssel wird für ver- und entschlüsselung verwendet)
    - AES (Nachfolger von DES)
- Assymmetrisches Verfahren (Public/Private Key)

### Asynchrone Verfahren

- Vernam/One-Time-Pad Verfahren
- Asynchrone Verfahren (Public/Private-Key-Verfahren) vereinfachen die Schlüssellogistik

#### Ablauf einer Kommunikation mit Public/Private-Key

- Alice findet Public Key von Bob heraus
- Alice verschlüsselt die Nachricht mit Bobs Public Key
- Bob erhält die Nachricht
- Bob entschlüsselt die Nachricht mit seinem Public & Private Key

## 4. Datenbanksystemarchitektur

- Oracle Architekturdiagramm

![](https://i.imgur.com/vHykXxK.png)
- Ablauf beschreiben wenn der client eine Abfrage ausführt oder DML Operation ausführt
    - z.B. Update und commit
        - Schickt den Befehl an den Server Process (Netzwerk)
        - Geparsed und Syntax geprüft
        - Obs Tabellen und Spalten überhaupt gibt
        - Ablaufplan erstellt
        - Query Optimizer schaut welcher Ausführungsplan der beste ist und ob es nicht schon einen gibt (vor allem beim select)
        - Schauen ob die Daten bereits im Datebase Buffer Cache sind
        - Wenn nicht müssen Daten vom Serverprozess geladen werden (Von den Datenfiles)
        - Änderungen im Databasebuffercache durchführen
        - COMMIT
        - Server process -> Redo Log buffer (Klein)
        - Log Writer -> Online Redo Log
        - COMMIT Bestätigung
    - DatabaseWriter schreibt alle Daten vom DB-Buffer Cache in die Datenfiles beim Checkpoint und merkt sich welche Transaktionen offen sind
    - Archive Log Modus
        - Redo logs werden gespeichert, bevor sie überschrieben werden (vom Archiver)
        - Dienen als inkrementelles Backup (bei einem Hard Crash/ Medienfehler)
    - No-Archive Log Modus
        - Redo logs werden überschrieben


### Concurrency (Mehrbenutzerbetrieb)
 - Graphen
 - Deadlocks
 - Sperrmodelle
 - Isolation Levels
 - Serialisierbarkeit

## 5. Betrieb von Informationssystemen

### Performance
- Unterschied Deklarativ / Prozedural
- Schüsselwort CASE (als Statement und Expression)
- Unterschied Anweisung / Ausdruck
- 

### Recovery

- Die Datenbank ist während dem Recovery nicht verwendbar
- **Backup-Strategie**
    - Wie oft? (In welchen Zyklen?)
    - Welchen Typen man macht(Datenumfang)
        - Full-Backup (Alle Daten werden gesichert)
        - Inkrementelles (Daten seit dem letzten Full/Inkrementellen werden gesichert)
        - Differentielles (Daten seit letztem Full-Backup)
    - Auf welchem Medium wird gespeichert?
        - Magnetbänder / LTO-Bänder (Linear Tape Open)
        - Cloud
        - Festplatten
        - Netzlaufwerk -> Wieder Festplatte
        - Optische Medien (Nicht praktikabel)
    - Wie lange muss man in die Vergangenheit zurückgehen können? (z.B. 7 Jahre für das Finanzamt, ...)
    - Wo lagert man die Medien fürs Backup (Bank-Safe)
    - Wer ist fürs Backup verantwortlich/Wer ist Stellvertreter
    - Prüfung der Brauchbarkeit der Backups
    - Wie lange darf es dauern bis Daten wiederhergestellt sind?
        - Katastrophenplan
        - Kosten
    - RAID System erfordert trotzdem eine Backup-Strategie! (RAID Systeme schützt nicht vor Benutzerfehlern)
        - RAID 0 - Striping ohne Redundanz (Bessere Performance)
        - RAID 1 - Spiegeln 
        - RAID 5 - Striping mit Parität (Minimum 3 - eine kann ausfallen)
        - RAID 6 - Striping mit zweifacher Parität (XOR oder fehlerkorrigierende Codes) Mind. 4 - 2 können ausfallen
        - **Hot Spare** (Ein oder mehr Reservedisks um beim Verlust von einer Festplatte schnell wieder auf gleiche Performance-Levels zu gelangen)

### Fehlerszenarien

- **Transaktionsfehler**
    - Vorgesehen bei RDBMS
    - Alle geänderten Daten werden zurückgerollt
    - Bei Constraint-Verletzung, Division / 0, Jemand dreht den Client-Rechner ab, Jemand macht ein `rollback`
- **Soft-Crash/Systemfehler**
    - Datenbank/Server wird nicht ordnungsgemäß heruntergefahren
    - Daten kommen in einen inkonsistenten Zustand
    - Jemand schaltet den physischen Server ab / Stromausfall / Serverseitiger Fehler im OS / DBA killt alle Datenbank-Prozesse
    - DBA muss nichts machen - Crash Recovery beginnt automatisch
        - Backward-Recovery: Alle Transaktionen werden zurückgerollt
        - Forward-Recovery: Alle Daten aus dem Redo-Log werden in die Datenfiles geschrieben (Kommittierte Daten; Serielles IO (Redo-Log) ist schneller als Random IO (Datenfiles))
    - Bei Checkpoint werden die Daten in die Datenfiles geschrieben
        - Checkpoints speichern alle offenen Transaktionen
        - Checkpoints beschleunigen die Crash-Recovery
        - Bei vielen Checkpoints sinkt die Performance

- **Hard-Crash/Medienfehler**
    - Datenfiles gehen verloren
    - z.B.: Bytes in Datenfiles werden manuell verändert, Katastrophenfälle (Brand, Anschläge, Erdbeben, etc.), Irrtümliches Formatieren einer Platte oder Administrator löscht Datenfiles
    - Hier ist das manuelle Einspielen eines Backups notwendig
    
- ![](https://i.imgur.com/6l7trxQ.png)
- Anhand des Diagramms Checkpoint erklären

> Before-Image wird im Undo-Log gespeichert
> After-Image wird im Redo-Log gespeichert 

### Verhindern von menschlichem Versagen

- Verteilung von Rechten (Person hat nur die Rechte die sie wirklich braucht)
- Vier Augen Prinzip (Zwei Leute schauen zu)
- Hardware entsprechend kennzeichnen
    - In Software z.B.: Bei Produktiv-Server farblich markieren
- Monitoring/Automatische Berichte
    - z.B.: Jeden Tag sehen das das geplante Backup funktioniert hat

### Verfahren im Falle eines Hard-Crashes

>  Wenn am Montag um 8:40 ein Hard-Crash passiert, aber seit 7 Uhr gearbeitet wird, kann trotzdem fast alles wieder hergestellt werden (Uncommited Daten können natürlich nicht wiederhergestellt werden)
- Einspielen des letzten Full-Backups
    - Einspielen der letzten Inkrementellen/Differnziellen Backups
- Einspielen der Archived Redo-Logs
- Einspielen der Online Redo-Logs

#### Point-In-Time Recovery

> Vor halber Stunde hab ich meine Tabelle gelöscht die ich eigentlich noch brauche

- Wegen einer Tabelle wird man nicht das ganze Backup am kompletten Server einspielen
- Backup auf einem Test-Server einspielen
- Archived-Redo Logs anwenden BIS zu dem Zeitpunkt (Also nicht alle)
- Tabelle exportieren & im laufenden System importieren

## 6. Datenmodelle und betriebliche Informationssysteme

### Data Warehouse

- Diagramm beschriften können
    - Nicht auswendig zeichnen können, aber auswendig beschriften + erklären
    - Schichten benennen + funktionen erklären
    - Abläufe erklären können
    - ETL Vorgang
- Warum brauchen wir operational Datastore und Data warehouse
- Datawarehouse Aktualisierungen (Strategien)
- Exemplarisch front-end werkzeuge erklären
- Würfel erklären (slicing / dicing, rollup/ drill-down)
- Mehrdimensionale Datenmodelle + Modellierung in RDBMS
- Fakt, Quantifizierenden / Qualifizierende Eigenschaften, Hierarchien, Operationen auf Würfel, Verdichtung
- Speicherung des Würfels (Stern / Schneeflockenschema)
- Normalformen
- Nachteil des Denormalisierens
- Welche Möglichkeiten gibt's zur Abfrageoptimierung
    - Bitmap
    - Materialized Views

### XML und Datenbanken

- Wofür steht XML?
    - Ist das eine gute Bezeichnung?
- Was ist XML?
    - XML ist eine Metasprache zur Definition von Auszeichnungssprachen
- Kindelemente / Elternelemente
- Kriterien für Wohlgeformtheit
- Wofür brauchen wir Grammatiken?
    - Die Grammatik definiert welche Dinge erlaubt sind und welche nicht
    - Menge von Regeln
    - Validieren = XML-Konform mit der Grammatik
    - Technologien
        - DTD
        - RNG
        - RNC
        - XML Schema
        - Schematron
        - XSLT
            - = XML Vorkabular
- Wie werden diese definiert?
- Wofür wird XPath verwendet?
- Alle Technologien grob beschreiben können
    - XML-Schema = XML-Vokabular
- XQuery Abfragen lesen + schreiben
- FLWOR Konstrukt erklären anhand eines Beispiels
- Spezialisierte XML Datenbanken
    - Was spricht dafür / dagegen
- Codebeispiel zu Technologie zuordnen
- Validierungstechniken
    - Was ist Validierung

### Datenbankobjekte, Systemkatalog, Systemviews

- Was sind Datenbankobjekte
    - Views
    - Trigger
    - Indizes
    - Rollen
    - Stored procedures
    - User defined Functions

- Eigenschaften von Datenbankobjekten und Beispiele
- Systemkatalog, Data Dictionary
    - ISV (Standardisierung des Data Dictionaries)
    - Laufender Datenbankbetrieb verwendet durchgehen den Systemkatalog
        - Zum Beispiel bei Abfragen ob die Tabellen im Select wirklich vorhanden sind
    - Wofür können wir den verwenden?
        - Nachschauen wie die DB aufgebaut ist
        - Reverse engineering
        - Diagramm ISV erklären können

