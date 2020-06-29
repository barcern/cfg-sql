# Using in-built functions

# To get length of a string
SELECT length('barbora');

# To turn string into lower case
SELECT lower('BARBORA');

# To turn string into upper case
SELECT upper('barbora');

# To remove whitespace (both left and right)
SELECT trim('    barbora             ');

# To return a specific item within a date, e.g. year
SELECT date_format('2020-03-01', '%y');

# To reverse a string
SELECT reverse('CodeFirstGirls');

# To return current date and time
SELECT now();

# To calculate a value using powers
SELECT power(8,-1);

# To join two columns into one
USE parts;
SELECT concat(JNAME, ' - ', CITY) FROM project;