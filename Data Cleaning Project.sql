-- Data Cleaning Project 

SELECT *
FROM hiring_growth;

-- Remove irrelevant column
ALTER TABLE hiring_growth
DROP open_roles;

-- Identify duplicates using ROW_NUMBER
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY hiring_trend, remote_jobs_percentage, top_hiring_role, revenue_growth_percent, salary_budget_change, employee_sentiment, market_condition) as row_num
FROM hiring_growth;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY hiring_trend, remote_jobs_percentage, top_hiring_role, revenue_growth_percent, salary_budget_change, employee_sentiment, market_condition) as row_num
FROM hiring_growth
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM hiring_growth;

SELECT hiring_trend, top_hiring_role
FROM hiring_growth 
ORDER BY top_hiring_role DESC; 

SELECT AVG(remote_jobs_percentage)
FROM hiring_growth;

SELECT COUNT(remote_jobs_percentage)
FROM hiring_growth;

SELECT AVG(stock_growth_percent)
FROM hiring_growth;

SELECT revenue_growth_percent, market_condition
FROM hiring_growth
ORDER BY market_condition DESC;

SELECT employee_sentiment
FROM hiring_growth; 