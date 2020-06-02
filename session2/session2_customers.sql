CREATE DATABASE customers;

USE customers;

CREATE TABLE customer 
(customer_id INTEGER NOT NULL PRIMARY KEY, first_name VARCHAR(55), last_name VARCHAR(55));

DROP TABLE customer;

CREATE TABLE customer
(customer_id INTEGER NOT NULL, first_name VARCHAR(55), last_name VARCHAR(55),
PRIMARY KEY (customer_id));

DROP TABLE customer;

CREATE TABLE customer
(customer_id INTEGER NOT NULL, first_name VARCHAR(55), last_name VARCHAR(55));

ALTER TABLE customer
ADD PRIMARY KEY (customer_id);

ALTER TABLE customer
CHANGE last_name last_name VARCHAR(55) NOT NULL;