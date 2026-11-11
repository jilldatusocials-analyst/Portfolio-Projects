-- Data Cleaning Project

SELECT *
FROM tech_layoffs_hiring_trends_elite_v2;

-- Splitting the Data and Creating another Table
CREATE TABLE `tech_layoffs` (
  `record_id` text,
  `company_name` text,
  `industry` text,
  `country` text,
  `company_size` text,
  `month` text,
  `year` int DEFAULT NULL,
  `layoffs_count` int DEFAULT NULL,
  `layoff_percentage` double DEFAULT NULL,
  `reason_for_layoffs` text,
  `ai_automation_impact` double DEFAULT NULL,
  `ai_replacement_risk` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM tech_layoffs;

INSERT INTO tech_layoffs (
    record_id,
    company_name,
    industry,
    country,
    company_size,
    month,
    year,
    layoffs_count,
    layoff_percentage,
    reason_for_layoffs,
    ai_automation_impact,
    ai_replacement_risk
)
SELECT
    record_id,
    company_name,
    industry,
    country,
    company_size,
    month,
    year,
    layoffs_count,
    layoff_percentage,
    reason_for_layoffs,
    ai_automation_impact,
    ai_replacement_risk 
FROM tech_layoffs_hiring_trends_elite_v2;

SELECT *
FROM tech_layoffs;

SELECT *
FROM tech_layoffs_hiring_trends_elite_v2;

CREATE TABLE `hiring_growth` (
  `open_roles` int DEFAULT NULL,
  `hiring_trend` text,
  `remote_jobs_percentage` double DEFAULT NULL,
  `top_hiring_role` text,
  `stock_growth_percent` double DEFAULT NULL,
  `revenue_growth_percent` double DEFAULT NULL,
  `salary_budget_change` double DEFAULT NULL,
  `ai_adoption_level` double DEFAULT NULL,
  `employee_sentiment` double DEFAULT NULL,
  `job_security_score` double DEFAULT NULL,
  `market_condition` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO hiring_growth (
    open_roles,
    hiring_trend,
    remote_jobs_percentage,
    top_hiring_role,
    stock_growth_percent,
    revenue_growth_percent,
    salary_budget_change,
    ai_adoption_level,
    employee_sentiment,
    job_security_score,
    market_condition
)
SELECT
	open_roles,
    hiring_trend,
    remote_jobs_percentage,
    top_hiring_role,
    stock_growth_percent,
    revenue_growth_percent,
    salary_budget_change,
    ai_adoption_level,
    employee_sentiment,
    job_security_score,
    market_condition
FROM tech_layoffs_hiring_trends_elite_v2;

SELECT * 
FROM hiring_growth;

SELECT industry
FROM tech_layoffs;

-- Missing Null Value Checks
SELECT *
FROM tech_layoffs
WHERE company_name IS NULL;

SELECT
SUM(company_name IS NULL) AS MissingCompany,
SUM(industry IS NULL) AS MissingIndustry
FROM tech_layoffs;

-- Identify duplicates using ROW_NUMBER
SELECT *
FROM tech_layoffs;

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company_name, industry, country, company_size, month, year, layoffs_count, reason_for_layoffs, ai_automation_impact) as row_num
FROM tech_layoffs;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY company_name, industry, country, company_size, month, year, layoffs_count, reason_for_layoffs, ai_automation_impact) as row_num
FROM tech_layoffs
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Remove irrelevant column
ALTER TABLE tech_layoffs
DROP record_id;

SELECT DISTINCT company_name, industry
FROM tech_layoffs; 

-- Standardizing Data
SELECT *
FROM tech_layoffs
WHERE company_name LIKE 'NVIDIA';

UPDATE tech_layoffs
SET industry = 'AI'
WHERE company_name = 'NVIDIA';

-- NVIDIA was categorized under different industries.
-- Standardized all NVIDIA records to 'AI' for consistency.

SELECT
COUNT(*) AS TotalRows,
COUNT(company_name) AS CompanyName,
COUNT(industry) AS Industry
FROM tech_layoffs;

-- Top companies by layoffs
SELECT *
FROM tech_layoffs; 

SELECT
company_name,
SUM(layoffs_count) AS total_layoffs
FROM tech_layoffs
GROUP BY company_name
ORDER BY total_layoffs DESC;

-- Top industries
SELECT
industry,
SUM(layoffs_count)
FROM tech_layoffs
GROUP BY industry;

-- Top countries
SELECT
country,
SUM(layoffs_count)
FROM tech_layoffs
GROUP BY country;

SELECT *
FROM tech_layoffs
ORDER BY layoffs_count DESC;

-- Average layoff percentage
SELECT
industry,
AVG(layoff_percentage)
FROM tech_layoffs
GROUP BY industry;

-- Companies with highest AI replacement risk
SELECT
company_name,
ai_replacement_risk
FROM tech_layoffs
ORDER BY ai_replacement_risk DESC;



