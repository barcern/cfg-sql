USE PARTS;

SELECT * FROM SUPPLY;
SELECT * FROM SUPPLIER;
SELECT * FROM PART;

SELECT p.PNAME FROM part p;
SELECT p.PNAME, p.P_ID FROM part p;
SELECT DISTINCT p.PNAME FROM part p;
SELECT DISTINCT p.PNAME, p.P_ID FROM part p;

SELECT * FROM PROJECT;
SELECT * FROM PROJECT WHERE CITY = 'LONDON';