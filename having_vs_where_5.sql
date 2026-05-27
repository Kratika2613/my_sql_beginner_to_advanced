-- Having VS Where

SELECT gender, AVG(age)
FROM employee_demographics
WHERE AVG(age) > 40
GROUP BY gender;
-- Error invalid use of group by function because group by has not happend and 
-- we are trying to filter the age thriugh where so error.

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%Manager%'
GROUP BY occupation;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%Manager%' -- here i have filtered out the row level
GROUP BY occupation
HAVING AVG(salary) > 75000; -- here i have filtered out the aggregate function level
-- this having is only going to work for aggregated functions after group by actually runs


