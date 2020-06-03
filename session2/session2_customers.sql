CREATE DATABASE customers;

USE customers;

# Create primary key by specifying in column definition
CREATE TABLE customer 
(customer_id INTEGER NOT NULL PRIMARY KEY, first_name VARCHAR(55), last_name VARCHAR(55));
DROP TABLE customer;

# Create primary key by specifying at the end of CREATE TABLE statement (short)
CREATE TABLE customer
(customer_id INTEGER NOT NULL, first_name VARCHAR(55), last_name VARCHAR(55),
PRIMARY KEY (customer_id));
DROP TABLE customer;

# Create primary key by specifying at the end of CREATE TABLE statement (full)
CREATE TABLE customer
(customer_id INTEGER NOT NULL, first_name VARCHAR(55), last_name VARCHAR(55), 
CONSTRAINT pk_customer_id PRIMARY KEY (customer_id));
DROP TABLE customer;

# Create primary key by altering table after creation
CREATE TABLE customer
(customer_id INTEGER NOT NULL, first_name VARCHAR(55), last_name VARCHAR(55));
ALTER TABLE customer
ADD PRIMARY KEY (customer_id);

# Edit column
ALTER TABLE customer
CHANGE last_name last_name VARCHAR(55) NOT NULL;

# Edit column - nicer option
ALTER TABLE customer
MODIFY last_name VARCHAR(55) NULL;

SHOW CREATE TABLE customer;