USE parts;
SHOW TABLES;
SELECT * FROM part;
SELECT * FROM project;
SELECT * FROM supplier;
SELECT * FROM supply;

# 1. Find the name and status of each supplier who supplies project J 2
# Suppliers we are looking for
SELECT j_id, s_id FROM supply WHERE j_id = 'J2';
# Put together using a subquery
SELECT supplier.S_ID, supplier.SNAME, STATUS FROM supplier 
WHERE S_ID IN (SELECT supply.s_id FROM supply WHERE j_id = 'J2');

# 2. Find the name and city of each project supplied by a London based supplier
# Find London based suppliers first
SELECT supplier.S_ID, supplier.SNAME, supplier.CITY FROM supplier 
WHERE CITY = 'LONDON';
# Find projects which they supply
SELECT supply.S_ID, supply.J_ID FROM supply
WHERE S_ID IN (SELECT supplier.S_ID FROM supplier 
WHERE CITY = 'LONDON');
# Display requested project details
SELECT project.J_ID, project.JNAME, project.CITY FROM project 
WHERE project.J_ID IN (SELECT supply.J_ID FROM supply
WHERE S_ID IN (SELECT supplier.S_ID FROM supplier 
WHERE CITY = 'LONDON'));

# 3. Find the name and city of each project not supplied by a London based supplier
# Re-using query from above
SELECT project.J_ID, project.JNAME, project.CITY FROM project 
WHERE project.J_ID NOT IN (SELECT supply.J_ID FROM supply
WHERE S_ID IN (SELECT supplier.S_ID FROM supplier 
WHERE CITY = 'LONDON'));

# 4. Find the supplier name, part name and project name for each case where a supplier
# supplies a project with a part, but also the supplier city, project city and part city
# are the same
SELECT supplier.S_ID, supplier.SNAME, supplier.CITY 'supplier_city',  
part.P_ID, part.PNAME, part.CITY 'part_city',
project.J_ID, project.JNAME, project.CITY 'project_city'
FROM supplier 
INNER JOIN supply ON supplier.S_ID = supply.S_ID
INNER JOIN part ON supply.P_ID = part.P_ID
INNER JOIN project ON supply.J_ID = project.J_ID
WHERE (supplier.CITY = part.CITY AND part.CITY = project.CITY);