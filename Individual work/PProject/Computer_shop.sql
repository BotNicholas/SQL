--Создание контейнера базы данных--
create database Computer_magazine
go

--Активизирование контейнера базы данных--
use Computer_magazine
go

create type Adres from varchar(70);
go

create type applicationS from varchar(100);
go

create type TNumber from char(12);
go




create table Pasport_data(Id int primary key,
						  C_Adres Adres,
						  C_Surname varchar(12),
						  C_Name varchar(12),
						  C_FatherName varchar(12),
						  Pay_code int foreign key references Payment(Pay_code) not null)
go

insert into Pasport_data(Id, C_Adres, C_Surname, C_Name, C_FatherName, Pay_code)
values (1001, 'ул.Пушкина 6/7', 'Балконский', 'Андрей', 'Николаевич', 102),
	   (1002, 'ул. Николае Милеску Спэтарул 21/1', 'Безухов', 'Пьер', 'Анатольевичь', 101),
	   (1003, 'ул. Садовяну 13/5', 'Ростов', 'Николай', 'Ильич', 103),
	   (1004, 'ул. Петру Заднипру 28/8', 'Болякин', 'Андрей', 'Никифорович', 102),
	   (1005, 'ул. Мунчешть 76/9', 'Шишкин', 'Алескандр', 'Игоревич', 103)
go



create table Product_type(Cod_type smallint primary key,
						  Product_type varchar(20))
go

insert into Product_type(Cod_type, Product_type)
values (2000, 'PC'),
	   (2010, 'Laptop'),
	   (2020, 'Monitor'),
	   (2030, 'Phone'),
	   (2040, 'Tablet PC'),
	   (2050, 'Printer')
go



create table supplier(Sup_code int primary key,
					  Sup_name varchar(20),
					  Company varchar(20),
					  Sup_Adres Adres,
					  production_type varchar(40))
go


alter table supplier
add Telephone TNumber
go

alter table supplier
drop column Company
go

alter table supplier
add Man_cod int foreign key references manufacturer(Man_code) not null
go



insert into supplier(Sup_code, Sup_name, Man_cod, Sup_Adres, production_type, Telephone)
values  (3001, 'Comp_Moldova', 4003, 'ул. Штефан чел маре 21/5', 'PCs, Laptops, Monitors, Phones', '+37367354672'),
		(3002, 'Hyper Supply', 4005, 'ул. Гоголя 34/4', 'PCs, Monitors, Printers, Laptops', '+37369984519'),
		(3003, 'GMSupply', 4006, 'ул. Колумна 5', 'PCs, Laptops', '+37378534765'),
		(3004, 'TechMD', 4002, 'ул. Узинелор 7', 'Monitors, Phones, Laptops', '+37379945543'),
		(3005, 'XMoldova', 4001, 'ул. Петру Мовилэ 7', 'Laptops, Phones, Printers, Monitors', '+37360606607'),
		(3006, 'Hyper Supply', 4004, 'ул. Михаил Садовяну 3', 'PCs, Monitors, Printers', '+37369984519')
go

update supplier
set Sup_name = 'HPSupply'
where Sup_code = 3006
go



create table manufacturer(Man_code int primary key,
						  Man_name varchar(20),
						  Man_Adres Adres,
						  Man_Production_price smallint)
go


insert into manufacturer(Man_code, Man_name, Man_Adres, Man_Production_price)
values  (4001, 'Xiaomi', 'ул. Петру Мовилэ 8', 2000),
		(4002, 'Samsung', 'ул. Узинелор 10', 3000),
		(4003, 'LG', 'ул. Мунчешть 7', 3000),
		(4004, 'HP', 'ул. Гоголя 36', 2000),
		(4005, 'Hyper PC', 'ул. Михаил Садовяну 10', 4000),
		(4006, 'Game Max', 'ул. Отовыска 7', 4000)

go





create table Payment(Pay_code int primary key,
					 Pay_type varchar(15) default 'cash')
go


insert into Payment(Pay_code, Pay_type)
values  (101, 'credit'),
		(102, 'credit card'),
		(103, 'cash')
go



create table Chek(Check_code int primary key,
				  Pay_code int foreign key references Payment(Pay_code) not null)
go


insert into Chek(Check_code, Pay_code)
values  (1013, 101),
		(1014, 102),
		(1017, 103),
		(1020, 103),
		(1022, 102)
go




create table Product(cod_prod int primary key,
					 Cod_type smallint foreign key references Product_type(Cod_type) not null,
					 Man_cod int foreign key references manufacturer(Man_code) not null,
					 Prod_name varchar(20),
					 Price smallint,
					 Waranty smallint check(Waranty <= 5) default 1)
