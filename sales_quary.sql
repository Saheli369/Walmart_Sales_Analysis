--create table--

CREATE TABLE sales (
    invoice_id VARCHAR(30) PRIMARY KEY,
    branch VARCHAR(5),
    city VARCHAR(30),
    customer_type VARCHAR(30),
    gender VARCHAR(10),
    product_line VARCHAR(50),
    unit_price FLOAT,
    quantity INT,
    vat FLOAT,
    total FLOAT,
    purchase_date DATE,
    purchase_time TIME,
    payment_method VARCHAR(30),
    cogs FLOAT,
    gross_margin_percentage FLOAT,
    gross_income FLOAT,
    rating FLOAT
);

SELECT * FROM sales;


--import file --

copy sales(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, vat, total, purchase_date, purchase_time, payment_method, cogs, gross_margin_percentage, gross_income, rating)
FROM 'D:\data analyst journey\walmart_sales_analysis\WalmartSalesData.csv.csv'
DELIMITER ',' 
CSV HEADER;

SELECT * FROM sales;

------------------------   FEATURE ENGINEERING  ---------------------------------

-----------time of day-----------
SELECT purchase_time,
(CASE
	WHEN purchase_time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
	WHEN purchase_time BETWEEN '12:00:00' AND '16:00:00' THEN 'Afternoon'
	ELSE 'Evening'
END) AS time_of_day
FROM sales;

--add new column
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

--update the column with giving the values
UPDATE sales 
SET time_of_day =(
CASE
	WHEN purchase_time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
	WHEN purchase_time BETWEEN '12:00:00' AND '16:00:00' THEN 'Afternoon'
	ELSE 'Evening'
END);



--------- day name -------------
SELECT purchase_date,
to_char(purchase_date,'day') AS day_name
FROM sales;

-- add new column 
ALTER TABLE sales ADD column day_name VARCHAR(10);

-- update the column
UPDATE sales 
SET day_name = to_char(purchase_date,'day');



----- month name ---
-- add new column
ALTER TABLE sales ADD COLUMN month_name VARCHAR(20);

--update the column with values
UPDATE sales 
SET month_name = to_char(purchase_date,'month');


-------------------------------------------------------------------------------------------------------------------------------

----------------------------   GENERIC    ------------------------------------

-- How many unique cities does the data have?
SELECT DISTINCT city 
FROM sales;

-- In which city is each branch?
SELECT DISTINCT branch 
FROM sales;

----------------------------------------------------------------------------------------------------------------------------------

----------------------------   PRODUCT   ----------------------------------------

-- 1. How many unique product lines does the data have?
SELECT DISTINCT product_line 
FROM sales;

-- 2. What is the most common payment method?
SELECT 
	payment_method,
	COUNT(payment_method) AS cnt
FROM sales
GROUP BY payment_method
ORDER BY cnt DESC;

-- 3. What is the most selling product line?
SELECT 
	 product_line,
	 COUNT(product_line) AS pl
FROM sales
GROUP BY product_line
ORDER BY pl DESC;

-- 4. What is the total revenue by month?
SELECT month_name AS month,
	SUM(total) AS total_revenue
FROM sales
GROUP BY month
ORDER BY total_revenue DESC;

-- 5. What month had the largest COGS?
SELECT month_name AS month,
	COUNT(cogs) AS cnt
FROM sales
GROUP BY month
ORDER BY cnt DESC;

-- 6. What product line had the largest revenue?
SELECT product_line,
SUM(total)AS largest_revenue
FROM sales
GROUP BY product_line
ORDER BY largest_revenue DESC;

--7. What is the city with the largest revenue?
SELECT city,
SUM(total)AS largest_revenue
FROM sales
GROUP BY city
ORDER BY largest_revenue DESC;

-- 8. What product line had the largest VAT?
SELECT product_line,
	AVG(VAT) AS avg_tax
FROM sales 
GROUP BY product_line
ORDER BY avg_tax DESC;

-- 9. Which branch sold more products than average product sold?
SELECT branch,
	SUM(quantity) AS qnty
FROM sales 
GROUP BY branch 
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);
	
-- 10. What is the most common product line by gender?
SELECT gender,
	product_line,
	COUNT(gender) AS total_cnt
FROM sales 
GROUP BY gender, product_line
ORDER BY total_cnt DESC;

-- 11. What is the average rating of each product line?
SELECT product_line,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY product_line
ORDER BY avg_rating DESC;



----------------------------------------------------------------------------------------------------------------------------------

----------------------------   SALES   ----------------------------------------

-- 1. Number of sales made in each time of the day per weekday
SELECT 
	time_of_day,
	COUNT(*) AS total_sales
FROM sales
GROUP BY time_of_day
ORDER BY total_sales DESC;
-- or
SELECT 
    time_of_day,
    COUNT(*) AS total_sales
FROM sales
WHERE TO_CHAR(purchase_date, 'FMDay') = 'Sunday'
GROUP BY time_of_day
ORDER BY total_sales DESC;

-- 2. Which of the customer types brings the most revenue?
SELECT customer_type,
	SUM(total) as total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- 3. Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT city,
	AVG (VAT) AS vat
FROM sales
GROUP BY city
ORDER BY vat DESC; 

-- 4. Which customer type pays the most in VAT?
SELECT customer_type,
	AVG (VAT) AS vat
FROM sales
GROUP BY customer_type
ORDER BY vat DESC; 


----------------------------------------------------------------------------------------------------------------------------------

----------------------------   CUSTOMERS   ----------------------------------------

-- 1. How many unique customer types does the data have?
SELECT COUNT(DISTINCT customer_type) FROM sales;

--2. How many unique payment methods does the data have?
SELECT COUNT(DISTINCT payment_method) FROM sales;

-- 3. What is the most common customer type? 
SELECT 
	customer_type,
	COUNT(*) AS cstm_cnt
FROM sales
GROUP BY customer_type
ORDER BY cstm_cnt DESC;

-- 4. Which customer type buys the most?
SELECT 
	customer_type,
	COUNT(*) AS csmt_cnt
FROM sales
GROUP BY customer_type
ORDER BY csmt_cnt DESC;

-- 5. What is the gender of most of the customers?
SELECT 
	gender,
	COUNT(*) AS gender_count
FROM sales 
GROUP BY gender;

-- 6. What is the gender distribution per branch?
SELECT 
	gender,
	COUNT(*) AS gender_count
FROM sales 
WHERE branch = 'A'
GROUP BY gender;

-- 7. Which time of the day do customers give most ratings?
SELECT time_of_day,
	AVG(rating) AS AVG_rating
FROM sales
GROUP BY time_of_day
ORDER by AVG_rating DESC;

-- 8. Which time of the day do customers give most ratings per branch?
SELECT time_of_day,
	AVG(rating) AS AVG_rating
FROM sales
WHERE branch = 'A'
GROUP BY time_of_day
ORDER by AVG_rating DESC;

-- 9. Which day oF the week has the best avg ratings?
SELECT 
	day_name,
	AVG(rating) AS avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- 10. Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
	AVG(rating) AS avg_rating
FROM sales
WHERE branch ='B'
GROUP BY day_name
ORDER BY avg_rating DESC;
