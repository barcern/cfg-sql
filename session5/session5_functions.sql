# Using functions

SELECT length('barbora');

SELECT lower('BARBORA');

SELECT upper('barbora');

SELECT trim('    barbora             ');

SELECT date_format('2020-03-01', '%y');

SELECT reverse('CodeFirstGirls');

SELECT now();

SELECT power(8,-1);

USE parts;
SELECT concat(JNAME, ' - ', CITY) FROM project;