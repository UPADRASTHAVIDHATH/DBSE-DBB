-- ========================================================
-- Database System Engineering and Distributed Backend Development
-- Course Code: 25CS13002E
-- ROLL NO: 2520030597
-- NAME: U.VIDHATH
-- Topic: DDL, DML, DCL, and TCL Commands
-- ========================================================

-- Query 1: Create Database
CREATE DATABASE IF NOT EXISTS ddl_db;
USE ddl_db;

-- Query 2: DDL - CREATE TABLE
-- 2520030597-Vidhath
CREATE TABLE bank_transactions (
    txn_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    branch_name VARCHAR(50),
    transaction_type VARCHAR(20),
    amount DECIMAL(10,2),
    transaction_date DATE
);

-- Query 3: ALTER TABLE ADD COLUMN
ALTER TABLE bank_transactions
ADD account_no VARCHAR(20);

-- Query 4: ALTER TABLE MODIFY COLUMN
-- 2520030597-Vidhath
ALTER TABLE bank_transactions
MODIFY customer_name VARCHAR(100);

-- Query 5: RENAME TABLE
RENAME TABLE bank_transactions TO customer_transactions;

-- Query 6: TRUNCATE TABLE
TRUNCATE TABLE customer_transactions;

-- Query 7: DROP TABLE
-- 2520030597-Vidhath
DROP TABLE IF EXISTS bank_backup;

-- Query 8: DML - INSERT SAMPLE DATA
-- 2520030597-Vidhath
INSERT INTO customer_transactions (txn_id, customer_name, branch_name, transaction_type, amount, transaction_date) VALUES
(101, 'Vidhath', 'Hyderabad', 'Deposit', 5000, '2024-01-05'),
(102, 'Raghuveer', 'Hyderabad', 'Withdrawal', 2000, '2024-01-06'),
(103, 'Durga prasad', 'Vijayawada', 'Deposit', 12000, '2024-01-08'),
(104, 'Vishnu', 'Vizag', 'Deposit', 8000, '2024-01-10'),
(105, 'Yashwanth', 'Hyderabad', 'Withdrawal', 3500, '2024-01-11'),
(106, 'Adithya Vardhan', 'Vizag', 'Deposit', 15000, '2024-01-12'),
(107, 'Varshith Reddy', 'Vijayawada', 'Withdrawal', 1000, '2024-01-13'),
(108, 'Varnika Guptha', 'Hyderabad', 'Deposit', 9000, '2024-01-14'),
(109, 'Prerna', 'Vizag', 'Withdrawal', 4000, '2024-01-15'),
(110, 'Nihita', 'Vijayawada', 'Deposit', 11000, '2024-01-16');

-- Query 9: INSERT SINGLE RECORD
-- 2520030597-Vidhath
INSERT INTO customer_transactions VALUES
(111, 'Venu', 'Vizag', 'Deposit', 7000, '2024-01-18', NULL);

-- Query 10: UPDATE
UPDATE customer_transactions
SET amount = 5000
WHERE txn_id = 105;

-- Query 11: DELETE
DELETE FROM customer_transactions
WHERE txn_id = 111;

-- Query 12: SELECT ALL
SELECT * FROM customer_transactions;

-- Query 13: SELECT WITH WHERE
SELECT * FROM customer_transactions
WHERE transaction_type = 'Deposit';

-- Query 14: SELECT WITH ORDER BY
SELECT * FROM customer_transactions
ORDER BY amount DESC;

-- Query 15: DCL - GRANT ALL
GRANT ALL PRIVILEGES ON ddl_db.customer_transactions TO 'BranchManager'@'localhost';
SHOW GRANTS FOR 'BranchManager'@'localhost';

-- Query 16: DCL - REVOKE ALL
REVOKE ALL PRIVILEGES ON ddl_db.customer_transactions FROM 'BranchManager'@'localhost';

-- Query 17: TCL - COMMIT
UPDATE customer_transactions
SET amount = 6000
WHERE txn_id = 101;
COMMIT;

-- Query 18: TCL - SAVEPOINT
-- 2520030597-Vidhath
SAVEPOINT Before_Update;

-- Query 19: TCL - ROLLBACK TO SAVEPOINT
-- 2520030597-Vidhath
UPDATE customer_transactions
SET amount = 99999
WHERE txn_id = 102;
ROLLBACK TO Before_Update;
