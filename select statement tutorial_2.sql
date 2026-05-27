SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT first_name, last_name, birth_date, age, (age +10) * 10 + 10
FROM parks_and_recreation.employee_demographics;
# PEMDAS -- PARENTHESE, EXPONENT,MULTI,DIVIDEC, ADD, SUBSTRACT

# DISTINCT -- SELECT ONLY UNIQUE VALUE WITHIN A COLUMN
SELECT distinct first_name, gender
FROM parks_and_recreation.employee_demographics;