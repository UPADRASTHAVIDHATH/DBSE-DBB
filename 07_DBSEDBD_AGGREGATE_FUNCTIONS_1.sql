-- ========================================================
-- Database System Engineering and Distributed Backend Development
-- Course Code: 25CS13002E
-- ROLL NO: 2520030597
-- NAME: U.VIDHATH
-- Topic: Aggregate Functions Part 1 (COUNT, SUM, AVG, MIN, MAX, GROUP BY, HAVING)
-- ========================================================

-- Query 1: CREATE DATABASE
CREATE DATABASE IF NOT EXISTS bookflow7_db;
USE bookflow7_db;

-- Query 2: CREATE TABLE
-- 2520030597-Vidhath
CREATE TABLE bank_transactions (
    txn_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    branch_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

-- Query 3: Insert and Display
-- 2520030597-Vidhath
INSERT INTO bank_transactions VALUES
(101, 'Vidhath', 'Hyderabad', 'Deposit', 5000.00, '2024-01-05'),
(102, 'Raghuveer', 'Hyderabad', 'Withdrawal', 2000.00, '2024-01-06'),
(103, 'Durga prasad', 'Vijayawada', 'Deposit', 12000.00, '2024-01-08'),
(104, 'Vishnu', 'Vizag', 'Deposit', 8000.00, '2024-01-10'),
(105, 'Yashwanth', 'Hyderabad', 'Withdrawal', 3500.00, '2024-01-11'),
(106, 'Adithya Vardhan', 'Vizag', 'Deposit', 15000.00, '2024-01-12'),
(107, 'Varshith Reddy', 'Vijayawada', 'Withdrawal', 1000.00, '2024-01-13'),
(108, 'Varnika Guptha', 'Hyderabad', 'Deposit', 9000.00, '2024-01-14'),
(109, 'Prerna', 'Vizag', 'Withdrawal', 4000.00, '2024-01-15'),
(110, 'Nihita', 'Vijayawada', 'Deposit', 11000.00, '2024-01-16');

SELECT * FROM bank_transactions;

-- Query 4: COUNT()
-- 2520030597-Vidhath
SELECT COUNT(*) AS total_transactions FROM bank_transactions;

-- Query 5: SUM()
-- 2520030597-Vidhath
SELECT SUM(amount) AS total_amount FROM bank_transactions;

-- Query 6: AVG()
-- 2520030597-Vidhath
SELECT AVG(amount) AS average_amount FROM bank_transactions;

-- Query 7: MIN()
-- 2520030597-Vidhath
SELECT MIN(amount) AS minimum_amount FROM bank_transactions;

-- Query 8: MAX()
-- 2520030597-Vidhath
SELECT MAX(amount) AS maximum_amount FROM bank_transactions;

-- Query 9: GROUP BY branch_name
-- 2520030597-Vidhath
SELECT branch_name, SUM(amount) AS branch_total
FROM bank_transactions
GROUP BY branch_name;

-- Query 10: GROUP BY WITH MULTIPLE AGGREGATES
-- 2520030597-Vidhath
SELECT branch_name, COUNT(*) AS txn_count, AVG(amount) AS avg_amount
FROM bank_transactions
GROUP BY branch_name;

-- Query 11: HAVING CLAUSE
-- 2520030597-Vidhath
SELECT branch_name, SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY branch_name
HAVING SUM(amount) > 20000;
