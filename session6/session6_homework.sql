# Create a procedure to provide a selection of greetings

USE bank;
SHOW TABLES;
SELECT * FROM accounts;

DELIMITER //
CREATE PROCEDURE homework_proc (account_holder_name VARCHAR(50), greeting VARCHAR(50))
BEGIN
	DECLARE print_value VARCHAR(50);
    DECLARE fullgreeting VARCHAR(100);
    IF (greeting = 'one') 
		THEN 
			SET print_value = CONCAT('Hello ', account_holder_name);
		ELSE
			SET print_value = CONCAT('Hi there ', account_holder_name);
    END IF;
    SET fullgreeting = print_value;
    SELECT fullgreeting;
END //
DELIMITER ;

DROP PROCEDURE homework_proc;

CALL homework_proc('Father Brown','one');
CALL homework_proc('Father Brown','two');


# Create a function to check whether I can afford a sweet item from the bakery
USE bakery;
SELECT * FROM sweet;
DESCRIBE sweet;

DELIMITER //
CREATE FUNCTION can_afford (name VARCHAR(50), my_money FLOAT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
	DECLARE fn_price FLOAT;
    DECLARE result VARCHAR(10);
    SET fn_price = (SELECT sweet.price FROM sweet WHERE (sweet.item_name = 'doughnut'));
    IF (fn_price <= my_money)
		THEN SET result = 'yes';
        ELSE SET result = 'no';
	END IF;
    RETURN(result);
END //
DELIMITER ;

DROP FUNCTION can_afford;

SELECT can_afford('doughnut',5);
SELECT can_afford('doughnut',0.5);
SELECT can_afford('doughnut',0.49);


# Make changes to sweet table in bakery db to accommodate a trigger and an event
USE bakery;

ALTER TABLE sweet
ADD COLUMN quantity INT
AFTER price;

ALTER TABLE sweet
ADD COLUMN stock VARCHAR(10)
AFTER quantity;

SELECT * FROM sweet;

UPDATE sweet
SET 
	quantity = 5,
    stock = 'in'
WHERE id = 1;


# Create a trigger to set stock to out when quantity reaches 0
DELIMITER //
CREATE TRIGGER trigger_update_stock
BEFORE UPDATE
ON sweet FOR EACH ROW
BEGIN
	IF (NEW.quantity < 1)
		THEN SET NEW.stock = 'out';
	END IF;
END //
DELIMITER ;

DROP TRIGGER trigger_update_stock;

UPDATE sweet
SET 
	quantity = 0
WHERE id = 1;


# Create an event to restock (quantity to 10 and stock to in) once a day
# for items which are not at full stock
CREATE EVENT event_restock
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
ON COMPLETION PRESERVE
DO
	UPDATE sweet
    SET 
		quantity = 10,
        stock = 'in'
	WHERE (quantity < 10 OR quantity is null);
    
DROP EVENT event_restock;

SELECT * FROM sweet;
