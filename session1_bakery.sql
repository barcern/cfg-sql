CREATE DATABASE bakery;

USE bakery;
CREATE TABLE sweet (id INTEGER, item_name VARCHAR(50), price FLOAT);
CREATE TABLE savoury (id INTEGER, item_name VARCHAR(50), price FLOAT, main_ingredient VARCHAR(50));

INSERT INTO sweet (id, item_name, price) 
VALUES (1, 'doughnut', 0.5), (2, 'croissant', 0.75),
(3, 'painauchocolat', 0.55), (4, 'cinnaon twirl', 0.45),
(5, 'cannoli', 0.88), (6, 'apple tart', 1.12);

INSERT INTO savoury (id, item_name, price, main_ingredient) 
VALUES (1, 'meat pie', 1.25, 'pork'), (2, 'sausage roll', 1, null),
(3, 'pasty', 2.45, 'beef');

SELECT * FROM sweet;
SELECT * FROM savoury;
SELECT item_name, price FROM sweet;
SELECT item_name, main_ingredient FROM savoury;
SELECT sweet.item_name, sweet.price FROM sweet;
SELECT savoury.item_name, savoury.main_ingredient FROM savoury;
SELECT sw.item_name, sw.price FROM sweet sw;
SELECT sa.item_name, sa.main_ingredient FROM savoury sa;