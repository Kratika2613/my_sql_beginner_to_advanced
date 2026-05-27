-- Joins

SELECT *
FROM employee_demographics;

SELECT *
FROM employee_salary;

-- Inner Join
-- Returns rows that are the same in both columns from both tables

SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
ON dem.employee_id = sal.employee_id;

SELECT dem.employee_id, age, occupation
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
ON dem.employee_id = sal.employee_id;

-- Outer Joins are of two types -- 
-- Left Joins and -- Right Joins

-- Left Join
-- It is going to take everything from the left table, 
-- even if there's no match in the join and it will only return the matches from the right table

SELECT *
FROM employee_demographics as dem
LEFT JOIN employee_salary as sal
ON dem.employee_id = sal.employee_id;

-- Right Join
-- It is going to take everything from the Right table, but only matches on the left table, and if no match it populates it with nulls.

SELECT *
FROM employee_demographics as dem
RIGHT JOIN employee_salary as sal
ON dem.employee_id = sal.employee_id;

-- Self Join
-- It is a join, where you tie a table to itself

-- Understanding self join with a use case
-- Let's say it's december 1st and the employee and Rex Department decided to play secret santa and they wanted to assign
-- Based on their employee_ID the person who they're going to have as a secret santa.

SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id = emp2.employee_id;
 
-- Now what we are going to do is we're going to assign an employee ID to the next employee Id, and that will be their Secret Santa

SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id + 1 = emp2.employee_id;

SELECT emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as emp_name,
emp2.first_name as first_name_emp,
emp2.last_name as last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id + 1 = emp2.employee_id;

-- Joining multiple tables together

SELECT *
FROM employee_demographics as dem
INNER JOIN employee_salary as sal
ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments pd
ON sal.dept_id = pd.department_id;

SELECT *
FROM parks_departments; 
-- this is reference table -- as the value of this table does not chnages often 
-- the refernce table has no duplicates