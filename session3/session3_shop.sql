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

# Find out how many sales took place each week (in no particular order)

# Find out how many sales took place each week (and present data by week in descending
# and then in ascending order)

# Find out how many sales were recorded each week on different days of the week

# We need to change salesperson's name Inga to Annette

# Find out how many sales did Annete do


# How much ( each person sold for the given period



# Find the total monetary sales amount achieved by each store

# Find the number of sales by each person if they did less than 3 sales for the past period
SELECT COUNT(salesamount), salesperson FROM sales1 
GROUP BY salesperson HAVING (COUNT(salesamount) <3);

# Find the total amount of sales by month where combined total is less than 100