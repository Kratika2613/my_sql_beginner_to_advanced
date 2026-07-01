-- Exploratory Data Analysis
-- Exploring the data and cleaning it at the same time.

SELECT *
FROM layoff_staging2;


SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoff_staging2;

SELECT *
FROM layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT *
FROM layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


SELECT company, SUM(total_laid_off) AS total_laid_off_sum
FROM layoff_staging2
GROUP BY company
ORDER BY total_laid_off_sum DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoff_staging2;

SELECT industry, SUM(total_laid_off) AS total_laid_off_sum
FROM layoff_staging2
GROUP BY industry
ORDER BY total_laid_off_sum DESC;


SELECT *
FROM layoff_staging2;


SELECT country, SUM(total_laid_off) AS total_laid_off_sum
FROM layoff_staging2
GROUP BY country
ORDER BY total_laid_off_sum DESC;


SELECT `date`, SUM(total_laid_off) AS total_laid_off_sum
FROM layoff_staging2
GROUP BY `date`
ORDER BY `date` DESC;


SELECT YEAR(`date`), SUM(total_laid_off) AS total_laid_off_sum
FROM layoff_staging2
GROUP BY YEAR(`date`)
ORDER BY YEAR(`date`) DESC;


SELECT stage, SUM(total_laid_off) AS total_laid_off_sum
FROM layoff_staging2
GROUP BY stage
ORDER BY stage DESC;


SELECT stage, SUM(total_laid_off) AS total_laid_off_sum
FROM layoff_staging2
GROUP BY stage
ORDER BY 2 DESC;


SELECT company, SUM(percentage_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT company, AVG(percentage_laid_off)
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT *
FROM layoff_staging2;


-- In this we're finding per month how many layoffs they had
SELECT SUBSTRING(`DATE`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoff_staging2
WHERE SUBSTRING(`DATE`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;

-- We will do rolling total layoff
-- Doing rolling sum of the above select query 
WITH Rolling_Total AS
(
SELECT SUBSTRING(`DATE`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_laid_off_sum
FROM layoff_staging2
WHERE SUBSTRING(`DATE`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_laid_off_sum,
SUM(total_laid_off_sum) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;


-- Now we're going to see, how much these companies are laying off per year

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 ASC;

-- I want to Rank those :-
-- The highest one, based off the laid_off should be Ranked number 1.
-- We will do this below :-

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY Ranking ASC;

-- **IMP**
-- Ranking of the companies in a year who laid of the most

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoff_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS 
(
SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5;

-- Let's understand the above select query :-
-- 1. We created this query, where we are looking at the company by the year and how many people they laid off.
-- 2. With the company year we change these columns.This is our CTE -
-- 3. So, we created our 1st CTE. Then, we went and gave it a rank and we wanted to filter on that rank.
-- 4. So, we did this rank as another CTE (i.e. 2nd CTE), so we just did a comma and had a second CTE.
-- 5. And, we hit off the 1st CTE the company_year to make this 2nd CTE.
-- 6. Then, finally we queried off the final CTE.

