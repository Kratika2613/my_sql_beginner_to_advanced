-- Stored Procedures

-- Stored Procedures are way to save a SQL code that you can reuse over and over again.
-- When you save it you can call that store procedures and it's going to execute all the code that you wrote within your stored procedure.
-- It's really helpfull for storing complex queries, simplifying repetitive code and just enhancing performance overall.

SELECT *
FROM employee_salary
WHERE salary >= 50000;

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;
-- Through this create procedure we create a STORED PROCEDURES on the left panel under navigator we can see that - large_saaries procedure.

-- We can also specify the database what we want to use like this below, but we don't have to do this -

-- USE parks_and_recreation
CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

-- CALLING STORED PROCEDURE :-

CREATE PROCEDURE large_salaries()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL large_salaries();

-- ****************************************************************

CREATE PROCEDURE less_salaries_50k()
SELECT *
FROM employee_salary
WHERE salary < 50000;

CALL less_salaries_50k();

-- *******************************************************************

-- Here we have 2 different statements here of select and we want them all to be under this large_salaries_1
CREATE PROCEDURE less_salaries_1()
SELECT *
FROM employee_salary
WHERE salary >= 50000;
SELECT *
FROM employee_salary
WHERE salary >= 10000;

-- So, when we run above query, we're getting an output which is not the output we wanted, because it selected everything.
-- Let's see what's happening here -

-- We have created this STORED PROCEDURE the give below -
-- CREATE PROCEDURE less_salaries_1()
-- SELECT *
-- FROM employee_salary
-- WHERE salary >= 50000;

-- But this became just a random query -
-- SELECT *
-- FROM employee_salary
-- WHERE salary >= 10000;

-- But that's not what we wanted, we wanted is everything or both of these queries within one STORED PROCEDURE.

-- So, the best practice is to use something called a DELIMITER. 
-- Like semicolon (;) is a delimiter.
-- So, what this semicolon do, it seperates our queries from one another, it tells mySQL that this a different query do not mix these.
-- We can change the DELIMITER as shown below :-

DELIMITER $$
CREATE PROCEDURE less_salaries_2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL less_salaries_2();

-- EXPLAINATION OF THE ABOVE QUERY BELOW :-
-- In starting we are changing the delimiter to dollar($$) sign.
-- Than, we're are creating a STORED PROCEDURE.
-- And, within it we are keeping all of this select query code into the one STROED PROCEDURE i.e. less_salaries_2.
-- Than, at the end we're saying this is the end of the STROED PROCEDURE. 
-- Now these semicolons are not longer are the delimiter, that's telling us when it is the end of the STORED PROCEDURE.
-- Now, it is the best practice at the end to chnage it back right. 
-- Because if you don't then you have to start using these dollar($$) signs for everything.

-- ********************************************************************************************************************************
-- PARAMETERS

-- Parameters are variables that are passed as an input into a STORED PROCEDURE.
-- They allow the STROED PROCEDURE to accept an input value and place it into your code.

-- I want to retrieve salary of a specific person of whose emp_id we will pass.
DELIMITER $$
CREATE PROCEDURE less_salaries_param(new_emp_parameter INT)
BEGIN
	SELECT salary
	FROM employee_salary
    WHERE employee_id = new_emp_parameter;
END $$
DELIMITER ;

CALL less_salaries_param(1);

-- EXPLAINATION :-
-- We're telling the STROED PROCEDURE, 
-- When somebody calls the STORED PROCEDURE they have to pass through an integer, 
-- It can't string or it can't be date it has to be an integer.
-- We can also change the name of employee_id to pass in a parameter.




