-- String Functions
-- These are built in functions with in my SQL that will help us use strings and works with strings differently.

-- LENGHT FUNCTION
SELECT length('KRATIKA');

SELECT first_name, length(first_name) as len
FROM employee_demographics
ORDER BY len
;

-- UPPER and LOWER FUNCTION
SELECT UPPER('rishi');
SELECT LOWER('RISHI');

SELECT first_name, UPPER(first_name) as UP_CASE
FROM employee_demographics
ORDER BY UP_CASE
;

-- TRIM FUNCTION
-- it takes out whitespace from front and the end 

SELECT TRIM('       This is sky         ');

-- LEFT TRIM (LTRIM) -- cut space from left
SELECT LTRIM('       This is sky         ');

-- RIGHT TRIM (RTRIM) -- cut space from right
SELECT RTRIM('       This is sky         ');

-- SUBSTRING FUNCTION

SELECT first_name, 
LEFT(first_name, 4) -- We are specifying how many characters from left hand side, we want to select, selecting first_name and going from the left four characters
FROM employee_demographics;

SELECT first_name, 
RIGHT(first_name, 4) -- We are specifying how many characters from right hand side, we want to select, selecting first_name and going from the right four characters
FROM employee_demographics;

SELECT first_name, 
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name,3,2), -- here we are telling that from first_name , we have to take character from 3rd position and 2 is telling that we have to take 2 characters
birth_date,
SUBSTRING(birth_date,6,2) AS birth_month
FROM employee_demographics;

-- EXAMPLE
-- SUBSTRING(first_name, 3,3)
-- first_name = Kratika , 
-- so it will give ans - ati

-- REPLACE FUNCTION
-- specify what you want to replace and what you're going to replace it with
SELECT first_name, REPLACE(first_name,'A', 'Z')
FROM employee_demographics;

-- LOCATE
SELECT LOCATE('t', 'Kratika');

SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics;

-- CONCAT FUNCTION
-- It combine columns into one single column.
SELECT first_name, last_name,
CONCAT(first_name,' ',last_name) as full_name
FROM employee_demographics;
