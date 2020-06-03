CREATE DATABASE pizza_customers;
USE pizza_customers;

# Create tables and insert data
CREATE TABLE customer (
    customer_id INTEGER NOT NULL,
    first_name VARCHAR(55) NOT NULL,
    last_name VARCHAR(55) NULL,
    CONSTRAINT PK_customer PRIMARY KEY (customer_id)
);
CREATE TABLE address (
    address_id INTEGER NOT NULL,
    building_number VARCHAR(55) NOT NULL,
    street VARCHAR(55) NOT NULL,
    city VARCHAR(55),
    post_code VARCHAR(55) NOT NULL,
    country VARCHAR(55),
    CONSTRAINT PK_Address PRIMARY KEY (address_id)
);
CREATE TABLE email_address (
    email_address_id INTEGER NOT NULL,
    email_address_customer_id INTEGER,
    email_address VARCHAR(55) NOT NULL,
    CONSTRAINT PK_email_address PRIMARY KEY (email_address_id)
);
CREATE TABLE phone_number (
    phone_number_id INTEGER NOT NULL,
    phone_number_customer_id INTEGER NOT NULL,
    phone_number VARCHAR(55) NOT NULL,
    CONSTRAINT PK_phone_number PRIMARY KEY (phone_number_id)
);
CREATE TABLE orders (
    order_id INTEGER NOT NULL,
    orders_customer_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    CONSTRAINT PK_order_id PRIMARY KEY (order_id)
);
INSERT INTO address 
(address_id, building_number, street, city, post_code, country) 
VALUES 
(1, '20', 'Birch Alley', 'London', 'SE24 0AB', 'UK'),
(2, '17', 'Oak Street', 'London', 'SE25 0XY', NULL);
INSERT INTO customer 
(customer_id, first_name, last_name) 
VALUES 
(1, 'Jon', 'Flanders'),
(2, 'Sam', 'Smith');
INSERT INTO email_address 
(email_address_id, email_address_customer_id, email_address)
VALUES 
(1, 2, 'ssmith@mail.com'),
(2, 1, 'jon@mail.com');
INSERT INTO phone_number
(phone_number_id, phone_number_customer_id, phone_number) 
VALUES 
(1, 1, '555-1212'),
(2, 2, '555-3344');
INSERT INTO orders 
(order_id, orders_customer_id, order_date) 
VALUES 
(1, 1, '2019-08-20'),
(2, 2, '2019-03-15');

# Check if data present
SELECT * FROM email_address;
SELECT * FROM customer;
SELECT * FROM address;
SELECT * FROM orders;

# Set foreign key
ALTER TABLE email_address
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (email_address_customer_id)
REFERENCES customer (customer_id);

SELECT * FROM phone_number;

# Set foreign key
ALTER TABLE phone_number
ADD CONSTRAINT fk_phone_number_customer_id
FOREIGN KEY (phone_number_customer_id)
REFERENCES customer (customer_id);

# Set foreign key 
ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (orders_customer_id)
REFERENCES customer (customer_id);
# Show table information to check if foreign key added
SHOW CREATE TABLE orders;

# Drop foreign key from orders table
ALTER TABLE orders
DROP FOREIGN KEY fk_orders_customer;
# Show table information to check if foreign key removed
SHOW CREATE TABLE orders;

# Set column to NULL
ALTER TABLE customer
CHANGE first_name first_name VARCHAR(55) NULL;

SELECT * FROM address;

# Delete
DELETE FROM address
WHERE building_number=20;

# Drop a table
SELECT * FROM orders;
DROP TABLE orders;
SELECT * FROM orders;