go


insert into Product(cod_prod, Cod_type, Man_cod, Prod_name, Price, Waranty)
values  (5000, 2000, 4005, 'Blye Yeti', 20000, 5),
		(5010, 2010, 4006, 'Nitro', 25000 ,3),
		(5020, 2020, 4003, 'Spin 5', 5000, 1),
		(5021, 2020, 4004, 'Hp one', 2000, 1),
		(5030, 2030, 4002, 'Redmi 5 pro', 4000, 1),
		(5040, 2040, 4001, 'Prestige Pro 3', 4700, 2),
		(5050, 2050, 4004, 'All Vew Pro', 2000, 3),
		(5051, 2050, 4001, 'Clear Sky', 3000, 4),
		(5052, 2050, 4001, 'Colors', 2500, 2)

go






create table Computer(cod_prod int foreign key references Product(cod_prod) unique not null, --связь 1 к 1--
					  CPU_freq smallint default 2000,
					  RAM smallint default 1000,
					  HDD smallint default 250,
					  CD varchar(5) check((CD = 'true') or (CD = 'false')) default 'false',
					  Applic applicationS)
go

insert into Computer(cod_prod, CPU_freq, RAM, HDD, CD, Applic)
values  (5000, 4200, 16000, 1000, 'false', 'Gaming'),
		(5010, 3900, 8000, 2500, 'true', 'Gaming')

go



create table Monitor(cod_prod int foreign key references Product(cod_prod) unique not null,
					 Tatrix_type varchar(5) default 'TN',
					 Diagonal smallint default 21,
					 Monitor_type varchar(20) default 'without rotation',
					 Matrix_size varchar(10) default 'glossy',
					 Applic applicationS)
go


insert into Monitor(cod_prod, Tatrix_type, Diagonal, Monitor_type, Matrix_size, Applic)
values (5020, 'IPS', 21, 'with rotation', 'mate', 'Gaming'),
	   (5021, 'TN', 18, 'without rotation', 'glossy','Office')

go





create table Phone(cod_prod int foreign key references Product(cod_prod) unique not null,
				   CPU_freq smallint default 1000,
				   RAM smallint default 1000,
				   Intern_mem smallint default 5000,
				   Applic applicationS)
go


insert into Phone(cod_prod, CPU_freq, RAM, Intern_mem, Applic)
values (5030, 2000, 3000, 32000, 'Dayly'),
	   (5040, 3000, 4000, 32000, 'Graphic design')

go




create table Printer(cod_prod int foreign key references Product(cod_prod) unique not null,
					 Printer_type varchar(6) check((Printer_type = 'color') or (Printer_type = 'laser')) default 'laser',
					 Applic applicationS)
go


insert into Printer(cod_prod, Printer_type, Applic)
values  (5050, 'laser', 'Office'),
		(5051, 'color', 'Photos'),
		(5052, 'color', 'Photos')

go





create table consignment(Sup_code int foreign key references supplier(Sup_code) not null,
						 cod_prod int foreign key references  Product(cod_prod) not null,
						 prod_number smallint,
						 Man_code int foreign key references  manufacturer(Man_code) not null,
						 consignment_number int,
						 Consignment_date date,
						 Price int)
go

insert into consignment(Sup_code, cod_prod, prod_number, Man_code, consignment_number, Consignment_date, Price)
values  (3002, 5000, 5, 4005, 10456, '2021-12-21', 17000),
		(3003, 5010, 3, 4006, 10432, '2022-01-04', 14000),
		(3001, 5020, 4, 4003, 10487, '2021-10-10', 3000),
		(3006, 5021, 7, 4004, 10499, '2022-01-09', 1000),
		(3004, 5030, 10, 4002, 10444, '2022-02-27', 2500),
		(3005, 5040, 8, 4001, 10411, '2022-01-01', 3000),
		(3006, 5050, 11, 4004, 10410, '2022-02-04', 1500),
		(3005, 5051, 15, 4001, 10440, '2022-02-02', 2000),
		(3005, 5052, 12, 4001, 10404, '2021-12-13', 1700)

go

/*
drop table consignment 
go
*/




create table Chek_infoChek(Check_code int foreign key references Chek(Check_code) not null,
						   cod_prod int foreign key references Product(cod_prod) not null,
						   Purc_date date,
						   Gen_price smallint)
go

insert into Chek_infoChek(Check_code, cod_prod, Purc_date, Gen_price)
values  (1013, 5000, '2021-12-31', 20000),
		(1014, 5052, '2021-12-31', 2500),
		(1017, 5040, '2022-01-08', 4700),
		(1020, 5021, '2022-01-09', 2000),
		(1022, 5030, '2022-02-28', 4000)

