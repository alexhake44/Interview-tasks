--Question 1: Basic SELECT with WHERE
SELECT * 
FROM dbo.Customers 
WHERE name = 'Alice Johnson'

--Question 2: Filtering with Multiple Conditions
SELECT * 
FROM dbo.Customers 
WHERE status = 'inactive' 
AND signup_date < = '6/1/2024'


--Question 3: Counting Records
SELECT 
category, 
COUNT(*) AS product_count
FROM products
GROUP BY category;

--Question 4: Calculating Totals
SELECT
SUM(total_amount) AS total_completed_revenue
FROM Orders
WHERE Status = 'Completed'

--Question 5: Sorting and Limiting Results
SELECT TOP 10 *
FROM Orders ORDER BY order_date DESC

--Question 6:String Pattern Matching
SELECT *
FROM dbo.Customers
WHERE email LIKE '%smith%'

--Question 7: Handling NULL Values
SELECT 
    id,
    name,
    signup_date
FROM dbo.Customers
WHERE email is NULL

--Question 8: Root Cause Analysis / Complex Filtering
SELECT
    o1.id AS order_id_1,
    o2.id AS order_id_2,
    o1.customer_id,
    o1.order_date,
    o1.total_amount AS total_amount_1,
    o2.total_amount AS total_amount_2
FROM dbo.Orders o1, dbo.Orders o2
WHERE o1.customer_id = o2.customer_id
    AND o1.order_date = o2.order_date
    AND ABS(o1.total_amount - o2.total_amount) < 5
    AND o1.id < o2.id;

SELECT
customer_id,
order_date,
COUNT(*) AS order_count
FROM dbo.Orders
GROUP BY customer_id, order_date
HAVING COUNT(*) > 1;

SELECT *
FROM dbo.Orders
ORDER BY customer_id, order_date;

--Question 9: Stored Procedure Debugging Scenario

SELECT
    c.name,
    COUNT(o.id) AS total_orders,
    SUM(o.total_amount) AS total_amount_spent
FROM dbo.Customers c
JOIN dbo.Orders o
    ON c.id = o.customer_id
WHERE c.id NOT IN
(
    SELECT customer_id
    FROM dbo.Orders
    WHERE status = 'Cancelled'
    )
GROUP BY c.name
HAVING COUNT(o.id) > 2;

--Question 10 extra credit
SELECT
    o.id AS order_id,
    o.order_date,
    o.total_amount,
    c.customer_name
FROM dbo.Orders o
INNER JOIN dbo.Customers c
    ON o.customer_id = c.id
WHERE o.status = 'Completed';