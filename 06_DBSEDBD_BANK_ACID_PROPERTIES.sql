-- ========================================================
-- Database System Engineering and Distributed Backend Development
-- Course Code: 25CS13002E
-- ROLL NO: 2520030597
-- NAME: U.VIDHATH
-- Topic: Bank ACID Properties & Transaction Isolation
-- ========================================================

-- Query 1: Create Database
CREATE DATABASE IF NOT EXISTS Bank_ACID_DB1;
USE Bank_ACID_DB1;

-- Query 2: CREATE CUSTOMER TABLE
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    City VARCHAR(50)
);

-- Query 3: CREATE ACCOUNT TABLE
CREATE TABLE Account (
    Account_No INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2),
    Branch VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

-- Query 4: CREATE BANK TRANSACTION TABLE
CREATE TABLE Bank_Transaction (
    Transaction_ID INT PRIMARY KEY AUTO_INCREMENT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Transaction_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Account_No) REFERENCES Account(Account_No)
);

-- Query 5: CREATE LOAN TABLE
CREATE TABLE Loan (
    Loan_ID INT PRIMARY KEY,
    Customer_ID INT,
    Loan_Type VARCHAR(30),
    Loan_Amount DECIMAL(12,2),
    Interest_Rate DECIMAL(5,2),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);

-- Query 6: INSERT CUSTOMER DATA
-- 2520030597-Vidhath
INSERT INTO Customer (Customer_ID, Customer_Name, Phone, City) VALUES
(101, 'Vidhath', '9876543210', 'Hyderabad'),
(102, 'Raghuveer', '9876543211', 'Vijayawada'),
(103, 'Vishnu', '9876543212', 'Bangalore'),
(104, 'Durga prasad', '9876543213', 'Chennai'),
(105, 'Varshith Reddy', '9876543214', 'Hyderabad');

-- Query 7: INSERT ACCOUNT DATA
INSERT INTO Account VALUES
(10001, 101, 'Savings', 50000.00, 'Hyderabad'),
(10002, 102, 'Savings', 75000.00, 'Vijayawada'),
(10003, 103, 'Current', 120000.00, 'Bangalore'),
(10004, 104, 'Savings', 45000.00, 'Chennai'),
(10005, 105, 'Current', 90000.00, 'Hyderabad');

-- Query 8: INSERT TRANSACTION DATA
INSERT INTO Bank_Transaction (Account_No, Transaction_Type, Amount) VALUES
(10001, 'DEPOSIT', 10000),
(10001, 'WITHDRAW', 5000),
(10002, 'DEPOSIT', 15000),
(10003, 'WITHDRAW', 20000),
(10004, 'DEPOSIT', 5000),
(10005, 'WITHDRAW', 10000);

-- Query 9: INSERT LOAN DATA
INSERT INTO Loan VALUES
(501, 101, 'Home Loan', 5000000, 7.5),
(502, 102, 'Education Loan', 1000000, 6.5),
(503, 103, 'Car Loan', 800000, 8.2),
(504, 104, 'Personal Loan', 500000, 10.5);

-- Query 10: DISPLAY TABLES
SELECT * FROM Customer;
SELECT * FROM Account;
SELECT * FROM Bank_Transaction;
SELECT * FROM Loan;

-- ACID PROPERTIES TESTING:
-- Atomicity & Consistency Test
START TRANSACTION;
UPDATE Account SET Balance = Balance - 5000 WHERE Account_No = 10001;
UPDATE Account SET Balance = Balance + 5000 WHERE Account_No = 10002;
COMMIT;

-- Rollback Test
START TRANSACTION;
UPDATE Account SET Balance = Balance - 10000 WHERE Account_No = 10001;
ROLLBACK;

-- Savepoint Test
START TRANSACTION;
UPDATE Account SET Balance = Balance + 2000 WHERE Account_No = 10001;
SAVEPOINT sp1;
UPDATE Account SET Balance = Balance + 3000 WHERE Account_No = 10002;
ROLLBACK TO sp1;
COMMIT;