go

/*
drop table Chek_infoChek 
go
*/

--Укажите, какая информация в созданной базе данных может изменяться и примените команды группы DML для её изменения.--

--Printer(Printer_type)--
update Printer
set Printer_type = 'laser'
where cod_prod = 5052
go

update Printer
set Printer_type = 'color'
where cod_prod = 5052
go


--Computer(RAM, HDD, CD)--
update Computer
set RAM = 32000
where (cod_prod = 5000)
go

update Computer
set RAM = 16000
where (cod_prod = 5000)
go


--Product(price, name)--
update Product
set Price = 15000
where (Prod_name = 'Blue Yeti') and (cod_prod = 5000)
go

update Product
set Prod_name = 'Blue Yeti'
where Prod_name = 'Blye Yeti'
go

update Product
set Price = 20000
where (Prod_name = 'Blue Yeti') and (cod_prod = 5000)
go


--manufacterer(Man_name, Man_Production_price)
update manufacturer
set Man_name = 'Lenovo'
where Man_name = 'HP'
go

update manufacturer
set Man_name = 'HP'
where Man_name = 'Lenovo'
go


update manufacturer
set Man_Production_price = 7000
where Man_Production_price = 2000
go

update manufacturer
set Man_Production_price = 2000
where Man_Production_price = 7000
go


select *
from manufacturer
go


--supplier(production_type, Sup_name)

update supplier
set Sup_name = 'SamsungS_MD'
where Sup_name = 'TechMD'
go

update supplier
set Sup_name = 'TechMD'
where Sup_name = 'SamsungS_MD'
go


update supplier
set production_type = 'Monitors, Phones, Laptops, PCs'
where Sup_name = 'TechMD'
go

update supplier
set production_type = 'Monitors, Phones, Laptops'
where Sup_name = 'TechMD'
go



--Создайте необходимые индексы--
/*Можно было бы создать индексы также и для отношений product_type и Payment, но в данных отношениях только два столбца, один из которых первичный ключ */

--создание индексов для отношения manufacturer (редко вносим, часто берём => index)--
create index man_name_indx on manufacturer(Man_name)
go

create index man_adres_indx on manufacturer(Man_Adres)
go

--создание индексов для отношения supplyer (редко вносим, часто берём => index)--

create index sup_name_indx on supplier(Sup_name)
go

create index sup_adres_indx on supplier(Sup_Adres)
go

create index sup_telephone_indx on supplier(Telephone)
go

create index sup_prodType_indx on supplier(production_type)
go





select *
from Chek
go

select *
from Chek_infoChek
go

select *
from Computer
go

select *
from consignment
go

select *
from manufacturer
go

select *
from Monitor
go

select *
from Pasport_data
go

select *
from Payment
go

select *
from Phone
go

select *
from Printer
go

select *
from Product
go

select *
from Product_type
go

select *
from supplier
go












--Individual work 31.03.22--





--5 сложных запросов с различными типами соединений--


/*Это сложный запрос с функцией агрегации*/

--посмотреть на какую сумму было поставлено каждого товара--
/*Для этого создадим представление*/
create view Product_Type_view as
select cod_prod, Product_type, Man_cod, Prod_name, Price, Waranty
from Product inner join Product_type on Product.Cod_type = Product_type.Cod_type
go

select Product_type as Product, sum(consignment.Price*prod_number) as Total_price
from Product_Type_view inner join consignment on Product_Type_view.cod_prod = consignment.cod_prod
group by Product_type
go



--Вывести каким образом расчитался покупатель Болякин Андрей Никифорович за товар--
select Pay_type as Paying_by
from Payment inner join Pasport_data on Payment.Pay_code = Pasport_data.Pay_code
where C_Name = 'Андрей' and C_Surname = 'Болякин' and C_FatherName = 'Никифорович'
go

--то же, но с подзапросами--

select Pay_type as Paying_by
from Payment
where Pay_code = (select Pay_code
				  from Pasport_data
				  where C_Name = 'Андрей' and C_Surname = 'Болякин' and C_FatherName = 'Никифорович'
				 )
go



--вывести, какие товары были поставлены в феврале (02)--
select Prod_name as Product
from Product inner join consignment on Product.cod_prod = consignment.cod_prod
where month(Consignment_date) = 2
go

--то же, но с подзапросами--
select Prod_name as Product
from Product
where cod_prod in (select cod_prod
				   from consignment
				   where month(Consignment_date) = 2
				  )
go



