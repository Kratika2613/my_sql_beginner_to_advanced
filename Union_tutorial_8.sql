-- Unions
-- union allow us to combine rows of data from seperate tables or from the same table.
-- union is done by taking one select statement combining it with another select statement.

SELECT age, gender -- when we are doing this we need to keep the data the same like first_name in place of age, and last_name in place of salary
FROM employee_demographics
UNION      -- as this give in appropriate data
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name
FROM employee_demographics
UNION     -- By Default this is actually a union distinct -- that is why distinct take only take unique values
SELECT first_name, last_name
FROM employee_salary
;


-- UNION ALL
SELECT first_name, last_name
FROM employee_demographics
UNION  ALL   -- we get all of the result without removing duplicates
SELECT first_name, last_name
FROM employee_salary
;

-- USE CASE OF UNION
-- Parks department is trying to cut their budget a little bit they want to identify older employees that they can push
-- And they also wanted to identify high paid employees who they can reduce their pay or push them out to save money

SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;
