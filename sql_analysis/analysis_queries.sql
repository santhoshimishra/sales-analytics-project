-- =====================================================
-- PROJECT 1 : SALES PERFORMANCE ANALYTICS DASHBOARD
-- =====================================================

-- =====================================================
-- DASHBOARD KPI QUERIES
-- =====================================================

-- Total Sales
SELECT SUM(sales) AS total_sales
FROM sales_data;

-- Total Orders
SELECT COUNT(order_id) AS total_orders
FROM sales_data;

-- Total Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM sales_data;

-- Average Order Value
SELECT ROUND(
       SUM(sales) / COUNT(DISTINCT order_id),2
       ) AS avg_order_value
FROM sales_data;


-- =====================================================
-- SALES ANALYSIS
-- =====================================================

-- Sales by Region
SELECT region,
       SUM(sales) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

-- Sales by State
SELECT state,
       SUM(sales) AS total_sales
FROM sales_data
GROUP BY state
ORDER BY total_sales DESC;

-- Sales by Customer Segment
SELECT segment,
       SUM(sales) AS total_sales
FROM sales_data
GROUP BY segment
ORDER BY total_sales DESC;

-- Monthly Sales Trend
SELECT TO_CHAR(order_date,'YYYY-MM') AS month,
       SUM(sales) AS monthly_sales
FROM sales_data
GROUP BY month
ORDER BY month;


-- =====================================================
-- PRODUCT ANALYSIS
-- =====================================================

-- Top 10 Selling Products
SELECT product_name,
       SUM(sales) AS total_sales
FROM sales_data
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Sales by Category
SELECT category,
       SUM(sales) AS total_sales
FROM sales_data
GROUP BY category
ORDER BY total_sales DESC;

-- Sales by Sub-Category
SELECT sub_category,
       SUM(sales) AS total_sales
FROM sales_data
GROUP BY sub_category
ORDER BY total_sales DESC;


-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================

-- Top 5 Customers
SELECT customer_id,
       customer_name,
       SUM(sales) AS total_sales
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 5;

-- Customer Segment Analysis
SELECT segment,
       COUNT(DISTINCT customer_id) AS total_customers
FROM sales_data
GROUP BY segment
ORDER BY total_customers DESC;


-- =====================================================
-- ADVANCED ANALYSIS
-- =====================================================

-- Rank States by Sales
SELECT state,
       SUM(sales) AS total_sales,
       RANK() OVER(
       ORDER BY SUM(sales) DESC)
       AS sales_rank
FROM sales_data
GROUP BY state;

-- Rank Products by Sales
SELECT product_name,
       SUM(sales) AS total_sales,
       RANK() OVER(
       ORDER BY SUM(sales) DESC)
       AS product_rank
FROM sales_data
GROUP BY product_name;

-- Monthly Sales Growth
WITH monthly_sales AS (
    SELECT TO_CHAR(order_date,'YYYY-MM') AS month,
           SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY month
)
SELECT month,
       total_sales,
       LAG(total_sales)
       OVER(ORDER BY month) AS previous_month_sales
FROM monthly_sales;


-- =====================================================
-- SLICER SUPPORT QUERIES
-- =====================================================

-- Region
SELECT DISTINCT region
FROM sales_data
ORDER BY region;

-- State
SELECT DISTINCT state
FROM sales_data
ORDER BY state;

-- Segment
SELECT DISTINCT segment
FROM sales_data
ORDER BY segment;

-- Category
SELECT DISTINCT category
FROM sales_data
ORDER BY category;

-- =====================================================
-- END OF PROJECT 1
-- =====================================================