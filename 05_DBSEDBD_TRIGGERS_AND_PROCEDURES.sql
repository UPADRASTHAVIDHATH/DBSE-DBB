-- ========================================================
-- Database System Engineering and Distributed Backend Development
-- Course Code: 25CS13002E
-- ROLL NO: 2520030597
-- NAME: U.VIDHATH
-- Topic: Stored Procedures & Triggers
-- ========================================================

-- Query 1: CREATE DATABASE
CREATE DATABASE IF NOT EXISTS BankDB;
USE BankDB;

-- Query 2: CREATE CUSTOMER TABLE
CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    City VARCHAR(50)
);

-- Query 3: CREATE ACCOUNT TABLE
CREATE TABLE Account (
    Account_No INT PRIMARY KEY,
    Customer_ID INT,
    Account_Type VARCHAR(20),
    Balance DECIMAL(12,2) DEFAULT 0,
    Branch VARCHAR(50),
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Query 4: CREATE TRANSACTION TABLE
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
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- Query 6: INSERT CUSTOMER DATA
-- 2520030597-Vidhath
INSERT INTO Customers VALUES
(101, 'Vidhath', '9876543210', 'vidhath@gmail.com', 'Hyderabad'),
(102, 'Raghuveer', '9876543211', 'raghuveer@gmail.com', 'Vijayawada'),
(103, 'Durga prasad', '9876543212', 'durgaprasad@gmail.com', 'Bangalore'),
(104, 'Vishnu', '9876543213', 'vishnu@gmail.com', 'Chennai'),
(105, 'Varshith Reddy', '9876543214', 'varshith@gmail.com', 'Hyderabad');

-- Query 7: INSERT ACCOUNT DATA
INSERT INTO Account VALUES
(10001, 101, 'Savings', 50000, 'Hyderabad'),
(10002, 102, 'Savings', 75000, 'Vijayawada'),
(10003, 103, 'Current', 120000, 'Bangalore'),
(10004, 104, 'Savings', 45000, 'Chennai'),
(10005, 105, 'Current', 90000, 'Hyderabad');

-- Query 8: INSERT TRANSACTION DATA
INSERT INTO Bank_Transaction (Account_No, Transaction_Type, Amount) VALUES
(10001, 'DEPOSIT', 10000),
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

-- Query 10: DISPLAY TABLE DATA
SELECT * FROM Customers;
SELECT * FROM Account;
SELECT * FROM Bank_Transaction;
SELECT * FROM Loan;

-- Query 11: PROCEDURE TO FIND CUSTOMER ACCOUNTS
DELIMITER //
CREATE PROCEDURE GetCustomerAccounts(
    IN p_Customer_ID INT
)
BEGIN
    SELECT
        C.Customer_ID,
        C.Customer_Name,
        A.Account_No,
        A.Account_Type,
        A.Balance,
        A.Branch
    FROM Customers C
    JOIN Account A
    ON C.Customer_ID = A.Customer_ID
    WHERE C.Customer_ID = p_Customer_ID;
END //
DELIMITER ;

CALL GetCustomerAccounts(101);

-- Query 12: PROCEDURE TO DEPOSIT MONEY
DELIMITER //
CREATE PROCEDURE DepositMoney(
    IN p_Account_No INT,
    IN p_Amount DECIMAL(12,2)
)
BEGIN
    UPDATE Account
    SET Balance = Balance + p_Amount
    WHERE Account_No = p_Account_No;
END //
DELIMITER ;

CALL DepositMoney(10001, 5000);

-- Query 13: PROCEDURE TO WITHDRAW MONEY
DELIMITER //
CREATE PROCEDURE WithdrawMoney(
    IN p_Account_No INT,
    IN p_Amount DECIMAL(12,2)
)
BEGIN
    UPDATE Account
    SET Balance = Balance - p_Amount
    WHERE Account_No = p_Account_No;
END //
DELIMITER ;

CALL WithdrawMoney(10001, 3000);

-- Query 14: TRIGGER - PREVENT NEGATIVE DEPOSIT
DELIMITER //
CREATE TRIGGER CheckTransactionAmount
BEFORE INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    IF NEW.Amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction amount must be greater than zero';
    END IF;
END //
DELIMITER ;

-- Query 15: CREATE TRANSACTION AUDIT TABLE
CREATE TABLE Transaction_Audit (
    Audit_ID INT PRIMARY KEY AUTO_INCREMENT,
    Transaction_ID INT,
    Account_No INT,
    Transaction_Type VARCHAR(20),
    Amount DECIMAL(12,2),
    Audit_Date DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Query 16: TRIGGER - TRANSACTION AUDIT
DELIMITER //
CREATE TRIGGER TransactionAudit
AFTER INSERT ON Bank_Transaction
FOR EACH ROW
BEGIN
    INSERT INTO Transaction_Audit (
        Transaction_ID,
        Account_No,
        Transaction_Type,
        Amount
    ) VALUES (
        NEW.Transaction_ID,
        NEW.Account_No,
        NEW.Transaction_Type,
        NEW.Amount
    );
END //
DELIMITER ;

-- Test Trigger
INSERT INTO Bank_Transaction (Account_No, Transaction_Type, Amount) VALUES (10001, 'DEPOSIT', 2500);

-- Query 17: PROCEDURE - ACCOUNT TRANSFER
DELIMITER //
CREATE PROCEDURE TransferMoney(
    IN SenderAccount INT,
    IN ReceiverAccount INT,
    IN TransferAmount DECIMAL(12,2)
)
BEGIN
    DECLARE SenderBalance DECIMAL(12,2);
    
    SELECT Balance INTO SenderBalance
    FROM Account
    WHERE Account_No = SenderAccount;
    
    IF SenderBalance < TransferAmount THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transfer failed: Insufficient balance';
    ELSE
        UPDATE Account
        SET Balance = Balance - TransferAmount
        WHERE Account_No = SenderAccount;
        
        UPDATE Account
        SET Balance = Balance + TransferAmount
        WHERE Account_No = ReceiverAccount;
    END IF;
END //
DELIMITER ;

CALL TransferMoney(10001, 10002, 5000);
SELECT * FROM Account WHERE Account_No IN (10001, 10002);

-- Query 18: PROCEDURE WITH IN, OUT PARAMETERS
DELIMITER //
CREATE PROCEDURE GetBalance(
    IN p_Account_No INT,
    OUT p_Balance DECIMAL(12,2)
)
BEGIN
    SELECT Balance INTO p_Balance
    FROM Account
    WHERE Account_No = p_Account_No;
END //
DELIMITER ;

CALL GetBalance(10001, @CurrentBalance);
SELECT @CurrentBalance;

-- Query 19: TRIGGER COMMANDS
SHOW TRIGGERS;

-- Query 20: PROCEDURE MANAGEMENT COMMANDS
SHOW PROCEDURE STATUS WHERE Db = 'BankDB';
DROP PROCEDURE IF EXISTS GetAllCustomers;
