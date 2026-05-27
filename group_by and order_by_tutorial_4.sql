# -- Group By
#-- in sql group by, group together rows that have the same values in the specified column or columns that you're actually grouping on, 
# once you group those rows together you can run something called an aggregate functions on those rows.

SELECT gender 
FROM employee_demographics
GROUP BY gender; 
# the ouput is coming same as when we were using distinct then 
# --- the difference is group by is rolling up all these values into these rows.

SELECT first_name #-- here also gender should be written if not using aggregate function both group by and selected coulmn should match
FROM employee_demographics
GROUP BY gender;
# the select list is not in group by clause and contains non-aggregated columns -- this means
# when you are selecting a column if it's not an aggregated column like avg or 
# something or not using aggregate functions in the select statement it has to be in the group by, these have to match 


SELECT gender , avg(age)
FROM employee_demographics
GROUP BY gender; 
# -- all of the male rows were grouped the avg age is 41
# -- and for female the avg age is 38.5

SELECT gender , avg(age), max(age), min(age), count(age)
FROM employee_demographics
GROUP BY gender; 
# what count is doing here ? ---
# count is going to count the actual rows within the age column -- 
# it is telling how many values are in age column we're actually grouping on gender

-- SELECT age, gender
-- FROM employee_demographics // female -- 4, male -- 7

-- ORDER BY
SELECT *
FROM employee_demographics
ORDER BY first_name;  -- By default ASC order

SELECT *
FROM employee_demographics
ORDER BY first_name DESC; 

SELECT *
FROM employee_demographics
ORDER BY gender; 

SELECT *
FROM employee_demographics
ORDER BY gender, age; 

SELECT *
FROM employee_demographics
ORDER BY gender, age desc; 

SELECT *
FROM employee_demographics
ORDER BY age, gender;  -- As all unique value in age so no order is done in gender column

-- columns position
SELECT *
FROM employee_demographics
ORDER BY 5, 4;  -- here gender is - 5 column and age is - 4 column








