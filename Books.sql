-- Creating the database
CREATE DATABASE Books;

-- Using the created database
USE Books;

-- Table: publisher (must be defined before books)
CREATE TABLE publisher(
    publisher_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    contact_number VARCHAR(15) UNIQUE,
    email VARCHAR(50) UNIQUE
);

-- Table: books
CREATE TABLE books(
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) UNIQUE,
    genre VARCHAR(50),
    price FLOAT(4),
    publisher_id INT,
    publication_date DATE,
    pages INT,
    stock_count INT,
    FOREIGN KEY(publisher_id) REFERENCES publisher(publisher_id)
);

-- Table: author
CREATE TABLE author(
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    gender ENUM("Male", "Female", "Other"),
    nationality VARCHAR(50)
);

-- Table: book_author
CREATE TABLE book_author(
    book_author_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    author_id INT,
    FOREIGN KEY(book_id) REFERENCES books(book_id),
    FOREIGN KEY(author_id) REFERENCES author(author_id)
);

-- Table: book_language 
CREATE TABLE book_language(
    book_language_id INT AUTO_INCREMENT PRIMARY KEY,
    language_code VARCHAR(10),
    book_id INT,
    FOREIGN KEY(book_id) REFERENCES books(book_id)
);

-- Table: customer
CREATE TABLE customer(
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    phone_number VARCHAR(15) UNIQUE,
    email VARCHAR(50) UNIQUE,
    registration_date DATE
);

-- Table: address_status
CREATE TABLE address_status(
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50)
);

-- Table: country
CREATE TABLE country(
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    country_code VARCHAR(5) UNIQUE,
    continent VARCHAR(20)
);

-- Table: address
CREATE TABLE address(
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(50),
    city VARCHAR(50), 
    postal_code VARCHAR(10),
    country_id INT,
    FOREIGN KEY(country_id) REFERENCES country(country_id)
);

-- Table: customer_address
CREATE TABLE customer_address(
    customer_address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    address_id INT,
    start_date DATE,
    end_date DATE,
    status_id INT,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(address_id) REFERENCES address(address_id),
    FOREIGN KEY(status_id) REFERENCES address_status(status_id)
);

-- Table: shipping_method
CREATE TABLE shipping_method(
    method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(50),
    delivery_date DATE,
    cost FLOAT(5)
);

-- Table: customer_order
CREATE TABLE customer_order(
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price FLOAT(6),
    status_id INT,
    method_id INT,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY(status_id) REFERENCES address_status(status_id),
    FOREIGN KEY(method_id) REFERENCES shipping_method(method_id)
);

-- Table: order_line
CREATE TABLE order_line(
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    unit_price FLOAT(4),
    FOREIGN KEY(order_id) REFERENCES customer_order(order_id),
    FOREIGN KEY(book_id) REFERENCES books(book_id)
);

-- Table: order_history
CREATE TABLE order_history(
    order_history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    FOREIGN KEY(order_id) REFERENCES customer_order(order_id),
    FOREIGN KEY(book_id) REFERENCES books(book_id)
);

-- Table: order_status
CREATE TABLE order_status(
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    order_status_name VARCHAR(50),
    FOREIGN KEY(order_id) REFERENCES customer_order(order_id)
);

-- Adding data into our tables

-- insert into table publisher
INSERT INTO publisher(name, contact_number, email)
VALUES
('Oxford', '+254765746889', 'oxford@gmail.com'),
('waandishi', '+254765746880', 'waandishi@yahoo.com'),
('Printers', '+254765746881', 'printers@gmail.com');

-- insert into table books
INSERT INTO books(title, genre, price, publisher_id, publication_date, pages, stock_count)
VALUES
("Atomic Habits", "self improvement", 700, 1, "2022-09-12", 200, 10),
("48 laws of power", "psychology", 1100, 2, "2020-09-10", 800, 20),
("Rich Dad Poor Dad", "finacial literacy", 900, 3, "2023-09-02", 300, 10);

-- insert into table author
INSERT INTO author(name, gender, nationality)
VALUES
('James Clear', 'Male', 'American'), 
('Robert Green', 'Male', 'American'), 
('Robert Kiyosaki', 'Male', 'Chinese');

-- insert into table book_author 
INSERT INTO book_author(book_id, author_id)
VALUES
(1, 1),
(2, 3),
(3, 2);

-- insert into table book_language
INSERT INTO book_language(language_code, book_id)
VALUES
("en", 1),
("en", 2),
("en", 3);

-- insert into table customer
INSERT INTO customer(name, phone_number, email, registration_date)
VALUES
("Evans", "+25475123456781", "evans@gmail.com", "2025-01-03"),
("Evans", "+25475123456782", "mercy@gmail.com","2025-02-02"),
("Lucy", "+25475623456789", "cy@gmail.com","2025-03-04");

-- insert into table address status
INSERT INTO address_status(status_name)
VALUES
("Current"),
("Old"),
("Current");

-- insert into table country
INSERT INTO country(name, country_code, continent)
VALUES
("USA", "+1", "North America"),
("South Africa", "+27", "Africa"),
("China", "+86", "Asia");

-- insert into table address
INSERT INTO address(street, city, postal_code, country_id)
VALUES
('Tesla Lane', 'New York', '0019', 1),
('Cape Lane', 'Cape Town', '10102', 2),
("Ghadhi street", 'Hong Kong', '002101', 3);

-- insert into table customer_address
INSERT INTO customer_address(customer_id, address_id, start_date, end_date, status_id)
VALUES
(1, 3,'2023-02-03', '2027-07-09', 2),
(3, 2,'2023-02-03', '2027-07-09', 1),
(2, 1,'2023-02-03', '2027-07-09', 3);

-- insert into shipping methods
INSERT INTO shipping_method(method_name, delivery_date, cost)
VALUES
('sea', '2025-05-05', 40000.0),
('Air', '2025-4-12', 50000.0),
('Train', '2025-06-06', 7000.0);

-- insert into table customer order
INSERT INTO customer_order(customer_id, order_date, total_price, status_id, method_id)
VALUES
(2, '2025-03-11', 50000, 1, 3),
(3, '2025-03-11', 30500, 3, 1),
(1, '2025-02-27', 20100, 2, 2);

-- Insert into order line 
INSERT INTO order_line(order_id, book_id, quantity, unit_price)
VALUES
(3, 2, 5, 700),
(2, 1, 8, 9000),
(1, 3, 10, 1100);

-- Insert into order_history 
INSERT INTO order_history(order_id, book_id)
VALUES
(2, 3),
(1, 1),
(3, 2);

-- insert into table order_status
INSERT INTO order_status(order_id, order_status_name)
VALUES
(1, 'Pending'),
(3, 'Completed'),
(2, 'Delivered');

