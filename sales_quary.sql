
CREATE TABLE sales
(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
	brunch varchar(7) NOT NULL,
	city varchar(30),
	customer_type varchar(30),
	gender varchar(10),
	product_line varchar(100),
	unit_price int,
	quantity int, 
	VAT float,
	total int,
	date date,
	time timestamp,
	payment_method varchar(20),
	cogs int,
	gross_margin_percentage float,
	gross_income int,
	rating float
);




