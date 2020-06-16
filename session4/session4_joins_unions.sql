CREATE DATABASE joins_practice;
USE joins_practice;

# Create and populate tables
CREATE TABLE fruit_basket1
(
	ID INT,
    FRUIT VARCHAR(50)
);
INSERT INTO fruit_basket1 (ID, Fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'kiwi'),
(4, 'orange'),
(5, 'banana');
CREATE TABLE fruit_basket2
(	
	ID 		INT, 
	Fruit 	VARCHAR(50)
);
INSERT INTO fruit_basket2 (ID, Fruit)
VALUES
(1, 'pear'),
(2, 'apple'),
(3, 'kiwi'),
(6, 'melon'),
(7, 'peach'),
(8, 'plum');

SELECT * FROM fruit_basket1;
SELECT * FROM fruit_basket2;

# JOINs and UNIONs
# Using INNER JOIN
SELECT a.*, b.* FROM fruit_basket1 a INNER JOIN fruit_basket2 b
ON a.ID = b.ID;

# Using LEFT JOIN
SELECT * FROM fruit_basket1 a LEFT JOIN fruit_basket2 b 
ON a.ID = b.ID;

# Using RIGHT JOIN
SELECT a.ID, a.fruit, b.fruit FROM fruit_basket1 a RIGHT JOIN fruit_basket2 b 
ON a.ID = b.ID;

# Using CROSS JOIN
SELECT * FROM fruit_basket1 a CROSS JOIN fruit_basket2 b;

# Using UNION
SELECT a.ID, a.FRUIT FROM fruit_basket1 a UNION SELECT b.ID, b.Fruit FROM fruit_basket2 b;
SELECT a.ID, a.FRUIT FROM fruit_basket1 a UNION ALL SELECT b.ID, b.Fruit FROM fruit_basket2 b;


# Create a table
CREATE TABLE Employee 
(
    EmployeeID 	INT PRIMARY KEY,
    Name 		NVARCHAR(55),
    ManagerID 	INT
);

# Insert sample data
INSERT INTO Employee (EmployeeID, Name, ManagerID)
VALUES
(1, 'Mike', 3),
(2, 'David', 3),
(3, 'Roger', NULL),
(4, 'Marry',2),
(5, 'Joseph',2),
(7, 'Ben',2);

# Using self join to find employees' managers
SELECT a.Name, b.Name manager_name FROM Employee a INNER JOIN Employee b
ON a.ManagerID = b.EmployeeID;
