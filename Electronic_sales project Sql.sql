create database  Electronic_sales;
use  Electronic_sales;

SELECT * FROM electronic_sales.`electronic_sales_data (1)`;

-- Q1. How many total records are present in the table?
SELECT COUNT(*) AS total_records
FROM electronic_sales.`electronic_sales_data (1)`;

-- Q2. What is the total sales amount?
SELECT SUM(Total_Sales) AS total_sales
FROM electronic_sales.`electronic_sales_data (1)`;

-- Q3. Show total sales by category.
SELECT 
    Category,
    SUM(Total_Sales) AS category_sales
FROM electronic_sales.`electronic_sales_data (1)`
GROUP BY Category
ORDER BY category_sales DESC;

-- Q4. List all distinct brands available in the data.
SELECT DISTINCT Brand
FROM electronic_sales.`electronic_sales_data (1)`;

-- Q5. Find top 5 products by total sales.
SELECT 
    Product,
    SUM(Total_Sales) AS total_sales
FROM electronic_sales.`electronic_sales_data (1)`
GROUP BY Product
ORDER BY total_sales DESC
LIMIT 5;

-- Q6. Calculate total profit.
SELECT 
    SUM(Total_Sales - Total_Cost) AS total_profit
FROM electronic_sales.`electronic_sales_data (1)`;

-- Q7. State-wise total sales and profit.
SELECT 
    State_Code,
    SUM(Total_Sales) AS total_sales,
    SUM(Total_Sales - Total_Cost) AS total_profit
FROM electronic_sales.`electronic_sales_data (1)`
GROUP BY State_Code
ORDER BY total_sales DESC;

-- Q8. Delivered orders ka total sales aur profit batao.
SELECT 
    SUM(Total_Sales) AS delivered_sales,
    SUM(Total_Sales - Total_Cost) AS delivered_profit
FROM electronic_sales.`electronic_sales_data (1)`
WHERE `Status_Type` = 'Delivered';

-- Q9. Supervisor-wise performance with ranking (Window Function).
SELECT 
    `Assigned Supervisor`,
    SUM(Total_Sales) AS total_sales,
    SUM(Total_Sales - Total_Cost) AS total_profit,
    RANK() OVER (ORDER BY SUM(Total_Sales) DESC) AS sales_rank
FROM electronic_sales.`electronic_sales_data (1)`
GROUP BY `Assigned Supervisor`;

-- Q10. Find the top-selling product in each category
SELECT *
FROM (
    SELECT 
        Category,
        Product,
        SUM(Total_Sales) AS total_sales,
        RANK() OVER (PARTITION BY Category ORDER BY SUM(Total_Sales) DESC) AS rank_in_category
    FROM electronic_sales.`electronic_sales_data (1)`
    GROUP BY Category, Product
) t
WHERE rank_in_category = 1;

-- Q11. Month-wise sales trend (using Order Date).
SELECT 
    YEAR(Order_Date) AS year,
    MONTH(Order_Date) AS month,
    SUM(Total_Sales) AS monthly_sales
FROM electronic_sales.`electronic_sales_data (1)`
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY year, month;

-- Q12. Classify orders as High / Medium / Low sales (CASE).
SELECT 
    Order_Number,
    Total_Sales,
    CASE
        WHEN Total_Sales >= 100000 THEN 'High'
        WHEN Total_Sales BETWEEN 50000 AND 99999 THEN 'Medium'
        ELSE 'Low'
    END AS sales_category
FROM electronic_sales.`electronic_sales_data (1)`;














