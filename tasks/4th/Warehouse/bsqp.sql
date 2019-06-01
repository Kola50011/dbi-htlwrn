create database Warehouse;
go

use Warehouse;
go

set dateformat dmy;
set nocount on;
go

-- W1

create table Product (
	ProdNum int primary key,
	Name varchar(64),
	Price int,
	PriceSince datetime
);
go

create table PriceChangeLog (
	ProdNum int references Product,
	PriceSince datetime,
	Price int,
	primary key (ProdNum, PriceSince)
);
go

create table Warehouse (
	WareNum int primary key,
	Location varchar(64),
	Capacity int,
	Amount int
);
go

create table Suitability (
	ProdNum int references Product,
	WareNum int references Warehouse,
	primary key ( ProdNum, WareNum )
);
go

create table Shipment (
	WareNum int references Warehouse,
	OrderNum int,
	ProdNum  int references Product,
	DeliveryDate datetime,
	Amount int,
	primary key (WareNum, OrderNum)
);
go

-- W2

create trigger OnUpdProduct
on Product
after update as
begin
	if update(ProdNum)
	begin
		raiserror('Error, you cannot change Primary Key columns', 16, 1);
		rollback;
	end

	if exists(select *
			    from inserted, deleted
			   where inserted.ProdNum = deleted.ProdNum
			     and inserted.Price < deleted.Price
			 )
	begin
		raiserror('Preise dürfen nie erniedrigt werden.', 16, 1);
		rollback;
	end

	if update(PriceSince) and trigger_nestlevel() > 1
	begin
		raiserror('You may not change te priceSince column.', 16, 1);
	end

	update Product
	   set Product.PriceSince = getdate()
	  from deleted, Product
	 where deleted.Price != Product.Price
	   and deleted.ProdNum = Product.ProdNum

	insert into PriceChangeLog
	select ProdNum, getdate(), Price
	  from inserted
end
go

create trigger OnUpdPriceChangeLog
on PriceChangeLog
after update as
begin
	if update(ProdNum) or update(PriceSince)
	begin
		raiserror('Error, you cannot change Primary Key columns', 16, 1);
		rollback;
	end

	if update(Price)
	begin
		raiserror('Error, you cannot change log columns', 16, 1);
		rollback;
	end
end
go

create trigger OnUpdWarehouse
on Warehouse
after update as
begin
	if update(WareNum)
	begin
		raiserror('Error, you cannot change Primary Key columns', 16, 1);
		rollback;
	end
end
go

create trigger OnUpdSuitability
on Suitability
after update as
begin
	if update(ProdNum) or update(WareNum)
	begin
		raiserror('Error, you cannot change Primary Key columns', 16, 1);
		rollback;
	end
end
go

create trigger OnUpdShipment
on Shipment
after update as
begin
	if update(WareNum) or update(OrderNum)
	begin
		raiserror('Error, you cannot change Primary Key columns', 16, 1);
		rollback;
	end
end
go

insert into Product values (1, 'Qualitätscheisse', 5, getdate() )
insert into Warehouse values (1, 'Scheißhausen', 5, 0 )
insert into Warehouse values (2, 'Dunghausen', 5, 0 )
insert into Warehouse values (3, 'China', 5, 0 )
go

update Product set ProdNum = 2 where ProdNum = 1
go

-- W3

create trigger OnInsShipment
on Shipment
after insert as
begin
	if not exists(
			 select *
			   from inserted, Suitability
			  where inserted.ProdNum = Suitability.ProdNum and
			        inserted.WareNum = Suitability.WareNum
	         )
	begin
		raiserror('Artikel dürfen nur in geeignete Lager geliefert werden.', 16, 1);
		rollback;
	end

	if 3 <= (
			 select count( distinct WareNum )
			   from (
					select * from inserted
					union
					select * from Shipment
			        ) as Ship
			  group by ProdNum
	         )
	begin
		raiserror('Kein Artikel darf in mehr als zwei Lagern auftreten.', 16, 1);
		rollback;
	end

	if exists(
			 select *
			   from inserted, Warehouse
			  where (select sum(Amount)
					   from Shipment
					  where WareNum = inserted.WareNum
					) + inserted.Amount > Warehouse.Capacity
				and Warehouse.WareNum = inserted.WareNum
	         )
	begin
		raiserror('Die Lagerkapazität darf nicht überschritten werden.', 16, 1);
		rollback;
	end

	update Warehouse
	   set Warehouse.Amount = Warehouse.Amount + inserted.Amount
	  from inserted
	 where inserted.WareNum = Warehouse.WareNum

end
go

--Preise dürfen nie erniedrigt werden.
update Product set Price = Price - 1 where ProdNum = 1
go

--Artikel dürfen nur in geeignete Lager geliefert werden.
insert into Shipment values (1, 1, 1, getdate(), 1);
go

--Kein Artikel darf in mehr als zwei Lagern auftreten.
insert into Suitability values (1, 1);
insert into Suitability values (1, 2);
insert into Suitability values (1, 3);
go

insert into Shipment values (1, 5, 1, getdate(), 1);
insert into Shipment values (2, 6, 1, getdate(), 1);
go

insert into Shipment values (3, 7, 1, getdate(), 1);
go

--Die Lagerkapazität darf nicht überschritten werden.
insert into Shipment values (1, 10, 1, getdate(), 100000);
go

-- W4

select * from Warehouse
go

-- W5

create trigger OnInsProduct
on Product
after insert as
begin
	update Product
	   set Product.PriceSince = getdate()
	  from inserted, Product
	 where inserted.ProdNum = Product.ProdNum
end
go

insert into Product values (2, 'Normaler Kot', 5, getdate())
go

select *
  from Product;
go

update Product set Price = Price + 5;
go

select * from Product;
go

select * from PriceChangeLog;
go

-- Verhindern Sie, dass berechnete Felder manipuliert werden.

update Product set PriceSince = getdate();
go

-- Verhindern Sie, dass die Tabelle PriceChangeLog manipuliert wird.

update PriceChangeLog set Price = 1;
go

--

use master;
go

drop database Warehouse;
go