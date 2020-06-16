USE pizza_customers;
SHOW TABLES;
SELECT * FROM customer;
SELECT * FROM phone_number;

# Query with a subquery
SELECT * FROM customer 
WHERE customer_id IN (SELECT phone_number_customer_id FROM phone_number 
WHERE phone_number = '555-1212');

# Checking subquery on its own
SELECT phone_number_customer_id FROM phone_number 
WHERE phone_number = '555-1212';