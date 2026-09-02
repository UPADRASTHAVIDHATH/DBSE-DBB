-- ========================================================
-- Database System Engineering and Distributed Backend Development
-- Course Code: 25CS13002E
-- ROLL NO: 2520030597
-- NAME: U.VIDHATH
-- Topic: Aggregate Functions Part 2 (Orders Table Queries)
-- ========================================================

-- Query 1: CREATE DATABASE
-- 2520030597-Vidhath
CREATE DATABASE IF NOT EXISTS bookflow0_db;
USE bookflow0_db;

-- Query 2: CREATE TABLE
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10,2),
    ord_date DATE,
    customer_id INT,
    salesman_id INT
);

-- Query 3: INSERT SAMPLE DATA
-- 2520030597-Vidhath
INSERT INTO orders VALUES
(70001, 150.50, '2012-10-05', 3005, 5002),
(70009, 270.65, '2012-09-10', 3001, 5005),
(70002, 65.26, '2012-10-05', 3002, 5001),
(70004, 110.50, '2012-08-17', 3009, 5003),
(70007, 948.50, '2012-09-10', 3005, 5002),
(70005, 2400.60, '2012-07-27', 3007, 5001),
(70008, 5760.00, '2012-09-10', 3002, 5001),
(70010, 1983.43, '2012-10-10', 3004, 5006),
(70003, 2480.40, '2012-10-10', 3009, 5003),
(70012, 250.45, '2012-06-27', 3008, 5002),
(70011, 75.29, '2012-08-17', 3003, 5007),
(70013, 3045.60, '2012-04-25', 3002, 5001);

-- Query 4: WHERE CLAUSE
-- 2520030597-Vidhath
SELECT * FROM orders
WHERE purch_amt > 2000;

-- Query 5: WHERE WITH SPECIFIC COLUMNS
-- 2520030597-Vidhath
SELECT ord_no, purch_amt, ord_date
FROM orders
WHERE salesman_id = 5001;

-- Query 6: TOTAL PURCHASE AMOUNT
-- 2520030597-Vidhath
SELECT SUM(purch_amt) AS total_purchase_amount
FROM orders;

-- Query 7: AVERAGE PURCHASE AMOUNT
SELECT AVG(purch_amt) AS average_purchase_amount
FROM orders;

-- Query 8: COUNT TOTAL ORDERS
SELECT COUNT(*) AS total_orders
FROM orders;

-- Query 9: MAXIMUM PURCHASE AMOUNT
-- 2520030597-Vidhath
SELECT MAX(purch_amt) AS max_purchase_amount
FROM orders;

-- Query 10: MINIMUM PURCHASE AMOUNT
SELECT MIN(purch_amt) AS min_purchase_amount
FROM orders;

-- Query 11: GROUP BY CUSTOMER ID
SELECT customer_id, MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY customer_id;

-- Query 12: GROUP BY ORDER DATE
-- 2520030597-Vidhath
SELECT ord_date, MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY ord_date;

-- Query 13: GROUP BY SALESMAN ID
-- 2520030597-Vidhath
SELECT salesman_id, MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY salesman_id;

-- Query 14: GROUP BY WITH DATE FILTER
SELECT customer_id, ord_date, MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY customer_id, ord_date;

-- Query 15: HAVING CLAUSE WITH MAX
SELECT salesman_id, MAX(purch_amt) AS highest_purchase
FROM orders
GROUP BY salesman_id
HAVING MAX(purch_amt) > 3000;

-- Query 16: HAVING WITH DATE FILTER
-- 2520030597-Vidhath
SELECT customer_id, MAX(purch_amt) AS highest_purchase
FROM orders
WHERE ord_date = '2012-09-10'
GROUP BY customer_id;

-- Query 17: HAVING ON TOTAL ORDERS
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;
