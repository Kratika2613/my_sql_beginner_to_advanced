-- Window Functions

-- Window functions are somewhat like a group by, except they don't roll everything up into one row when grouping.
-- Window functions allows us to look at a partition or a group but they each keep their own unique rows in the output.

-- We want to take this gender from employee_demographics table and compare it to the actual salaries?

-- What group do - it rolls everything up into one row.
SELECT gender, AVG(salary) as avg_salary
FROM employee_demographics dm
JOIN employee_salary sal
ON dm.employee_id = sal.employee_id
GROUP BY gender;

-- Through WINDOW FUNCTION
-- When we use only OVER() without partition by - we're looking at the avg. salary for the entire column
-- Now when we use OVER(PARTITION BY)- it is going to seperate it out kind of like grouping it. 
-- Why we use it, if we want to add other additional information we can not add in group by but we can add in window function as it do not affect the output 
-- Like we are adding first_name , last_name.
-- Here AVG(salary) OVER(PARTITION BY gender) this statement is totally independent of what is going on in other columns
SELECT dm.first_name,dm.last_name,gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dm
JOIN employee_salary sal
ON dm.employee_id = sal.employee_id;

-- We're going to use rolling total
-- Rolling total is going to start at a specific value and add on values from subsequent rows based off of your partition
SELECT dm.first_name,dm.last_name,gender,salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dm.employee_id) AS Rolling_Total
FROM employee_demographics dm
JOIN employee_salary sal
ON dm.employee_id = sal.employee_id;

-- We're going to look at something like ROW_NUMBER() -- This something like aggregate function.
SELECT dm.employee_id,dm.first_name,dm.last_name,gender,salary,
ROW_NUMBER() OVER(PARTITION BY gender)
FROM employee_demographics dm
JOIN employee_salary sal
ON dm.employee_id = sal.employee_id;

-- Using ORDER BY
SELECT dm.employee_id,dm.first_name,dm.last_name,gender,salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC)
FROM employee_demographics dm
JOIN employee_salary sal
ON dm.employee_id = sal.employee_id;

-- Using RANK()
-- What RANK() do it assigns same number as row but when same content comes like a salary 50000 it assigns same rank to it but when it-
-- Continues it gives same rank as positionally not numerically.
SELECT dm.employee_id,dm.first_name,dm.last_name,gender,salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics dm
JOIN employee_salary sal
ON dm.employee_id = sal.employee_id;

-- DENSE_RANK()
-- dense_rank gives number numerically even after duplicating, it doesn't give positionally.
SELECT dm.employee_id,dm.first_name,dm.last_name,gender,salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num
FROM employee_demographics dm
JOIN employee_salary sal
ON dm.employee_id = sal.employee_id;

-- **IMP**
-- Difference between RANK() v/s DENSE_RANK() v/s ROW_NUMBER
-- RANK() - When duplicates comes it gives the number positionally, not numerically.
-- DENSE_RANK() - When suplicates comes it gives the number numerically, not positionally.
-- ROW_NUMBER() - It is going to give it's own unique within that partition.