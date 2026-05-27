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
FROM employee_demographics 



