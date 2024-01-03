

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


-- Product Analysis --
---------------------------------------------

-- Get the total sales amount for each branch:
SELECT Branch, SUM(Total) AS TotalSales
FROM Invoices
GROUP BY Branch;

-- Calculate the total sales amount for each product line:
SELECT product_line, SUM(Total) AS TotalSales
FROM invoices
GROUP BY Product_line;

-- Count the number of invoices per branch:
SELECT Branch, COUNT(Invoice_ID) AS InvoiceCount
FROM invoices
GROUP BY Branch;

-- Calculate the total sales for each date:
SELECT Date, SUM(Total) AS TotalSales
FROM invoices
GROUP BY Date
ORDER BY Date;

-- Find the average gross margin percentage for a specific product line (e.g., Health and beauty):
SELECT Product_Line, AVG(Gross_margin_percentage) AS AvgGrossMargin
FROM Invoices
WHERE Product_Line = 'Health and beauty'
GROUP BY Product_Line;

SELECT Product_Line, AVG(Gross_margin_percentage) AS AvgGrossMargin
FROM Invoices
WHERE Product_Line = 'Sports and travel'
GROUP BY Product_Line;

SELECT Product_Line, AVG(Gross_margin_percentage) AS AvgGrossMargin
FROM Invoices
WHERE Product_Line = 'Electronic accessories'
GROUP BY Product_Line;

SELECT Product_Line, AVG(Gross_margin_percentage) AS AvgGrossMargin
FROM Invoices
WHERE Product_Line = 'Home and lifestyle'
GROUP BY Product_Line;

-- Retrieve invoices where the payment method was Ewallet and the rating was greater than 8:
SELECT *
FROM Invoices
WHERE Payment = 'Ewallet' AND Rating > 8;

-- Retrieve invoices where the payment method was Ewallet and the rating was less than 8:
SELECT *
FROM Invoices
WHERE Payment = 'Ewallet' AND Rating < 8;

-- Retrieve invoices where the product line is 'Health and beauty' and the customer is a member and paid using Ewallet:
SELECT *
FROM Invoices
WHERE Product_Line = 'Health and beauty'
    AND Customer_Type = 'Member'
    AND Payment = 'Ewallet';

-- Retrieve invoices where the product line is 'Health and beauty' and the customer is a member and paid using cash:
SELECT *
FROM Invoices
WHERE Product_Line = 'Health and beauty'
    AND Customer_Type = 'Member'
    AND Payment = 'Cash';

-- Get the count of invoices for each customer type:
SELECT Customer_Type, COUNT(*) AS InvoiceCount
FROM Invoices
GROUP BY Customer_Type;

-- Find the total sales for each product line and branch:
SELECT Product_Line, Branch, SUM(Total) AS TotalSales
FROM Invoices
GROUP BY Product_Line, Branch;

-- Identify the top 3 branches with the highest average gross income:
SELECT Branch, AVG(Gross_income) AS AvgGrossIncome
FROM Invoices
GROUP BY Branch
ORDER BY AvgGrossIncome DESC
LIMIT 3;

-- Calculate the total sales and average total for each month in 2019:
SELECT 
    TO_CHAR(date, 'Month') AS Month,
    SUM(Total) AS TotalSales,
    AVG(Total) AS AvgTotal
FROM Invoices
WHERE EXTRACT(YEAR FROM Date) = 2019
GROUP BY Month
ORDER BY Month;

-- Find the branch with the highest total sales:
SELECT Branch, SUM(Total) AS TotalSales
FROM invoices
GROUP BY Branch
ORDER BY TotalSales DESC
LIMIT 3;

-- Calculate the total income for each city:
SELECT City, SUM(gross_income) AS TotalIncome
FROM invoices
GROUP BY City
ORDER BY TotalIncome DESC;

-- Calculate the total income for each day --
SELECT day_of_week, SUM(gross_income) AS TotalIncome
FROM invoices
GROUP BY day_of_week
ORDER BY TotalIncome DESC;

-- Calculate the total income for time of day --
SELECT time_of_day, SUM(gross_income) AS TotalIncome
FROM invoices
GROUP BY time_of_day
ORDER BY TotalIncome DESC;

-- Calculate the highest total products sold for time of day --
SELECT time_of_day, Product_line, COUNT(Product_line) AS TotalProducts
FROM invoices
GROUP BY time_of_day, Product_line
ORDER BY time_of_day, TotalProducts DESC;

-- Calculate what products are being bought based on gender --
SELECT Gender, Product_line, COUNT(*) AS TotalPurchases
FROM invoices
GROUP BY Gender, Product_line
ORDER BY TotalPurchases DESC;