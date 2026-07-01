-- Temporary Tables

-- Temporary tables are tables that are only visible to the session that they're created in.
-- Example:-
-- If I create a temp table right now and I exit the my SQL and I come back in it's not going to be there anymore.
-- As data analyst how we can use temp tables - is for storing intermediate results for complex queries.
-- These are somewhat like a CTE but also for using it to manipulate data before I insert it into a more permanent table.

-- There are two ways to create a temp tables :-

-- TYEPE_1. Create the table first, then insert data :-
--    You define the columns and datatypes manually.

-- TYPE_2. Create and populates the table in one step (CTAS - Create Table As Select) :-
--    The Table structure is automatically derived from the SELECT query.

-- TYEP_1 :-
CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
fav_movie varchar(100)
);

INSERT INTO temp_table
VALUES
('Kratika','Pachori','Dhurandhar'),
('Srashti','Shrivastava','Dhurandhar-the revenge');

SELECT *
FROM temp_table;

SELECT *
FROM employee_salary;

-- TYPE_2 :-
-- In this we don't have to insert data into it, more than we're just going to select data from already existing table.
CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;

-- ----------------------------------------------------
CREATE TEMPORARY TABLE salary_below_50k
SELECT *
FROM employee_salary
WHERE salary < 50000;

SELECT *
FROM salary_below_50k;

-- Temp tables is usually for the more advanced things. 
-- So, These are usually used for STORED PROCEDURES, When we are really manipulating data.
-- But with CTEs it's typically more simple things because you can't make as advanced CTE.