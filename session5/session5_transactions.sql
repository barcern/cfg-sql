# Create infrastructure to demo transactions
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

# Display people with balance > 0 and surname = Smith
# Note that @moneyAvailable variable probably not needed here
SELECT @moneyAvailable:=IF(balance > 0, balance, 0) as money
FROM accounts
WHERE account_holder_surname = 'Smith';

# Simplified version for all entries in table
SELECT IF(balance > 20, balance, 0) as money
FROM accounts;

# Simplified version without @moneyAvailable
SELECT IF(balance > 0, balance, 0) as money
FROM accounts
WHERE account_holder_surname = 'Smith';

# Begin transaction
START TRANSACTION;

# Find all people eligible for a transaction, i.e. balance > 0
SELECT IF(balance > 0, balance, 0) as money
FROM accounts;

# Create a variable to contain the transfer amount
SET @transferamount = 50;

# Run the transfer by updating a person's balance
UPDATE accounts
SET balance = balance - @transferamount
WHERE account_holder_surname = 'Smith';

# Check table
SELECT * FROM accounts;

# Roll back to not retain this change
ROLLBACK;

# Check table
SELECT * FROM accounts;

# Change a person's name
UPDATE accounts
SET account_holder_name = 'Margaret'
WHERE account_holder_surname = 'Smith';

# Commit the change
COMMIT;
