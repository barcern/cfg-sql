CREATE DATABASE practice;
USE practice;

# Create a table that contains information about staff, names, departments
CREATE TABLE staff
(
	employeeID INT PRIMARY KEY,
    firstname VARCHAR(45) NOT NULL,
    lastname VARCHAR(45) NOT NULL,
    job_title VARCHAR(45) NOT NULL,
    managerID VARCHAR(45) NOT NULL,
    salary INT,
    dateofbirth date
);

INSERT INTO staff (employeeID, firstname, lastname, job_title, managerID, salary, dateofbirth)
VALUES
(1, 'barbora', 'cernakova', 'consultant', 10, 5, '1995-05-12');
INSERT INTO staff (employeeID, firstname, lastname, job_title, managerID, salary, dateofbirth)
VALUES
(2, 'zac', 'efron', 'travel writer', 100000, 4, '1995-05-11');
INSERT INTO staff (employeeID, firstname, lastname, job_title, managerID, salary, dateofbirth)
VALUES
(3, 'cher', 'clarkson', 'database engineer', 100, 3, '1995-05-10');
INSERT INTO staff (employeeID, firstname, lastname, job_title, managerID)
VALUES
(4, 'jeremy', 'minogue', 'data engineer', 3);

SELECT * FROM staff;

# Set default salary to be 0
ALTER TABLE staff
CHANGE COLUMN salary salary INT NULL DEFAULT 0;

# Set default salary to be 0
ALTER TABLE staff
CHANGE COLUMN dateofbirth dateofbirth DATE NULL DEFAULT '1990-01-01';

# Create a view based on the staff table that does not include salary column
CREATE OR REPLACE VIEW vw_staff AS
SELECT employeeID, firstname, lastname, job_title, managerID
FROM staff;

SELECT * FROM vw_staff;
SELECT * FROM staff;

# This adds the entry into the original table
INSERT INTO vw_staff (employeeID, firstname, lastname, job_title, managerID)
VALUES
(5, 'jack', 'watson', 'data engineer', 3);

# Create a new view with withcheck option
CREATE OR REPLACE VIEW vw_staff_check AS
SELECT employeeID, firstname, lastname, job_title, managerID
FROM staff
WITH CHECK OPTION;

SELECT * FROM vw_staff_check;

INSERT INTO vw_staff_check (employeeID, firstname, lastname, job_title, managerID)
VALUES
(7, 'robert', 'newman', 'data engineer', 6);

# Create a new view with withcheck option
CREATE OR REPLACE VIEW vw_staff_check_filter AS
SELECT employeeID, firstname, lastname, job_title, managerID
FROM staff
WHERE job_title = 'data engineer'
WITH CHECK OPTION;

SELECT * FROM vw_staff_check_filter;

INSERT INTO vw_staff_check_filter (employeeID, firstname, lastname, job_title, managerID)
VALUES
(8, 'tom', 'stone', 'data expert', 6);

INSERT INTO vw_staff_check_filter (employeeID, firstname, lastname, job_title, managerID)
VALUES
(8, 'tom', 'stone', 'data engineer', 6);

SELECT * FROM vw_staff_check_filter;

SELECT * FROM staff;