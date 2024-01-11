

-----------------------------------------------------Feature Engineering------------------------------------------------------

---- TIME OF DAY TRANSCATIONS TOOK PLACE ----
SELECT
    time,
    CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END AS time_of_day
FROM invoices;

ALTER TABLE invoices ADD COLUMN time_of_day VARCHAR(20);

UPDATE invoices
SET time_of_day = (
	CASE
        WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END
);

---- DAY OF WEEK TRANSACTION WAS MADE ----
SELECT
	TO_CHAR(date, 'Day') AS day_of_week
FROM invoices;
	
ALTER TABLE invoices ADD COLUMN day_of_week VARCHAR(20);

UPDATE invoices
SET day_of_week = (
	TO_CHAR(date, 'Day')
);

---- MONTH OF TRANSACTIONS ----
SELECT
	TO_CHAR(date, 'Month') AS month_name
FROM invoices;

ALTER TABLE invoices ADD COLUMN month_name VARCHAR(20);

UPDATE invoices
SET month_name = (
	TO_CHAR(date, 'Month')
);


-- Branch Performance --
---------------------------------------------

-- How do the total sales of each branch compare month-over-month throughout the dataset's time frame?
SELECT month_name,
		branch,
		SUM(total) AS total_sales
FROM invoices
GROUP BY month_name, branch
ORDER BY month_name, branch;

-- Which branch has the highest average transaction value? Is this consistent across different product lines?
SELECT branch, AVG(total) AS avg_transaction_value
FROM invoices
GROUP BY branch
ORDER BY avg_transaction_value DESC;

-- How do the sales figures for each branch vary concerning the day of the week? 
-- Are there specific days when a branch tends to perform exceptionally well or poorly?
SELECT branch, day_of_week, SUM(total) AS total_sales
FROM invoices
GROUP BY branch, day_of_week
ORDER BY branch, day_of_week;

-- For Normal customers, which product lines contribute most to their purchases? 
-- Is there a difference compared to Member customers?
SELECT i.customer_type, i.product_line, SUM(i.total) AS total_sales
FROM invoices i
WHERE i.customer_type IN ('Normal', 'Member')
GROUP BY i.customer_type, i.product_line
ORDER BY i.customer_type, i.product_line DESC;

-- Cutomser Insights --
---------------------------------------------

-- What is the distribution of customer types (Normal vs. Member) across different branches?
SELECT branch,
       customer_type,
       COUNT(*) AS customer_count
FROM invoices
GROUP BY branch, customer_type
ORDER BY branch, customer_type;

-- Are there any particular product lines that attract a higher ratio of Member customers compared to Normal customers?
SELECT product_line,
       customer_type,
       COUNT(*) AS customer_count
FROM invoices
GROUP BY product_line, customer_type
ORDER BY product_line, customer_type;

-- Do certain payment methods exhibit seasonal popularity changes within specific branches or product lines?
SELECT branch,
       product_line,
       payment,
       COUNT(*) AS payment_count
FROM invoices
GROUP BY branch, product_line, payment
ORDER BY branch, product_line, payment;

-- Is there a difference in the average quantity of products purchased by male and female customers for high-priced items?
SELECT gender,
       product_line,
       AVG(quantity) AS avg_quantity
FROM invoices
WHERE unit_price > 50 
GROUP BY gender, product_line
ORDER BY gender, product_line;

-- Does the time of day of a purchase correlate with the rating given by customers? 
-- For instance, do evening purchases receive higher ratings than morning purchases?
SELECT time_of_day,
       AVG(rating) AS avg_rating
FROM invoices
GROUP BY time_of_day
ORDER BY time_of_day;

-- Product Line Analysis --
---------------------------------------------

-- Which product line shows the highest growth in sales over the months?
SELECT month_name,
       product_line,
       SUM(total) AS total_sales
FROM invoices
GROUP BY month_name, product_line
ORDER BY month_name, total_sales DESC;

