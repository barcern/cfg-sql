USE practice;

# Create a table that contains information about staff, names, departments with updated date
CREATE TABLE staff_updated
(
	employeeID INT PRIMARY KEY,
    firstname VARCHAR(45) NOT NULL,
    lastname VARCHAR(45) NOT NULL,
    job_title VARCHAR(45) NOT NULL,
    managerID VARCHAR(45) NOT NULL,
    salary INT,
    dateofbirth DATE,
    updated DATE
);

INSERT INTO staff_updated (employeeID, firstname, lastname, job_title, managerID, salary, dateofbirth, updated)
VALUES
(1, 'helen', 'mirren', 'consultant', 10, 5, '1995-05-12', '2020-05-12');
INSERT INTO staff_updated (employeeID, firstname, lastname, job_title, managerID, salary, dateofbirth, updated)
VALUES
(2, 'zac', 'efron', 'travel writer', 100000, 4, '1995-05-11', '2020-05-15');
INSERT INTO staff_updated (employeeID, firstname, lastname, job_title, managerID, salary, dateofbirth, updated)
VALUES
(3, 'cher', 'clarkson', 'database engineer', 100, 3, '1995-05-10', '2020-03-12');
INSERT INTO staff_updated (employeeID, firstname, lastname, job_title, managerID, updated)
VALUES
(4, 'jeremy', 'minogue', 'data engineer', 3, '2020-02-12');

SELECT * FROM staff_updated;

# Create a trigger which updates updated column with current date when table is updated
CREATE TRIGGER trigger_update_date
BEFORE UPDATE
ON staff_updated FOR EACH ROW
SET NEW.updated = curdate();

# Drop trigger before making updates
DROP TRIGGER trigger_update_date;

# Update the table and check whether updated column auto-updates
UPDATE staff_updated
SET lastname = 'efron'
WHERE employeeID = 3;



