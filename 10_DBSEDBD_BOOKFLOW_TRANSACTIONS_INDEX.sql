-- =======================================================
-- Student: U.VIDHATH | Roll No: 2520030597
-- Course: 25CS13002E - DBSE & Distributed Backend Dev
-- Lab: BookFlow Library, Transactions & Indexing
-- =======================================================

-- Query 1: Create & Use Database
-- 2520030597-Vidhath
CREATE DATABASE IF NOT EXISTS bookflow4_db;
USE bookflow4_db;

-- Query 2: Create Books Table (DDL + Constraints)
-- 2520030597-Vidhath
CREATE TABLE IF NOT EXISTS Bok (
    book_id INT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    published_year INT CHECK (published_year < 2027)
);

-- Query 3: Insert Books & Display
-- 2520030597-Vidhath
INSERT INTO Bok (book_id, title, isbn, published_year) VALUES
(1, 'The Great Bay', '9780743273565', 2000),
(2, 'The Indian Culture', '2345987456', 2010),
(3, '1947', '9456783457934', 2020);

SELECT * FROM Bok;

-- Query 4: Create Members Table
-- 2520030597-Vidhath
CREATE TABLE IF NOT EXISTS Members (
    member_id INT PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

-- Query 5: Insert Members Table
-- 2520030597-Vidhath
INSERT INTO Members (member_id, full_name, email) VALUES
(101, 'Vidhath', 'vidhath@gmail.com'),
(102, 'Raghuveer', 'raghuveer@gmail.com'),
(103, 'Durga prasad', 'durgaprasad@gmail.com');

-- Query 6: Display Members Table
-- 2520030597-Vidhath
SELECT * FROM Members;

-- Query 7: Create Loans Table
-- 2520030597-Vidhath
CREATE TABLE IF NOT EXISTS Loans (
    load_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Bok(book_id)
);

-- Query 8: Insert 10 Loans
-- 2520030597-Vidhath
INSERT INTO Loans (load_id, member_id, book_id, loan_date) VALUES
(1, 101, 1, '2025-01-05'),
(2, 102, 2, '2025-01-08'),
(3, 103, 3, '2025-01-10'),
(4, 101, 2, '2025-02-01'),
(5, 102, 1, '2025-02-05'),
(6, 103, 2, '2025-02-12'),
(7, 101, 3, '2025-03-01'),
(8, 102, 3, '2025-03-07'),
(9, 103, 1, '2025-03-15'),
(10, 101, 1, '2025-04-01');

-- Query 9: Display Loans Table
-- 2520030597-Vidhath
SELECT * FROM Loans;

-- Query 10: JOIN Query (Member Name and Book Title)
-- 2520030597-Vidhath
SELECT m.full_name AS Member_Name, b.title AS Book_Title
FROM Loans l
INNER JOIN Members m ON l.member_id = m.member_id
INNER JOIN Bok b ON l.book_id = b.book_id;

-- Query 11: GROUP BY Query
-- 2520030597-Vidhath
SELECT published_year, COUNT(book_id) AS Total_Books
FROM Bok
GROUP BY published_year
ORDER BY published_year;

-- Query 12: Donation via TRANSACTION Table Setup
-- 2520030597-Vidhath
CREATE TABLE IF NOT EXISTS Donation_History (
    donation_id INT PRIMARY KEY,
    book_id INT,
    donar_name VARCHAR(100),
    donation_date DATE,
    FOREIGN KEY (book_id) REFERENCES Bok(book_id)
);

-- Query 13: Transaction Execution (Atomic Insert)
-- 2520030597-Vidhath
START TRANSACTION;

INSERT INTO Bok (book_id, title, isbn, published_year)
VALUES (4, 'Animal Farm', '9978654321980', 1945);

INSERT INTO Donation_History (donation_id, book_id, donar_name, donation_date)
VALUES (1, 4, 'Raj Kumar', CURDATE());

COMMIT;

-- Query 14: Index on ISBN
-- 2520030597-Vidhath
CREATE INDEX idx_books_isbn ON Bok(isbn);

-- Query 15: Fast Search using Index
-- 2520030597-Vidhath
SELECT * FROM Bok WHERE isbn = '9780743273565';
