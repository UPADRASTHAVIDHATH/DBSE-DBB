-- ========================================================
-- Database System Engineering and Distributed Backend Development
-- Course Code: 25CS13002E
-- ROLL NO: 2520030597
-- NAME: U.VIDHATH
-- Topic: Week 1 DDL & Table Constraints
-- ========================================================

-- Query 1: Create Database
CREATE DATABASE IF NOT EXISTS bookflow5_db;

-- Query 2: Select Database
USE bookflow5_db;

-- Query 3: Create the books table with CHECK constraint
-- 2520030597-Vidhath
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) NOT NULL UNIQUE,
    published_year INT,
    CONSTRAINT chk_published_year CHECK (published_year < 2027)
);

-- Query 4: Create the members table
-- 2520030597-Vidhath
CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

-- Query 5 (verification): Inspect the table structures
DESCRIBE books;
DESCRIBE members;

-- Query 6: Insert 3 books
-- 2520030597-Vidhath
INSERT INTO books (title, isbn, published_year) VALUES
('The Alchemist', '9780061122415', 1988),
('The autobiography', '9780132350884', 2005),
('Harry Potter', '9780735211292', 1997);

-- Query 7: Insert 3 members
-- 2520030597-Vidhath
INSERT INTO members (full_name, email) VALUES
('Vidhath', 'vidhath@gmail.com'),
('Raghuveer', 'raghuveer@gmail.com'),
('Nihitha', 'nihitha@gmail.com');

-- Query 8: Display Tables
SELECT * FROM books;
SELECT * FROM members;

-- Query 9: Constraint Tests (These MUST Fail)
-- Test 1: Duplicate ISBN (UNIQUE violation)
-- INSERT INTO books (title, isbn, published_year) VALUES ('Fake Copy', '9780061122415', 2000);

-- Test 2: NULL title (NOT NULL violation)
-- INSERT INTO books (title, isbn, published_year) VALUES (NULL, '9999999999999', 2010);

-- Test 3: Future publication year (CHECK violation)
-- INSERT INTO books (title, isbn, published_year) VALUES ('Time Traveler', '8888888888888', 2030);

-- Test 4: Duplicate email (UNIQUE violation)
-- INSERT INTO members (full_name, email) VALUES ('Raghuveer', 'raghuveer@gmail.com');
