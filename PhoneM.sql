create database MobilePhoneCompany
go
use MobilePhoneCompany
go

create table tb_accountant(
    id int primary key identity,
    accountantName varchar(255) not null ,
	username varchar(250) not null,
	password varchar(20) not null
)
go

create table tb_category(
    id int primary key identity ,
    name varchar(255)
)
go

create table tb_phones(
	id int primary key identity,
	name varchar(250) not null,
	image varchar(255) default null,
	price float,
	quantity int default 0,
	CategoryID int not null ,
	CONSTRAINT fk_phone_category foreign key(CategoryID) references tb_category(id)
)

go
create table tb_warehouseReceipt(
	id int primary key identity,
	createdDate date,
	createdBy int not null, --  id of accountant
    CONSTRAINT fk_tb_warehouseReceipt_tb_accountant foreign key(createdBy) references tb_accountant(id)
)
go

create table tb_warehouseReceiptDetail(
	id int primary key identity,
	quantityInvoice int,
	import_price float,
	importID int not null , -- warehouse receipt ID
	phoneID int not null ,
	CONSTRAINT fk_tb_warehouseReceiptDetail_tb_warehouseReceipt foreign key(importID) references tb_warehouseReceipt(id),
	CONSTRAINT fk_tb_warehouseReceiptDetail_tb_phones foreign key(phoneID) references tb_phones(id)
)
go

create table tb_agent(
    id int primary key identity,
    agentName varchar(255) not null,
	username  varchar(255)  not null,
	password varchar(255) not null,
	address varchar(255) default 'not provide',
	phoneNumber varchar(13) default 'not provide',
	createdByAccID int not null, -- id of accountant
    CONSTRAINT fk_tb_agent_tb_accountant FOREIGN KEY (createdByAccID) references tb_accountant(id)
)
go

create table tb_agentOrder(
	id int primary key identity,
	orderDate date not null,
	statusOrder bit not null, -- true is  shipping(pay success before), false is processing
	statusPayment bit not null, -- true is pay done, false is unpaid
	methodPayment varchar(50),
	total int,
    orderByAgentID int not null,
	CONSTRAINT fk_tb_agent_order_tb_agent foreign key(orderByAgentID) references tb_agent(id)
)
go

create table tb_agentOrderDetail(
	id int primary key identity,
	orderID int not null,
	PhoneID int not null,
	quantity int not null,
	CONSTRAINT fk_tb_agent_order_detail_tb_agentOrder foreign key(orderID) references tb_agentOrder(id),
	CONSTRAINT fk_tb_agent_order_detail_tb_phones foreign key(PhoneID) references tb_phones(id)
)
go

insert into tb_category(name) values ('Nokia'),('ViVo'),('Xiaomi'),
                                     ('Oppo'),('Samsung'),('Apple')
go

insert into tb_accountant(accountantName,username, password) values ('acc1','user1','123456'),
                                                  ('acc2','user2','456789')
go

insert into tb_phones(name,image,quantity,price,CategoryID)
                values  ('Nokia G22 4GB 128GB','https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/d/g/dgtyi8899_.jpg',22,3420000,1),
                        ('Oppo Reno 8','https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/c/o/combo_product_-_reno8_4g_-_gold.png',29,7490000,4),
                        ('iPhone XR 128GB I Chính hãng VN/A','https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/a/p/apple-iphone-xr-64-gb-chinh-hang-vn_1__1.jpg',30,13000000,6),
                        ('iPhone 12 Pro 256GB I Chính hãng VN/A','https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/_/1_251_3.jpg',40,24990000,6),
                        ('Samsung Galaxy S23 8GB 256GB','https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/_/g/_global-version_-sm-s911_galaxys23_back_cream_221122.jpg',45,21990000,5),
                        ('Samsung Galaxy A13 (4G)','https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/g/a/galaxy_a13.jpg',40,3590000,5),
                        ('ViVo Y22S 8GB 128GB','https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/2/f/2fd21c69b0cae924821762ec8270b62e.png',37,5290000,2),
                        ('Xiaomi 13 Pro 12GB 256GB','https://cdn2.cellphones.com.vn/x358,webp,q100/media/catalog/product/1/3/13_prooo.jpg',51,23790000,3) -- 8
                        -- 8 phones with 8 id


go

insert into tb_warehouseReceipt(createdDate,createdBy) values('2023-2-04',1),('2023-2-04',2)
go

insert into tb_warehouseReceiptDetail(importID,phoneID,quantityInvoice,import_price)
                    values  (1,1,22,3420000),(1,2,29,7490000),(1,3,30,13000000),(1,4,40,24990000),
                            (2,5,45,21990000),(2,6,40,3590000),(2,7,37,5290000),(2,8,51,23790000)
go

insert into tb_agent(agentName,username,address, password,phoneNumber,createdByAccID)
                                            values ('FPT phone','fpt','SaiGon','123456','123456789',1),
                                                   ('Mai Nguyen','maimguyen','D8 SGN','123456','123456789',1),
                                                  ('Cellphone S','cellphones','HaNoi','456789','123456789',2)

go

insert into tb_agentOrder (orderDate ,total,statusOrder ,statusPayment ,methodPayment ,orderByAgentID )
                                            values  ('2022-5-03',477460000,1,1,'Bank Transfer',1),
                                                    ('2022-8-03',500440000,0,1,'Momo',2),
                                                    ('2022-5-04',795860000,1,0,'Cash',2),
                                                    ('2022-9-04',240430000,0,0,'Cash',1)
go

insert into tb_agentOrderDetail(orderID  ,PhoneID  ,quantity)
	values (1,2,2),(1,1,1),(1,4,3),(1,5,1),(1,7,3),
	       (4,1,3),(4,3,2),(4,5,4),(4,8,1),(4,8,2),
			(2,1,5),(2,3,2),(2,5,1),(2,7,3),(2,8,2),
			(3,5,3),(3,2,1),(3,3,5),(3,6,7),(3,7,4)
go


select * from tb_category
select * from tb_accountant
select * from tb_agent
select * from tb_phones
select * from tb_warehouseReceipt
select * from tb_warehouseReceiptDetail
select * from tb_agentOrder
select * from tb_agentOrderDetail
go




