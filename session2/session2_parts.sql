USE PARTS;

SELECT * FROM SUPPLY;
SELECT * FROM SUPPLIER;
SELECT * FROM PART;

SELECT p.PNAME FROM PART p;
SELECT p.PNAME, p.P_ID FROM PART p;
# Return all unique part names
SELECT DISTINCT p.PNAME FROM PART p;
# Return all unique part names and their ids - looks for unique pairs
# rather than individual values
SELECT DISTINCT p.PNAME, p.P_ID FROM PART p;
# Query below returns distinct values in PNAME and displays associated P_ID
SELECT p.PNAME, p.P_ID FROM PART p GROUP BY p.PNAME;

# Return all projects which are run in London
SELECT * FROM PROJECT;
SELECT * FROM PROJECT WHERE CITY = 'LONDON';