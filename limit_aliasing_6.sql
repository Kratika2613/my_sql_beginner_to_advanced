-- Limit & Aliasing

SELECT *
FROM  employee_demographics
LIMIT 3;

SELECT *
FROM  employee_demographics
ORDER BY age DESC
LIMIT 2,1; -- Going to start at position 2 and then we're going to go one row after it.

SELECT *
FROM  employee_demographics
ORDER BY age DESC
LIMIT 1,2;

-- Aliasing
SELECT gender, avg(age) as avg_age
FROM  employee_demographics
GROUP BY gender
HAVING avg_age > 40;

