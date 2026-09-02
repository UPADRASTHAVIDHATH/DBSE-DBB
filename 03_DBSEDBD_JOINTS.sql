-- ========================================================
-- Database System Engineering and Distributed Backend Development
-- Course Code: 25CS13002E
-- ROLL NO: 2520030597
-- NAME: U.VIDHATH
-- Topic: SQL Joins, Union, Intersect, and Minus
-- ========================================================

-- Query 1: CREATE DATABASE
-- 2520030597-Vidhath
CREATE DATABASE IF NOT EXISTS joins_db;
USE joins_db;

-- Query 2: CREATE TABLES
-- 2520030597-Vidhath
CREATE TABLE class (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE class_info (
    id INT,
    address VARCHAR(30)
);

-- Query 3: INSERT VALUES
-- 2520030597-Vidhath
INSERT INTO class VALUES
(1, 'Vidhath'),
(2, 'Raghuveer'),
(4, 'Amulya');

INSERT INTO class_info VALUES
(1, 'HYDERABAD'),
(2, 'DELHI'),
(3, 'CHENNAI');

-- Query 4: CROSS JOIN
-- 2520030597-Vidhath
SELECT * FROM class
CROSS JOIN class_info;

-- Query 5: INNER JOIN
SELECT * FROM class
INNER JOIN class_info
ON class.id = class_info.id;

-- Query 6: INNER JOIN SPECIFIC COLUMNS
-- 2520030597-Vidhath
SELECT class.name, class_info.address
FROM class
INNER JOIN class_info
ON class.id = class_info.id;

-- Query 7: NATURAL JOIN
SELECT * FROM class
NATURAL JOIN class_info;

-- Query 8: INSERT FOR OUTER JOIN TESTING
INSERT INTO class VALUES (5, 'Nihitha');
INSERT INTO class_info VALUES (7, 'BENGALURU'), (8, 'PUNE');

-- Query 9: LEFT OUTER JOIN
SELECT * FROM class
LEFT OUTER JOIN class_info
ON class.id = class_info.id;

-- Query 10: LEFT JOIN ONLY NON-MATCHING
SELECT * FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL;

-- Query 11: RIGHT OUTER JOIN
SELECT * FROM class
RIGHT OUTER JOIN class_info
ON class.id = class_info.id;

-- Query 12: SET OPERATIONS SETUP
-- 2520030597-Vidhath
CREATE TABLE first_table (
    id INT,
    name VARCHAR(30)
);

CREATE TABLE second_table (
    id INT,
    name VARCHAR(30)
);

INSERT INTO first_table VALUES (1, 'Durga prasad'), (2, 'Manasvi');
INSERT INTO second_table VALUES (2, 'Manasvi'), (3, 'Ramya');

-- UNION
SELECT * FROM first_table
UNION
SELECT * FROM second_table;

-- Query 13: UNION ALL
-- 2520030597-Vidhath
SELECT * FROM first_table
UNION ALL
SELECT * FROM second_table;

-- Query 14: INTERSECT (Simulated using INNER JOIN)
SELECT first_table.*
FROM first_table
INNER JOIN second_table
ON first_table.id = second_table.id;

-- Query 15: MINUS (Simulated using LEFT JOIN)
SELECT first_table.*
FROM first_table
LEFT JOIN second_table
ON first_table.id = second_table.id
WHERE second_table.id IS NULL;

-- Query 16: CASE REPORT
-- 2520030597-Vidhath
SELECT c.id, c.name,
CASE
    WHEN ci.address IS NULL THEN 'Address Missing'
    ELSE 'Address Available'
END AS Status
FROM class c
LEFT JOIN class_info ci
ON c.id = ci.id;

-- Query 17: FULL OUTER JOIN (Simulated using UNION of LEFT and RIGHT JOIN)
-- 2520030597-Vidhath
SELECT * FROM class
LEFT JOIN class_info
ON class.id = class_info.id
WHERE class_info.id IS NULL
UNION
SELECT * FROM class
RIGHT JOIN class_info
ON class.id = class_info.id
WHERE class.id IS NULL;
