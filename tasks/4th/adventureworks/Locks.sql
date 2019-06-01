use master;
go

use AdventureWorks2014;
set nocount on;
go

-- Listing 2-2: Creation of the DBLocks view to display locks in the current database.

if exists ( select 1
			  from sys.views
			 where name = 'DBlocks' )
begin

	drop view DBlocks ;

end
go

create view DBlocks 
as
select request_session_id "spid" ,
	   db_name(resource_database_id) "dbname" ,
	   case 
			when resource_type = 'OBJECT' then object_name(resource_associated_entity_id)
			when resource_associated_entity_id = 0 then 'n/a'
			else object_name(p.object_id)
	   end "entity_name" ,
	   index_id , resource_type "resource" ,
	   resource_description "description" ,
	   request_mode "mode" , request_status "status"
  from sys.dm_tran_locks t left join sys.partitions p
    on p.partition_id = t.resource_associated_entity_id
 where resource_database_id = DB_ID()
   and resource_type <> 'DATABASE';
go







-- Listing 2-3: A simple SELECT in READ COMMITTED isolation level.

set transaction isolation level read committed;
go

begin transaction;

select *
  from Production.Product
 where Name = 'Reflector';

select *
  from DBlocks
 where spid = @@spid ;

commit;

-- Listing 2-4: A simple SELECT in REPEATABLE READ isolation level.

set transaction isolation level repeatable read ;
go

begin transaction;

select *
  from Production.Product
 where Name like 'Racing Socks%';

select *
  from DBlocks
 where spid = @@spid
   and entity_name = 'Product';

commit;

-- Listing 2-5: A simple SELECT in SERIALIZABLE isolation level.

set transaction isolation level serializable;
go

begin transaction;

select *
  from Production.Product
 where Name like 'Racing Socks%';

select *
  from DBlocks
 where spid = @@spid
   and entity_name = 'Product';

commit;

-- Listing 2-6: A simple UPDATE in READ COMMITTED isolation level.

set transaction isolation level read committed;
go

begin transaction;

update Production.Product
   set ListPrice = ListPrice * 0.6
 where Name like 'Racing Socks%';

select *
  from DBlocks
 where spid = @@spid
   and entity_name = 'Product';

commit;

-- Listing 2-7: A simple UPDATE in SERIALIZABLE isolation level, using an index.

set transaction isolation level serializable;
go

begin transaction;

update Production.Product
   set ListPrice = ListPrice * 0.6
 where Name like 'Racing Socks%';

select *
  from DBlocks
 where spid = @@spid
   and entity_name = 'Product';

commit;

-- Listing 2-8: A simple UPDATE in SERIALIZABLE isolation level, not using an index.

set transaction isolation level serializable;
go

begin transaction;

update Production.Product
   set ListPrice = ListPrice * 0.6
 where Color = 'White' ;

select *
  from DBlocks
 where spid = @@spid
   and entity_name = 'Product';

commit;

-- Listing 2-9: Creating a new table using SELECT…INTO.

drop table newProducts;
go

set transaction isolation level serializable;
go

begin transaction;

select *
  into newProducts
  from Production.Product
 where ListPrice between 1 and 10;

select *
  from DBlocks
 where spid = @@spid
   and entity_name = 'Product';

commit;

-- Listing 2-10: Updating rows in a heap.

set transaction isolation level serializable;
go

begin transaction;

update newProducts
   set ListPrice = 5.99
 where name = 'Road Bottle Cage';

select *
  from DBlocks
 where spid = @@spid
   and entity_name = 'Product';

commit;
