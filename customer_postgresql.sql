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















