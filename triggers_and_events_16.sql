-- Triggers and Events

-- Trigger is a block of code that executes automatically when an event takes place on a specific table.

-- EXAMPLE :-

SELECT *
FROM employee_demographics;

SELECT * 
FROM employee_salary;

-- I want that - when somebody is put into the employee_salary table, 
-- I want to automatically update with the employee_id, first_name and last_name into employee_demographics table.
-- So, we will write a trigger when data is updated into employee_salary table,
-- It will also get automatically updated into the employee_demographics table for us.

-- We're using delimiter in case we have multiple lines of code, which we're going to have
-- If we have multiple lines of code when we're creating this trigger this delimiter is going to help us have multiple queries,
-- Within our create trigger statement.

DELIMITER $$
-- we're creating trigger with the name -- employee_insert
CREATE TRIGGER employee_insert
-- Now we need to specify what event needs to take place in order for this to be triggered.
-- We're usinf AFTER because when new information is put on the employee_salary table,
-- It's automatically updated into the employee_demographics table.
	AFTER INSERT ON employee_salary
    FOR EACH ROW 
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
-- We're using NEW as we want to take only new rows that were inserted.
-- If we're using OLD like we're using NEW where - that means it takes rows that were deleted or updated
	VALUES (NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation,salary, dept_id)
VALUES (13, 'John', 'Singh', 'Entertainment 720 CEO', 1000000, NULL);

-- Explaination :-
-- We're creating our trigger called employee_insert.
-- After a row is inserted into the employee_salary table for each row,
-- Then, we're going to insert into the employee_demographics table - employee_id, first_name, last_name
-- Then, we're taking values - NEW.employee_id, NEW.first_name, NEW.last_name
-- Now, mySQL understand that when are saying NEW -
-- We're talking about the event that takes place, this is the data that's being inserted.

-- How to delete already inserted row?

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation,salary, dept_id)
VALUES (13, 'RISHIKESH', 'SINGH', 'Entertainment 720 CEO', 1000000, NULL);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM employee_salary WHERE employee_id = 13;
DELETE FROM employee_demographics WHERE employee_id = 13;
SET SQL_SAFE_UPDATES = 1;


-- EVENTS
-- A trigger happens when an event takes place, whereas an event takes place when it's scheduled.
-- So, this is more of a scheduled automator, rather than a trigger that happens when an event takes place.

-- Events are useful for importantly :-
-- When you are importing data, you can pull data from a specific file path on a schedule.
-- You can build reports that are exported to a file on a schedule.
-- You can do it daily, weekly, monthly, yearly -- it is used for Automation in normal.

-- Use Case :-
-- Pony Council comes up with some new legislation they need to save some money especially in Parks_and_recreation department,
-- We're just spending too much or they're spending too much and, 
-- What they want to do is retire people who are over the age of 60 immediately and give them lifetime pay.
-- So, what we want to do is to create an event that checks is 
-- Let's say every month or every day and then if they're over a specific age we are then going to delete then from the table
-- And, they will be retired.


SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO 
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;

SHOW VARIABLES LIKE 'event%';

