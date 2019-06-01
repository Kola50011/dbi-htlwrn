use lt;
go
DROP TABLE lt;
DROP TABLE l;
DROP TABLE t;
go

CREATE TABLE l (
       lnr    CHAR(2) PRIMARY KEY,
       lname  CHAR(6),
       rabatt DECIMAL(2),
       stadt  CHAR(6));

CREATE TABLE t (
       tnr    CHAR(2) PRIMARY KEY,
       tname  CHAR(8),
       farbe  CHAR(5),
       preis  DECIMAL(10,2),
       stadt  CHAR(6));

CREATE TABLE lt (
       lnr    CHAR(2) REFERENCES l,
       tnr    CHAR(2) REFERENCES t,
       menge  DECIMAL(4) NOT NULL CHECK(menge>0),
       PRIMARY KEY (lnr,tnr));
go

INSERT INTO l VALUES ('L1','Schmid',20,'London');
INSERT INTO l VALUES ('L2','Jonas', 10,'Paris' );
INSERT INTO l VALUES ('L3','Berger',30,'Paris' );
INSERT INTO l VALUES ('L4','Klein', 20,'London');
INSERT INTO l VALUES ('L5','Adam',  30,'Athen' );

INSERT INTO t VALUES ('T1','Mutter',  'rot',  12,'London');
INSERT INTO t VALUES ('T2','Bolzen',  'gelb', 17,'Paris' );
INSERT INTO t VALUES ('T3','Schraube','blau', 17,'Rom'   );
INSERT INTO t VALUES ('T4','Schraube','rot',  14,'London');
INSERT INTO t VALUES ('T5','Welle',   'blau', 12,'Paris' );
INSERT INTO t VALUES ('T6','Zahnrad', 'rot',  19,'London');

INSERT INTO lt VALUES ('L1','T1',300);
INSERT INTO lt VALUES ('L1','T2',200);
INSERT INTO lt VALUES ('L1','T3',400);
INSERT INTO lt VALUES ('L1','T4',200);
INSERT INTO lt VALUES ('L1','T5',100);
INSERT INTO lt VALUES ('L1','T6',100);
INSERT INTO lt VALUES ('L2','T1',300);
INSERT INTO lt VALUES ('L2','T2',400);
INSERT INTO lt VALUES ('L3','T2',200);
INSERT INTO lt VALUES ('L4','T2',200);
INSERT INTO lt VALUES ('L4','T4',300);
INSERT INTO lt VALUES ('L4','T5',400);
go

SELECT * FROM t;
SELECT * FROM l;
SELECT * FROM lt;
