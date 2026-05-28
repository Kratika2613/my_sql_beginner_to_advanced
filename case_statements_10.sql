-- CASE STATEMENTS
-- case statements allows you to add logic in your select statement.
-- It is kind of like an if-else statement.
-- We can add multiple case statements, it is an advantage.

SELECT first_name, 
last_name,
age,
CASE 
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Big'
    WHEN age >= 50 THEN 'Old'
END AS Age_Bracket
FROM employee_demographics;

-- Case Scenario
-- We are given the pony council sent out a memo of their bonus and pay increase for the end of the year
-- We need to follow it and determine people's end of salary or the salary going into the new year and,
-- if they got a bonus how much was it ?

-- Pay Increase and Bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS Bonus
FROM employee_salary;

SELECT * 
FROM employee_salary;

SELECT *
FROM parks_departments;



