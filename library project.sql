CREATE DATABASE library;
USE library;

-- Create Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    membership_date DATE,
    email VARCHAR(50) UNIQUE,
    address VARCHAR(100),
    gender VARCHAR(10)
);

-- Insert members data
INSERT INTO Members (member_id, first_name, last_name, date_of_birth, membership_date, email, address, gender)
VALUES
(1, 'Alice', 'Johnson', '1990-05-12', '2023-01-15', 'alice@example.com', '123 Elm St, CityA', 'Female'),
(2, 'Bob', 'Smith', '1985-03-22', '2023-02-10', 'bob@example.com', '456 Oak St, CityB', 'Male'),
(3, 'Charlie', 'Brown', '1992-07-30', '2023-01-20', 'charlie@example.com', '789 Pine St, CityC', 'Male'),
(4, 'Diana', 'Miller', '1988-12-15', '2023-03-05', 'diana@example.com', '321 Maple St, CityD', 'Female'),
(5, 'Eve', 'Davis', '1995-04-25', '2023-04-12', 'eve@example.com', '654 Birch St, CityE', 'Female');

-- Select to verify members
SELECT * FROM Members;

-- Create Authors Table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    biography TEXT
);

-- Insert authors data
INSERT INTO Authors (author_id, first_name, last_name, biography)
VALUES
(1, 'John', 'Green', 'An American author of young adult fiction.'),
(2, 'Jane', 'Austen', 'An English novelist known for her six major novels.'),
(3, 'Mark', 'Twain', 'An American writer, humorist, and entrepreneur.');

-- Select to verify authors
SELECT * FROM Authors;

-- Create Publishers Table
CREATE TABLE Publishers (
    publisher_id INT PRIMARY KEY,
    name VARCHAR(100),
    address VARCHAR(100),
    contact_number VARCHAR(15)
);

-- Insert publishers data
INSERT INTO Publishers (publisher_id, name, address, contact_number)
VALUES
(1, 'Penguin Books', '10-14, Warf Lane, London', '020 1234 5678'),
(2, 'HarperCollins', '195 Broadway, New York', '212 123 4567'),
(3, 'Simon & Schuster', '1230 Avenue of the Americas, New York', '646 123 4567');

-- Select to verify publishers
SELECT * FROM Publishers;

-- Create Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(255),
    author_id INT,
    publication_year INT,
    publisher_id INT,
    language VARCHAR(50),
    pages INT,
    format VARCHAR(50),
    available_copies INT,
    location VARCHAR(100),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id)
);

-- Insert books data
INSERT INTO Books (book_id, title, author_id, publication_year, publisher_id, language, pages, format, available_copies, location)
VALUES
(1, 'Looking for Alaska', 1, 2005, 1, 'English', 221, 'Hardcover', 5, 'Aisle 1'),
(2, 'Pride and Prejudice', 2, 1813, 2, 'English', 279, 'Paperback', 3, 'Aisle 2'),
(3, 'Adventures of Huckleberry Finn', 3, 1884, 3, 'English', 366, 'eBook', 2, 'Aisle 3');

-- Select to verify books
SELECT * FROM Books;

-- Create Loans Table
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY,
    book_id INT,
    member_id INT,
    loan_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);

-- Insert loans data
INSERT INTO Loans (loan_id, book_id, member_id, loan_date, return_date)
VALUES
(1, 1, 1, '2024-10-01', NULL),
(2, 2, 2, '2024-09-15', '2024-09-29'),
(3, 3, 3, '2024-10-03', NULL);

-- Select to verify loans
SELECT * FROM Loans;

-- join two table--
SELECT Members.first_name, Members.last_name, Loans.book_id, Loans.loan_date, Loans.return_date
FROM Members
JOIN Loans ON Members.member_id = Loans.member_id;

-- join three table --
SELECT Members.first_name, Members.last_name, Books.title, Loans.loan_date, Loans.return_date
FROM Members
JOIN Loans ON Members.member_id = Loans.member_id
JOIN Books ON Loans.book_id = Books.book_id;

-- join four table --
SELECT Members.first_name, Members.last_name, Books.title, Authors.first_name AS author_first_name, Authors.last_name AS author_last_name, Loans.loan_date, Loans.return_date
FROM Members
JOIN Loans ON Members.member_id = Loans.member_id
JOIN Books ON Loans.book_id = Books.book_id
JOIN Authors ON Books.author_id = Authors.author_id;