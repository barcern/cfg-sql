USE bank;

SELECT * FROM accounts;

# Create a stored function to assess whether a custom is eligible for a credit
DELIMITER //

CREATE FUNCTION is_eligible
(
	balance INT
)
RETURNS VARCHAR(20)
DETERMINISTIC # Function will always produce same result - cache mechanism
BEGIN
	DECLARE customer_status VARCHAR(20);
    IF balance > 100 
		THEN SET customer_status = 'yes';
	ELSEIF (balance >= 50 AND balance <= 100) 
		THEN SET customer_status = 'maybe';
	ELSEIF (balance < 50)
		THEN SET customer_status = 'no';
	END IF;
    
    RETURN(customer_status);
END //

DELIMITER ;

SELECT is_eligible(29);
SELECT is_eligible(129);
SELECT is_eligible(59);


# Create a simple greetings stored procedure
DELIMITER //

CREATE PROCEDURE greetings (greeting VARCHAR(100), firstname VARCHAR(100))
BEGIN
	DECLARE fullgreeting VARCHAR(200);
    SET fullgreeting = CONCAT(greeting, ' ', firstname);
	SELECT fullgreeting;
END //

DELIMITER ;

CALL greetings('hello', 'barbora');
CALL greetings('hola', 'josh');

USE bakery;
SELECT * FROM sweet;

DELIMITER //

CREATE PROCEDURE insertval(IN id INT, IN sweet_item VARCHAR(100), IN price FLOAT)
BEGIN
	INSERT INTO sweet 
    VALUES (id, item_name, price);
END //

DELIMITER ;

CALL insertval(8, 'blueberry muffin', 1.89);

SELECT * FROM sweet;

DROP PROCEDURE insertval;

DELIMITER //

CREATE PROCEDURE insertval(IN id INT, IN sweet_item VARCHAR(100), IN price FLOAT)
BEGIN
	INSERT INTO sweet 
    VALUES (id, sweet_item, price);
END //

DELIMITER ;


CALL insertval(8, 'blueberry muffin', 1.89);
