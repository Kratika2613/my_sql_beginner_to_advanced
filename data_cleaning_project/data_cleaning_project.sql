-- Data Cleaning

-- It is where we get data in a more usable format so you fix a lot of the issues in the Raw data.
-- Then we can start creating visualizations or start using it in our products that the data is actually useful.
-- And there are'nt lot of issues with it, that is actually what data cleaning.

-- What we're going to do in this is:-
-- We are going to create a database
-- We're going to import a data set, this is a real data set
-- And, we're going to clean the data.

SELECT *
FROM layoffs;

-- What steps we're going to do in this :-
-- 1. Remove Duplicates
-- 2. Standardize the Data -- this means if there are issues with the data with spelling
-- 3. Null Values or blank Values
-- 4. Remove any Columns or Rows

-- Here we are creating a table layoff_staging to copy all the data from table layoff (this table is having raw data).
CREATE TABLE layoff_staging
LIKE layoffs;

-- Que: Why we created the layoff_staging database, when we had layoff database already with us?
-- Ans: Because we're going to change the staging database alot, and in case if we make some kind of mistakes -
-- Then, we want to have the raw data available, this does happen, that we do in the real workplace,
-- because we don't work on a raw data, we shouldn't do this, as this is not a best practice.

SELECT *
FROM layoff_staging;

-- Here we have inserted the data into the layoff_staging table from layoffs.
INSERT layoff_staging
SELECT *
FROM layoffs;

-- These two select count statements are to verify the data is inserted twice or not.
SELECT COUNT(*)
FROM layoff_staging;

SELECT COUNT(*)
FROM layoffs;

-- This I did as i inserted data twice in a layoff_staging table ,and after this TRUNCATE command I ran a above insert statement again.
TRUNCATE TABLE layoff_staging;

-- Here in below select query I have written date with backticks(``) as date in mySQL is also a keyword.
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoff_staging;

-- This below we have created a CTE for the above query.
-- And here we partitioned by every column from the staging table.

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) AS row_num
FROM layoff_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- In the below query we have checked that Casper have two rows as duplicate and we want to delete one how to do this ?
SELECT *
FROM layoff_staging
WHERE company = 'Casper';

-- We're trying to delete the duplicates :-
-- But while we're not able to do this because :-
-- Error is coming - The target table duplicate_cte of the DELETE is not updatable.
-- Because delete statement is like an update statement and we can not do that.
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) AS row_num
FROM layoff_staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;

-- Que: How we can delete the duplicates in a easy way?
-- Ans: So, we will create a layoff_staging2 database and, then we can delete it,
-- because we can filter on these row_nums and we can delete those which are equal = 2.
-- It is like we're creating some type of table and then just deleting the actual columns.

-- So below I have directly created a table from right clicking on the layoff_staging and, 
-- then copy to clipboard, then Create statement and ctrl+v (paste it).

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- By this select statement we can see that we have got an empty table, now we need to insert the data.
SELECT *
FROM layoff_staging2
WHERE row_num > 1;

INSERT INTO layoff_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) AS row_num
FROM layoff_staging;

-- Now we have seen we have duplicates > 1 and we want to delete them - so below is the query to delete duplicates.
DELETE
FROM layoff_staging2
WHERE row_num > 1;

-- From the below select statement we can see that the row_num > 1 are deleted, there is no data with row_num > 1.
SELECT *
FROM layoff_staging2
WHERE row_num > 1;

-- From this select statement we can see all the data in layoff_staging2 table, and here row_num of each row is now 1 only, 
-- So this column is of no use of anymore, it's a redundant column, it adds up extra space in memory and storage and processing time.
-- So, we need to get rid of this row_num column.
SELECT *
FROM layoff_staging2;

-- Standardizing data
-- This means finding issues in your data and then fixing it.

-- Here in the company column, we can see that there is extra white space may be left or right, 
-- So, we will use TRIM to remove extra white space.

SELECT DISTINCT(TRIM(company))
FROM layoff_staging2;

SELECT company,(TRIM(company))
FROM layoff_staging2;

-- Through the below update statement we have updated the actual company column,
-- Like we have removed extra white space from that column i.e. company.
-- Through just above select statement we can see that.
UPDATE layoff_staging2
SET company = TRIM(company);

-- When we run this query using distinct in industry column we can see that in this column there are null, and blank row
-- So, we will also look into that later.
-- Through order by 1 these blank row, null appear on top.
SELECT DISTINCT industry
FROM layoff_staging2
ORDER BY 1;

-- So, what we want to do we have to update all the crypto curreny as crypto because both are same -- and mostly crypto is there.
SELECT *
FROM layoff_staging2
WHERE industry LIKE 'Crypto%';

-- We have update the actual table - layoff_staging2, set it's industry to crypto.
UPDATE layoff_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Now we we're going through each column in a table and searching for issues. So, in country column we have find the issue.
SELECT DISTINCT country
FROM layoff_staging2
ORDER BY 1;

-- Through above SELECT statement we encounter that there is issue in the country name = United States,
-- As, the name is ('United States'), not ('United States.')
-- So, we need to fix this issue.
-- From the below select statement we can see that, the actual country name is ('United States'), not ('United States.').
SELECT *
FROM layoff_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

-- So, from the below SELECT statement we have fixed the issue using TRAILING,
-- In TRAILING we need to tell what we have to fix, So in our issue we need to remove the dot(.) after the United States.

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoff_staging2
ORDER BY 1;

-- Now, we can update the actual table - layoff_staging2
UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- We need to fix the DATE column as it's definition is text, but it should be date.
-- Because if we want to do the time series stuff, we need date column as date not as text.
-- We also want to format it in the form as : month - day - year.

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoff_staging2;

-- Now, we will update the actual table - layoff_staging2.
UPDATE layoff_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoff_staging2;

-- Now, if we see the data type of date , it is still text not date, so let's change it as well.

ALTER TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoff_staging2;

-- So till here we have done three steps :-
-- 1. Removing duplicates
-- 2. Standardization
-- 3. Working with nulls and blank values (we will do this in below step).
-- 4. Remove columns and rows (we will do this in below step).


-- Populate the null data means - Add values where the data is empty(NULL).

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Here we're setting the column industry as NULL where ever it's blank('')
UPDATE layoff_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoff_staging2
WHERE industry IS NULL
OR industry = '';

-- What we're trying to do is see if any of these have one that's populated.
-- Let's take an example of Airbnb(company) to understand that :-

SELECT *
FROM layoff_staging2
WHERE company = 'Airbnb';

SELECT t1.industry, t2.industry
FROM layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company = t2.company
    AND t1.location = t2.location
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- So, by running the below update statement there is no change in the actual industry column.
-- So, this is typically due to - when we run the above sql select query the t1.industry column is blank not NULL.
-- So, how we can correct it by setting the t1.industry column as NULL from blank.

UPDATE layoff_staging2 t1
JOIN layoff_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

-- Now, the above statement is working as we've converted the blank to NULLS above and,
-- Then we run the update statement again to populate null data.

SELECT *
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Here we've deleted the data from layoff_staging2 where - total_laid_off IS NULL AND percentage_laid_off IS NULL.

DELETE
FROM layoff_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoff_staging2;

-- Now if we want to drop a column from this table :-

ALTER TABLE layoff_staging2
DROP COLUMN row_num;

-- Now we've got a clean data for finding trends and patterns and writing complex queries.
 
