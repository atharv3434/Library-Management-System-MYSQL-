CREATE DATABASE LibraryDB;
USE LibraryDB;


CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address TEXT
);


CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    category_id INT,
    total_copies INT NOT NULL,
    available_copies INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);


CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);


CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);


CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);



-- Insert Authors
INSERT INTO Authors (name) VALUES ('J.K. Rowling'), ('George Orwell'), ('J.R.R. Tolkien');

-- Insert Categories
INSERT INTO Categories (category_name) VALUES ('Fiction'), ('Science Fiction'), ('Fantasy');

-- Insert Books
INSERT INTO Books (title, author_id, category_id, total_copies, available_copies) 
VALUES 
('Harry Potter', 1, 3, 10, 8),
('1984', 2, 2, 5, 2),
('The Hobbit', 3, 3, 7, 5);

-- Insert Users
INSERT INTO Users (name, email, phone, address) 
VALUES 
('Atharv Nakti', 'atharv@example.com', '9876543210', 'Pune, India'),
('Athasha Yadav', 'akanksha@example.com', '9123456789', 'Mumbai, India');

-- Insert Transactions
INSERT INTO Transactions (user_id, book_id, borrow_date, return_date) 
VALUES 
(1, 1, '2024-02-06', '2024-02-13'),
(2, 2, '2024-02-05', '2024-02-12');


SELECT title, available_copies FROM Books;


SELECT Users.name, Books.title, Transactions.borrow_date, Transactions.return_date 
FROM Transactions 
JOIN Users ON Transactions.user_id = Users.user_id
JOIN Books ON Transactions.book_id = Books.book_id
WHERE Transactions.status = 'Borrowed';


SELECT Users.name, Books.title, Transactions.return_date 
FROM Transactions 
JOIN Users ON Transactions.user_id = Users.user_id
JOIN Books ON Transactions.book_id = Books.book_id
WHERE Transactions.return_date < CURDATE() AND Transactions.status = 'Borrowed';


SELECT Categories.category_name, COUNT(Books.book_id) AS total_books 
FROM Books 
JOIN Categories ON Books.category_id = Categories.category_id 
GROUP BY Categories.category_name;

