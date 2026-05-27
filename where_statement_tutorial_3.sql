# ---WHERE Clause ( FILTER OUR RECORDS OR ROWS OF COLUMNS)
# using operator for condition(comparison)
SELECT * 
FROM employee_salary
WHERE first_name = 'Leslie';

SELECT * 
FROM employee_salary
WHERE salary > 50000;

SELECT * 
FROM employee_salary
WHERE salary >= 50000;

SELECT * 
FROM employee_salary
WHERE salary < 50000;

SELECT * 
FROM employee_salary
WHERE salary <= 50000;

SELECT * 
FROM employee_demographics
WHERE gender != 'Female';

SELECT * 
FROM employee_demographics
WHERE gender = 'Female';

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'; # standard type of writing date is 'year-month-date'

# -- AND OR NOT -- Logical Operator
SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'male';

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'male';

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male';

# -- with logical AND and OR we can use parenthesis for any specification (--PEMDAS)
SELECT * 
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;

# -- LIKE Statement
-- % and _
SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a%';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a___%'; 
#using _ we count how many characters will come after the a in this i have give 3 underscore 
# and modulo tells after 3 charaters any character can come,.


SELECT * 
FROM employee_demographics
WHERE birth_date LIKE '1989%';

SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'C%' and age > 40;