--вывести все продажи за 2021-12-31--
--естественное соединение c представлением Product_Type_view--
select distinct Product_type
from Product_Type_view inner join Chek_infoChek on Product_Type_view.cod_prod = Chek_infoChek.cod_prod
where Purc_date = '2021-12-31'
go

--то же, но с подзапросами--
select Product_type
from Product_Type
where Cod_type in (select Cod_type
				   from Product
				   where cod_prod in (select cod_prod
									  from Chek_infoChek
									  where Purc_date = '2021-12-31'
									  )
				  )
go


/*сложный запрос с группировкой и функцией агрегации*/

--вывести количекство продаж каждого типа продукции за 2021-12-31--
select Product_type, count(Product_type) as amount_of_products
from Product_Type_view inner join Chek_infoChek on Product_Type_view.cod_prod = Chek_infoChek.cod_prod
where Purc_date = '2021-12-31'
group by Product_type
go

--+ Часть в подзапросах...--






--5 подзапросов--


/*Это сложный запрос с подзапросом*/

--Вывести технические характеристики всех имеющихся компьютеров--
select Prod_name as Product, CPU_freq as CPU, RAM, HDD, CD, Applic as Aplication
from Computer inner join Product on Computer.cod_prod = Product.cod_prod
where Cod_type = (select Cod_type
				  from Product_type
				  where Product_type = 'PC'
				 )
go



/*Это сложный запрос с подзапросом*/

--Вывести информацию из всех чеков, оплаченных наличкой--
select Prod_name as Product, Purc_date as Purcasing_date, Gen_price as General_price
from Chek_infoChek inner join Product on Chek_infoChek.cod_prod = Product.cod_prod
where Check_code in (select Check_code      --in, а не =, так как по итогу создастся отношение (Pay_type = 'cash' > 2-х кортежей) => в Chek_infoChek передастся уже не 1 значение, а > 1 (2)--
					from Chek
					where Pay_code = (select Pay_code
									  from Payment
									  where Pay_type = 'cash'
									 )
					)
go



--посмотреть, какие товары поставляет поставщик XMoldova--
select Product_type
from Product_type
where Cod_type in (select Cod_type
				   from Product
				   where cod_prod in(select cod_prod
									 from consignment
									 where Sup_code = (select Sup_code
													   from supplier
													   where Sup_name = 'XMoldova'
													  )				
								   )
				 )
go



--вывести тип продукции, которую производит компания LG--
select Product_type
from Product_type
where Cod_type in (select Cod_type
				   from Product
				   where Man_cod = (select Man_code
									from manufacturer
									where Man_name = 'LG'
								   )
				 )
go



/*Подзапрос со сложным запросом с функцией агрегации*/
--вывести самый дорогой товар--
select Prod_name as Product, Product_type, Price
from Product inner join Product_type on Product.Cod_type = Product_type.Cod_type
where price = (select max(price)
			   from Product)
go



--Вывести технические характеристики Redmi 5 pro--
select CPU_freq as CPU, RAM, Intern_mem as Memory, Applic as Aplication
from Phone
where cod_prod = (select cod_prod
				  from Product
				  where Prod_name = 'Redmi 5 pro'
				 )
go

--То же, но с естественным соединением--
select CPU_freq as CPU, RAM, Intern_mem as Memory, Applic as Aplication
from Product inner join Phone on Phone.cod_prod = Product.cod_prod
where Prod_name = 'Redmi 5 pro'
go















--5 запросов на группировку и агрегацию информации--

--посчитать количество товаров, поставленных в каждом месяце--
select month(Consignment_date) as mounth, sum(prod_number) as supply_amount
from consignment
group by month(Consignment_date)
go



--посчитать общую цену всех товаров, поставленных в феврале (02)--
select sum(price*prod_number) as Total_suply_price
from consignment
where month(Consignment_date) = 2
go



--подстчитать число каждой продукции имеющейся в магазине--
select Product_type as Production, count(*) as Products_amount
from Product_type inner join Product on Product_type.Cod_type = Product.Cod_type
group by Product_type
go



--вывести количество продаж за 2021-12-31--
select count(cod_prod) as amount_of_products
from Chek_infoChek
where Purc_date = '2021-12-31'
go



--подсчитать количество покупателей для каждого способа оплаты--
/*Создадим представление*/
create view client_payment_view as
select id, C_Adres, C_Surname, C_Name, C_FatherName, Pay_type
from Payment inner join Pasport_data on Payment.Pay_code = Pasport_data.Pay_code
go

select *
from client_payment_view
go --создаем представление так как Pay_type не входит в Pasport_data и в  результате не произойдет агрегация--

select Pay_type, count(*) as amount_of_clients
from client_payment_view
group by Pay_type
go
