CREATE DATABASE IF NOT EXISTS `LittleLemonDB`;

USE `LittleLemonDB`;

-- Create an ER diagram data model and implement it in MySQL

DROP TABLE IF EXISTS orderdelivery;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS menuitems;
DROP TABLE IF EXISTS customers;

CREATE TABLE staff (
	StaffID INT PRIMARY KEY,
	FirstName VARCHAR(255),
	LastName VARCHAR(255),
	Role VARCHAR(255),
	Salary DECIMAL(10, 2)
);

CREATE TABLE menuitems (
	MenuItemID INT PRIMARY KEY,
	ItemName VARCHAR(64),
	ItemPrice DECIMAL(5, 2)
);

CREATE TABLE menu (
	MenuID INT PRIMARY KEY,
	Cuisine VARCHAR(255),
	Starter VARCHAR(255),
	Course VARCHAR(255),
	Drinks VARCHAR(255),
	Desserts VARCHAR(255),
	MenuItemID INT,
	FOREIGN KEY (MenuItemID) REFERENCES menuitems(MenuItemID)
);

CREATE TABLE customers (
	CustomerID INT PRIMARY KEY,
	FirstName VARCHAR(255),
	LastName VARCHAR(255),
	PhoneNumber VARCHAR(16)
);

CREATE TABLE orders (
	OrderID INT PRIMARY KEY,
	OrderDate DATE,
	OrderQuantity INT,
	OrderType VARCHAR(255),
	TotalCost DECIMAL(10, 2),
	MenuID INT,
	MenuItemID INT,
	CustomerID INT,
	FOREIGN KEY (MenuID) REFERENCES menu(MenuID),
	FOREIGN KEY (MenuItemID) REFERENCES menuitems(MenuItemID),
	FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID)
);

CREATE TABLE bookings (
	BookingID INT PRIMARY KEY,
	Date DATE,
	TableNumber INT,
	CustomerID INT,
	OrderID INT,
	StaffID INT,
	FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
	FOREIGN KEY (OrderID) REFERENCES orders(OrderID),
	FOREIGN KEY (StaffID) REFERENCES staff(StaffID)
);

CREATE TABLE orderdelivery (
	OrderDeliveryID INT PRIMARY KEY,
	OrderDeliveryDate DATE,
	OrderDeliveryStatus VARCHAR(255),
	OrderID INT,
	FOREIGN KEY (OrderID) REFERENCES orders(OrderID)
);
