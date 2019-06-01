-- 1)

--create database raid5
use raid5

-- 2)
drop table DiskArray;
go

create table DiskArray (
	BlockNo integer primary key,
	Disk1 tinyint,
	Disk2 tinyint,
	Disk3 tinyint,
	ParityDisk tinyint
)
go

-- 3)

insert into DiskArray values
(1, ascii('W'), ascii('F'), ascii('D'), null ),
(2, ascii('i'), ascii('i'), ascii('a'), null ),
(3, ascii('c'), ascii('r'), ascii('t'), null ),
(4, ascii('h'), ascii('m'), ascii('e'), null ),
(5, ascii('t'), ascii('e'), ascii('n'), null ),
(6, ascii('i'), ascii('n'), ascii(' '), null ),
(7, ascii('g'), ascii(' '), ascii(' '), null ),
(8, ascii('e'), ascii(' '), ascii(' '), null )
go

-- 4)

update DiskArray
   set ParityDisk = Disk1^Disk2^Disk3
;
go

-- 5)

select BlockNo, char(Disk1), char(Disk2), char(Disk3), ParityDisk
  from DiskArray
;
go

-- 6)

update DiskArray
   set Disk1 = null
;
go

select BlockNo, char(Disk1), char(Disk2), char(Disk3), ParityDisk
  from DiskArray
;
go

-- 7)
update DiskArray
   set Disk1 = ParityDisk^Disk2^Disk3
;
go

-- 8.2)
update DiskArray
   set Disk2 = null
;
go

select BlockNo, char(Disk1), char(Disk2), char(Disk3), ParityDisk
  from DiskArray
;
go

update DiskArray
   set Disk2 = ParityDisk^Disk1^Disk3
;
go

select BlockNo, char(Disk1), char(Disk2), char(Disk3), ParityDisk
  from DiskArray
;
go

-- 8.3)
update DiskArray
   set Disk3 = null
;
go

select BlockNo, char(Disk1), char(Disk2), char(Disk3), ParityDisk
  from DiskArray
;
go

update DiskArray
   set Disk3 = ParityDisk^Disk1^Disk2
;
go

select BlockNo, char(Disk1), char(Disk2), char(Disk3), ParityDisk
  from DiskArray
;
go