CREATE DATABASE bank;
USE bank;
CREATE TABLE accounts 
(
account_number INTEGER, 
account_holder_name VARCHAR(50),
account_holder_surname VARCHAR(50),
balance INTEGER,
overdraft_allowed BOOLEAN
); 
INSERT INTO accounts
(account_number, account_holder_name, account_holder_surname, balance, overdraft_allowed)
VALUES
(111112, 'Julie', 'Smith', 150, true),
(111113, 'James', 'Andrews', 20, false),
(111114, 'Jack', 'Oakes', -70, true),
(111115, 'Jasper', 'Wolf', 200, true);

SELECT * FROM accounts;

# @moneyAvailable probably not needed
SELECT @moneyAvailable:=IF(balance > 0, balance, 0) as money
FROM accounts
WHERE account_holder_surname = 'Smith';

SELECT IF(balance > 20, balance, 0) as money
FROM accounts;

SELECT IF(balance > 0, balance, 0) as money
FROM accounts
WHERE account_holder_surname = 'Smith';

START TRANSACTION;
SELECT IF(balance > 0, balance, 0) as money
FROM accounts;

# Create a variable
SET @transferamount = 50;

UPDATE accounts
SET balance = balance - @transferamount
WHERE account_holder_surname = 'Smith';

SELECT * FROM accounts;

ROLLBACK;

SELECT * FROM accounts;


UPDATE accounts
SET account_holder_name = 'Margaret'
WHERE account_holder_surname = 'Smith';

COMMIT;

ROLLBACK;