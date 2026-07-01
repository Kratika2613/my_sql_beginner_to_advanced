-- SUBQUERIES
-- It is a query within a another query

-- We can use subqueries in different ways like - where clause, Select and from clause also

-- What if we only have to select the employees who worked in the actual Parks and Recreation Department?
-- We can also do this by using joins, but if we do not do it through that, than we can use subquery.

SELECT *
FROM employee_demographics
-- Here the employee_id is referencing this employee_demographics table
WHERE employee_id  
IN 
(SELECT employee_id
				FROM employee_salary
                WHERE dept_id = 1
);
-- Explaination of above query
-- We are selecting everything from employee_demographics where the employee_id in employee_demographic table matches or is in,
-- the select employee_id from the salary table where the department_Id = 1

SELECT *
FROM employee_demographics
WHERE employee_id 
-- Here IN is operator and the operand error refering to the whole subquery 
-- subquery is operand from (SELECT employee_id, dept_id to WHERE dept_id = 1)
IN 
(SELECT employee_id , dept_id
-- When we add two columns like employee_id, dept_id there error comes - operand should contain 1 column
-- We can have only 1 column
				FROM employee_salary
                WHERE dept_id = 1
);

-- SUBQUERY in a SELECT statement
-- We want to look at all the salary just like we have it now, 
-- but in a column next to it we also want to compare it to the average salary for everyone
-- By this we will be able to see, whether somebody's salary is above avg. or below avg.

SELECT first_name, salary,
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary;

-- We can also use subquery in FROM statement

-- what if we want to get the average of the oldest age or the average of smallest ages, or average count for males or females ?--
-- That we can not do in the given below query.
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;

SELECT gender, AVG(`MAX(age)`), AVG(`MIN(age)`), AVG(`COUNT(age)`)
-- NOW we want to calculate avg of gender, max(age) and etc.So there column name became AVG(age), MAX(age), MIN(age), COUNT(age) these now-
-- What we are doing, we are going to perform aggregated function on the aggregation of an age column, but we don't have an age column in our table
-- we can see that by running subquery in from clause.
-- We can solve that by using `` so that it become actual name of a column, not an aggregation anymore. 
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
GROUP BY gender
;

SELECT AVG(`MAX(age)`)
FROM
(SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender) AS Agg_table
;

-- Now we don't have to ``
SELECT AVG(avg_age)
FROM
(SELECT gender, 
AVG(age) AS avg_age, 
MAX(age) AS max_age, 
MIN(age) AS min_age, 
COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender) AS Agg_table
;


