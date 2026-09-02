-- ========================================================
-- Database System Engineering and Distributed Backend Development
-- Course Code: 25CS13002E
-- ROLL NO: 2520030597
-- NAME: U.VIDHATH
-- Topic: Physician & Department Database Queries
-- ========================================================

-- Query 1: Create Database
CREATE DATABASE IF NOT EXISTS sql_db;
USE sql_db;

-- Query 2: CREATE PHYSICIAN TABLE
-- 2520030597-Vidhath
CREATE TABLE physician (
    employeeid INT PRIMARY KEY,
    name VARCHAR(100),
    position VARCHAR(100),
    ssn VARCHAR(20)
);

-- Query 3: INSERT DATA INTO PHYSICIAN
-- 2520030597-Vidhath
INSERT INTO physician VALUES
(1, 'M.Vidhath', 'Staff Internist', '111111111'),
(2, 'M.Raghuveer', 'Attending Physician', '222222222'),
(3, 'Durga prasad', 'Surgical Attending Physician', '333333333'),
(4, 'Vishnu', 'Senior Attending Physician', '444444444'),
(5, 'Adithya Vardhan', 'Head Chief of Medicine', '555555555'),
(6, 'Varshith Reddy', 'Surgical Attending Physician', '666666666'),
(7, 'Yashwanth Reddy', 'Surgical Attending Physician', '777777777'),
(8, 'Nihitha', 'MD Resident', '888888888'),
(9, 'Ramya Sree', 'Attending Psychiatrist', '999999999');

-- Query 4: CREATE DEPARTMENT TABLE
CREATE TABLE department (
    departmentid INT PRIMARY KEY,
    name VARCHAR(100),
    head INT
);

-- Query 5: INSERT DATA INTO DEPARTMENT
INSERT INTO department VALUES
(1, 'General Medicine', 4),
(2, 'Surgery', 7),
(3, 'Psychiatry', 9);

-- Query 6: INNER JOIN DEPARTMENT & HEAD PHYSICIAN
-- 2520030597-Vidhath
SELECT d.name AS Department, p.name AS Head_Physician
FROM department d
JOIN physician p
ON d.head = p.employeeid;

-- Query 7: WHERE CLAUSE
-- 2520030597-Vidhath
SELECT * FROM physician
WHERE position = 'Surgical Attending Physician';

-- Query 8: WHERE + LIKE
-- 2520030597-Vidhath
SELECT * FROM physician
WHERE name LIKE 'Nihitha%';

-- Query 9: COUNT()
-- 2520030597-Vidhath
SELECT COUNT(*) AS Total_Physicians
FROM physician;

-- Query 10: COUNT DISTINCT
-- 2520030597-Vidhath
SELECT COUNT(DISTINCT position)
FROM physician;

-- Query 11: GROUP BY
SELECT position, COUNT(*) AS Total_Employees
FROM physician
GROUP BY position;

-- Query 12: GROUP BY + HAVING
SELECT position, COUNT(*) AS Total_Employees
FROM physician
GROUP BY position
HAVING COUNT(*) > 1;

-- Query 13: ORDER BY ASC
SELECT * FROM physician
ORDER BY name ASC;

-- Query 14: ORDER BY DESC
-- 2520030597-Vidhath
SELECT * FROM physician
ORDER BY employeeid DESC;

-- Query 15: WHERE + IN (SUBQUERY)
SELECT * FROM physician
WHERE employeeid IN (SELECT head FROM department);

-- Query 16: WHERE + NOT IN (SUBQUERY)
-- 2520030597-Vidhath
SELECT * FROM physician
WHERE employeeid NOT IN (SELECT head FROM department);

-- Query 17: GROUP BY + ORDER BY
-- 2520030597-Vidhath
SELECT position, COUNT(*) AS Total_Employees
FROM physician
GROUP BY position
ORDER BY Total_Employees DESC;

-- Query 18: JOIN + WHERE
-- 2520030597-Vidhath
SELECT p.name
FROM physician p
JOIN department d
ON p.employeeid = d.head
WHERE d.name = 'Surgery';

-- Query 19: JOIN + ORDER BY
-- 2520030597-Vidhath
SELECT d.name, p.name
FROM department d
JOIN physician p
ON d.head = p.employeeid
ORDER BY d.name;

-- Query 20: WHERE + NOT LIKE
SELECT * FROM physician
WHERE position NOT LIKE '%Surgical%';

-- Query 21: COUNT + HAVING
-- 2520030597-Vidhath
SELECT position, COUNT(*) AS Total
FROM physician
GROUP BY position
HAVING COUNT(*) >= 2;

-- Query 22: EXISTS SUBQUERY
SELECT * FROM department d
WHERE EXISTS (SELECT 1 FROM physician p WHERE p.employeeid = d.head);

-- Query 23: MAX()
-- 2520030597-Vidhath
SELECT MAX(employeeid)
FROM physician;

-- Query 24: MIN()
-- 2520030597-Vidhath
SELECT MIN(employeeid)
FROM physician;