-- Is there any seasonality in the sales of specific product lines?
SELECT month_name,
       product_line,
       SUM(total) AS total_sales
FROM invoices
GROUP BY month_name, product_line
ORDER BY product_line, month_name;

-- Within each branch, which product line exhibits the highest variance in unit prices? Does this impact the sales volume?
SELECT branch,
       product_line,
       MAX(unit_price) - MIN(unit_price) AS price_variance
FROM invoices
GROUP BY branch, product_line
ORDER BY branch, price_variance DESC;

-- Are there any specific months or days when particular product lines show a surge or drop in sales?
SELECT month_name,
       day_of_week,
       product_line,
       SUM(total) AS total_sales
FROM invoices
GROUP BY month_name, day_of_week, product_line
ORDER BY month_name, day_of_week, total_sales DESC;

-- Among high-tax products, are there variations in customer ratings compared to low-tax products within the same product line?
SELECT product_line,
       AVG(CASE WHEN tax5 > 15 THEN rating ELSE NULL END) AS avg_rating_high_tax,
       AVG(CASE WHEN tax5 <= 15 THEN rating ELSE NULL END) AS avg_rating_low_tax
FROM invoices
GROUP BY product_line
ORDER BY product_line;

-- Payment Method Trends --
---------------------------------------------

-- How does the distribution of payment methods vary across different months or days of the week?
SELECT month_name,
       payment,
       COUNT(*) AS payment_count
FROM invoices
GROUP BY month_name, payment
ORDER BY month_name, payment;

-- Is there any change in the preferred payment method over time within each branch?
SELECT month_name,
       branch,
       payment,
       COUNT(*) AS payment_count
FROM invoices
GROUP BY month_name, branch, payment
ORDER BY month_name, branch, payment;

-- Do sales patterns differ between weekdays and weekends in terms of total revenue for each branch?
SELECT day_of_week,
       branch,
       SUM(total) AS total_sales
FROM invoices
GROUP BY day_of_week, branch
ORDER BY day_of_week, branch;

-- Do certain payment methods attract more Male or Female customers for specific product lines?
SELECT payment,
       gender,
       product_line,
       COUNT(*) AS customer_count
FROM invoices
GROUP BY payment, gender, product_line
ORDER BY payment, gender, product_line;

-- How do the average transaction values vary across payment methods for high-priced items compared to low-priced ones?
SELECT payment,
       AVG(CASE WHEN unit_price > 50 THEN total ELSE NULL END) AS avg_transaction_value_high_price,
       AVG(CASE WHEN unit_price <= 50 THEN total ELSE NULL END) AS avg_transaction_value_low_price
FROM invoices
GROUP BY payment
ORDER BY payment;

-- Temporal Analysis --
---------------------------------------------

-- Are there particular times of the day or specific days of the week that see higher sales volume?
SELECT time_of_day,
       COUNT(*) AS sales_count
FROM invoices
GROUP BY time_of_day
ORDER BY sales_count DESC;

-- Do sales tend to peak at specific times during weekdays in each branch?
SELECT branch,
       day_of_week,
       time_of_day,
       COUNT(*) AS sales_count
FROM invoices
GROUP BY branch, day_of_week, time_of_day
ORDER BY branch, day_of_week, sales_count DESC;

-- Is there a correlation between time of day and the average quantity of products purchased?
SELECT time_of_day,
       AVG(quantity) AS avg_quantity
FROM invoices
GROUP BY time_of_day
ORDER BY time_of_day;

-- Are there any specific months or days when particular product lines show a surge or drop in sales?
SELECT month_name,
       day_of_week,
       product_line,
       COUNT(*) AS sales_count
FROM invoices
GROUP BY month_name, day_of_week, product_line
ORDER BY month_name, day_of_week, sales_count DESC;

-- Does the time of year impact the average transaction value, considering seasonal trends?
SELECT month_name,
       AVG(total) AS avg_transaction_value
FROM invoices
GROUP BY month_name
ORDER BY month_name;



