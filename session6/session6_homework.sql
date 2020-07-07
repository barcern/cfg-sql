USE bank;
SHOW TABLES;

SELECT * FROM accounts;

# Create a procedure
DELIMITER //
CREATE PROCEDURE homework_proc (account_holder_name VARCHAR(50), greeting VARCHAR(50))
BEGIN
	DECLARE fullgreeting VARCHAR(100);
    SET fullgreeting = account_holder_name