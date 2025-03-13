CREATE DATABASE IF NOT EXISTS `LittleLemonDB`;

USE `LittleLemonDB`;

-- Create an ER diagram data model and implement it in MySQL
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS delivery;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS desserts;
DROP TABLE IF EXISTS drinks;
DROP TABLE IF EXISTS entrees;
DROP TABLE IF EXISTS starters;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS staff;

-- Staff table
CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    staff_role VARCHAR(255),
    salary DECIMAL(10, 2)
);

INSERT INTO staff
(staff_id, first_name, last_name, staff_role, salary)
VALUES
(1, 'John', 'Doe', 'Manager', 50000.00),
(2, 'Jane', 'Smith', 'Waiter', 25000.00),
(3, 'Alice', 'Johnson', 'Chef', 30000.00),
(4, 'Bob', 'Brown', 'Bartender', 20000.00);


-- Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    phone_number BIGINT
);

INSERT INTO customers
(customer_id, first_name, last_name, phone_number)
VALUES
(1, 'Alice', 'Smith', 1234567890),
(2, 'Bob', 'Johnson', 2345678901),
(3, 'Charlie', 'Brown', 3456789012),
(4, 'David', 'White', 4567890123);

-- Menu items
CREATE TABLE starters (
    starter_id INT PRIMARY KEY,
    starter_name VARCHAR(64),
    starter_price DECIMAL(5, 2)
);

INSERT INTO starters
(starter_id, starter_name, starter_price)
VALUES
(1, 'Spring Rolls', 5.99),
(2, 'Tom Yum Soup', 6.99),
(3, 'Caesar Salad', 7.99),
(4, 'Caprese Salad', 8.99),
(5, 'Bruschetta', 4.99);


CREATE TABLE entrees (
    entree_id INT PRIMARY KEY,
    entree_name VARCHAR(64),
    entree_price DECIMAL(5, 2)
);

INSERT INTO entrees
(entree_id, entree_name, entree_price)
VALUES
(1, 'Chicken Curry', 12.99),
(2, 'Pad Thai', 10.99),
(3, 'Green Curry', 11.99),
(4, 'Massaman Curry', 13.99),
(5, 'Pineapple Fried Rice', 9.99);

CREATE TABLE drinks (
    drink_id INT PRIMARY KEY,
    drink_name VARCHAR(64),
    drink_price DECIMAL(5, 2)
);

INSERT INTO drinks
(drink_id, drink_name, drink_price)
VALUES
(1, 'Thai Iced Tea', 3.99),
(2, 'Thai Iced Coffee', 4.99),
(3, 'Coconut Water', 2.99),
(4, 'Mango Lassi', 3.99),
(5, 'Lemonade', 2.99);

CREATE TABLE desserts (
    dessert_id INT PRIMARY KEY,
    dessert_name VARCHAR(64),
    dessert_price DECIMAL(5, 2)
);

INSERT INTO desserts
(dessert_id, dessert_name, dessert_price)
VALUES
(1, 'Mango Sticky Rice', 4.99),
(2, 'Coconut Ice Cream', 3.99),
(3, 'Thai Tea Ice Cream', 3.99),
(4, 'Fried Banana', 4.99),
(5, 'Sticky Toffee Pudding', 5.99);


-- Menu table
CREATE TABLE menu (
    menu_id INT PRIMARY KEY,
    starter_id INT,
    entree_id INT,
    drink_id INT,
    dessert_id INT,
    FOREIGN KEY (starter_id) REFERENCES starters (starter_id),
    FOREIGN KEY (entree_id) REFERENCES entrees (entree_id),
    FOREIGN KEY (drink_id) REFERENCES drinks (drink_id),
    FOREIGN KEY (dessert_id) REFERENCES desserts (dessert_id)
);

INSERT INTO menu
(menu_id, starter_id, entree_id, drink_id, dessert_id)
VALUES
(1, 1, 1, 1, 1),
(2, 2, 2, 2, 2),
(3, 3, 3, 3, 3),
(4, 4, 4, 4, 4),
(5, 5, 5, 5, 5);

-- Orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    quantity INT,
    total_cost DECIMAL(10, 2),
    customer_id INT,
    menu_id INT,
    staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (menu_id) REFERENCES menu (menu_id),
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
);

INSERT INTO orders
(order_id, order_date, quantity, total_cost, customer_id, menu_id, staff_id)
VALUES
(1, '2021-01-01', 2, 25.98, 1, 1, 2),
(2, '2021-01-02', 1, 10.99, 2, 2, 3),
(3, '2021-01-03', 3, 23.97, 3, 3, 4),
(4, '2021-01-04', 4, 39.96, 4, 4, 1),
(5, '2021-01-05', 2, 15.98, 1, 5, 2);

-- Order Delivery table
CREATE TABLE delivery (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    delivery_date DATE,
    delivery_status VARCHAR(64),
    delivery_address VARCHAR(255),
    delivery_fee DECIMAL(5, 2),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

INSERT INTO delivery
(
    delivery_id,
    order_id,
    delivery_date,
    delivery_status,
    delivery_address,
    delivery_fee
)
VALUES
(1, 1, '2021-01-01', 'Delivered', '123 Main St, Anytown, CA', 5.00),
(2, 2, '2021-01-02', 'In Progress', '456 Elm St, Othertown, CA', 7.00),
(3, 3, '2021-01-03', 'Delivered', '789 Oak St, Anothertown, CA', 6.00),
(4, 4, '2021-01-04', 'Delivered', '101 Pine St, Yetanothertown, CA', 8.00),
(5, 5, '2021-01-05', 'In Progress', '202 Maple St, Lasttown, CA', 10.00);

-- Bookings table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    booking_date DATE,
    booking_time TIME,
    party_size INT,
    table_no INT,
    customer_id INT,
    staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff (staff_id)
);

INSERT INTO bookings
(
    booking_id,
    booking_date,
    booking_time,
    party_size,
    table_no,
    customer_id,
    staff_id
)
VALUES
(1, '2021-01-01', '18:00:00', 4, 1, 1, 2),
(2, '2021-01-02', '19:00:00', 2, 2, 2, 3),
(3, '2021-01-03', '20:00:00', 6, 3, 3, 4),
(4, '2021-01-04', '21:00:00', 8, 4, 4, 1),
(5, '2021-01-05', '22:00:00', 2, 5, 1, 2);
