USE shop;
SHOW TABLES;
SELECT * FROM sales1;

# Find all sales records (and all columns) that took place in the London store, not in
# December, but sales concluded by Bill or Frank for the amount higher than 50
SELECT * FROM sales1 WHERE store = 'london' AND month != 'dec' 
AND salesperson IN ('frank', 'bill') AND salesamount > 50;

# Find out how many sales took place each week (in no particular order)
SELECT week, SUM(salesamount) 'weekly sales' FROM sales1 GROUP BY week;

# Find out how many sales took place each week (and present data by week in descending
# and then in ascending order)
SELECT week, COUNT(week) 'number of sales' FROM sales1 GROUP BY week ORDER BY week ASC;
SELECT week, COUNT(week) 'number of sales' FROM sales1 GROUP BY week ORDER BY week DESC;

# Find out how many sales were recorded each week on different days of the week
SELECT day, COUNT(day) FROM sales1 GROUP BY day;

# We need to change salesperson's name Inga to Annette
UPDATE sales1 SET sales1.salesperson = 'annette' WHERE sales1.salesperson = 'inga';

# Find out how many sales did Annete do
SELECT salesperson, COUNT(salesperson) 'number of sales' FROM sales1 WHERE salesperson = 'annette';

# Find the total sales amount by each person by day
SELECT salesperson, day, SUM(salesamount) FROM sales1 GROUP BY salesperson, day ORDER BY salesperson;

# How much (sum) each person sold for the given period
SELECT salesperson, SUM(salesamount) 'total sales' FROM sales1 GROUP BY salesperson ORDER BY salesperson;

# How much (sum) each person sold for the given period, including the number of sales per
# person, their average, lowest and highest sale amounts
SELECT salesperson, SUM(salesamount) 'total sales', MIN(salesamount) 'smallest sale', 
MAX(salesamount) 'largest sale', AVG(salesamount) 'average sale' FROM sales1 GROUP BY salesperson 
ORDER BY salesperson;

# Find the total monetary sales amount achieved by each store
SELECT store, SUM(salesamount) 'total sales' FROM sales1 GROUP BY store;

# Find the number of sales by each person if they did less than 3 sales for the past period
SELECT salesperson, COUNT(salesperson) 'number of sales' FROM sales1 GROUP BY salesperson 
HAVING COUNT(salesperson) < 3;

# Find the total amount of sales by month where combined total is less than 100
SELECT month, SUM(salesamount) 'total sales' FROM sales1 GROUP BY month HAVING SUM(salesamount) < 100
ORDER BY FIELD (month, 'apr', 'may', 'jun', 'oct', 'dec');