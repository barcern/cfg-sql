# Use parts db to write the following queries
# - find the name and weight of each red part
# - find all unique suppliers' names from London

USE parts;

# Find name and weight of each red part
SELECT p.pname, p.weight 
FROM part p 
WHERE colour='red';

# Find all unique supplier's names from London
SELECT DISTINCT s.sname 
FROM supplier s
WHERE city='london';