SET NOCOUNT ON

-- Aufgabe 2

create table Bytes (
	Byte int check (Byte between 0 and 255)
)
go

declare @count int = 1;
while @count <= 255
begin
	insert into Bytes values (@count);
	set @count = @count + 1;
end;
go

-- Aufgabe 3

select Byte
, case when cast(Byte & 128 as bit) = 1 then 1 else 0 end as '128'
, case when cast(Byte & 64  as bit) = 1 then 1 else 0 end as '64'
, case when cast(Byte & 32  as bit) = 1 then 1 else 0 end as '32'
, case when cast(Byte & 16  as bit) = 1 then 1 else 0 end as '16'
, case when cast(Byte & 8   as bit) = 1 then 1 else 0 end as '8'
, case when cast(Byte & 4   as bit) = 1 then 1 else 0 end as '4'
, case when cast(Byte & 2   as bit) = 1 then 1 else 0 end as '2'
, case when cast(Byte & 1   as bit) = 1 then 1 else 0 end as '1'
from Bytes

select
  cast( case when cast(Byte & 128 as bit) = 1 then 1 else 0 end as char(1) )
+ cast( case when cast(Byte & 64  as bit) = 1 then 1 else 0 end as char(1)	)
+ cast( case when cast(Byte & 32  as bit) = 1 then 1 else 0 end as char(1)	)
+ cast( case when cast(Byte & 16  as bit) = 1 then 1 else 0 end as char(1)	)
+ cast( case when cast(Byte & 8   as bit) = 1 then 1 else 0 end as char(1)	)
+ cast( case when cast(Byte & 4   as bit) = 1 then 1 else 0 end as char(1)	)
+ cast( case when cast(Byte & 2   as bit) = 1 then 1 else 0 end as char(1)	)
+ cast( case when cast(Byte & 1   as bit) = 1 then 1 else 0 end as char(1)	)
from Bytes

drop table Bytes;

-- Aufgabe 4

use Catalog
go

select * from Parts;
go

update Parts
   set Parts.PartPrice = Parts.PartPrice * 1.05
  from Parts
 where (
        select count(*)
          from Parts p1
         where (p1.PartID <= Parts.PartID)
		) % 2 = 0
 ;
go

select * from Parts;
go