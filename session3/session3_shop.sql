USE shop;

SHOW TABLES;
SELECT * FROM sales1;

SELECT COUNT(*), day FROM sales1 GROUP BY day;
SELECT COUNT(*), store FROM sales1  GROUP BY store;
SELECT COUNT(*), store, day FROM sales1 where day = 'monday';

# Find out how many sales took place each week (in no particular order)
SELECT week, COUNT(*), salesamount FROM sales1 GROUP BY week ORDER BY week DESC;

# Find all sales records (and all columns) that took place in the London store, not in
# December, but sales concluded by Bill or Frank for the amount higher than 50
SELECT * FROM sales1 WHERE store = 'london' AND month != 'dec' 
AND (salesperson = 'frank' OR salesperson = 'bill') AND salesamount > 50;
SELECT * FROM sales1 WHERE store = 'london' AND month != 'dec' 
AND salesperson IN ('frank', 'bill') AND salesamount > 50;

# Find the total sales amount by each person by day
SELECT salesperson, day, SUM(salesamount) amount FROM sales1 GROUP BY salesperson, day
ORDER BY salesperson, amount DESC;
SELECT salesperson, day, SUM(salesamount) amount FROM sales1 GROUP BY salesperson, day
ORDER BY FIELD (day, 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday');

# How much (sum) each person sold for the given period, including the number of sales per
# person, their average, lowest and highest sale amounts
SELECT SUM(salesamount) 'total sales', 
	   MAX(salesamount) 'highest sale', 
       MIN(salesamount) 'lowest sale', 
       AVG(salesamount) 'sale average', 
       COUNT(salesamount) 'number of sales',
       salesperson 
FROM sales1 GROUP BY salesperson;

# Find the number of sales by each person if they did less than 3 sales for the past period
SELECT COUNT(salesamount), salesperson FROM sales1 
GROUP BY salesperson HAVING (COUNT(salesamount) <3);
