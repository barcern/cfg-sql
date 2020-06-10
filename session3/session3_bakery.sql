USE bakery;

# Show all tables in a database
SHOW TABLES;

# Describe table - shows table info
DESC sweet;
DESC savoury;

# Find all savoury items that have either pork or beef filling
SELECT * FROM savoury sa WHERE (sa.main_ingredient = 'pork' OR sa.main_ingredient = 'beef');
SELECT * FROM savoury sa WHERE sa.main_ingredient IN ('pork', 'beef');

# Find all sweet items that cost 50 cents or cheaper
SELECT * FROM sweet sw WHERE (sw.price <= 0.50);

# Find all sweet items and their price, except for cannoli
SELECT sw.item_name, sw.price FROM sweet sw WHERE sw.item_name != 'cannoli';
SELECT sw.item_name, sw.price FROM sweet sw WHERE sw.item_name <> 'cannoli';
SELECT sw.item_name, sw.price FROM sweet sw WHERE sw.item_name NOT IN ('cannoli');

# Find all sweet items that start with the letter 'c'
SELECT * FROM sweet sw WHERE sw.item_name LIKE 'c%';

# Find all savoury tems that cost more than £1 but less than £3
SELECT * FROM savoury sa WHERE sa.price BETWEEN 1 AND 3; # This includes boundary values
SELECT * FROM savoury sa WHERE sa.price > 1 AND sa.price < 3;

