# Create a new db called shop
# Add a table called sales1

# Create and use db
CREATE DATABASE shop;
USE shop;

# Create sales1 table
CREATE TABLE sales1 
(store VARCHAR(50), week INTEGER, day VARCHAR(50), salesperson VARCHAR(50),
salesamount FLOAT(2), month VARCHAR(50));
SELECT * FROM sales1;

# Input data into sales1 table
INSERT INTO sales1 (store, week, day, salesperson, salesamount, month)
VALUES ('london', 2, 'monday', 'frank', 56.25, 'may'),
('london', 5, 'tuesday', 'frank', 74.32, 'sep'),
('london', 5, 'monday', 'bill', 98.42, 'sep'),
('london', 5, 'saturday', 'bill', 73.90, 'dec'),
('london', 1, 'tuesday', 'josie', 44.27, 'sep'),
('dusseldorf', 4, 'monday', 'manfred', 77.00, 'jul'),
('dusseldorf', 3, 'tuesday', 'inga', 9.99, 'jun'),
('dusseldorf', 4, 'wednesday', 'manfred', 86.81, 'jul'),
('london', 6, 'friday', 'josie', 74.02, 'oct'),
('dusseldorf', 1, 'saturday', 'manfred', 43.11, 'apr');

# Ensure that two decimal places displayed in salesamount column
ALTER TABLE sales1 MODIFY COLUMN salesamount DECIMAL(10,2);