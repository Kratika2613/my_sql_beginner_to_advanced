-- CTEs

-- CTEs stand for Common Table Expression
-- They're going to allow you to define a subquery block that you can, then reference within the main query.
-- CTEs are unique because you can only use the CTE immediately after you create it

-- We have defined CTE by giving name as - CTE_Example
WITH CTE_Example AS
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem 
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT *
FROM CTE_Example
;

-- When we build a CTE we can use it immediately after writing a CTE. We can not reuse it. 
-- It is just like calling a query that you wrote before.
WITH CTE_Example AS
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem 
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example
;

-- We can do above using SUBQUERY also, but it becomes a little tougher and the readability also decreases.
-- Let's see through subquery.
-- Through SUBQUERY also we get same Output.

SELECT AVG(avg_sal)
FROM (
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem 
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender
) example_subquery
;

-- If we want to do a more complex query or joining more complex queries together we can do that all within one CTE.
-- WE can have multiple CTE's within a CTE.
WITH CTE_Example AS
(
SELECT employee_id, gender, birth_date
FROM employee_demographics 
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
ON CTE_Example.employee_id = CTE_Example2.employee_id
;

-- We can change column names by overwriting them below.
WITH CTE_Example (Gender, AVG_sal, MAX_sal, MIN_sal, COUNT_sal) AS
(
SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
FROM employee_demographics dem 
JOIN employee_salary sal
ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example
;