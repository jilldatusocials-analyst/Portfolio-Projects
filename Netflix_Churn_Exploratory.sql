-- Exploratory Data Analysis

SELECT *
FROM netflixchurn_staging2;

-- Understand dataset size
SELECT COUNT(*) AS total_customers
FROM netflixchurn_staging2;

-- Check customer churn distribution
SELECT
    churned,
    COUNT(*) AS total_customers
FROM netflixchurn_staging2
GROUP BY churned;

-- Calculate churn percentage
SELECT
    churned,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM netflixchurn_staging2),
        2
    ) AS percentage
FROM netflixchurn_staging2
GROUP BY churned;

-- Identify the most common churn reasons
SELECT
    churn_reason,
    COUNT(*) AS total_churned
FROM netflixchurn_staging2
WHERE churned = 1
  AND churn_reason IS NOT NULL
GROUP BY churn_reason
ORDER BY total_churned DESC
LIMIT 5;

-- Compare churn rates by subscription type
SELECT
    subscription_type,
    COUNT(*) AS total_customers,
    SUM(churned = 1) AS churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_rate
FROM netflixchurn_staging2
GROUP BY subscription_type
ORDER BY churn_rate DESC;

-- Analyze customer tenure
SELECT
    tenure_months,
    COUNT(*) AS total_customers,
    SUM(churned = 1) AS churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_rate
FROM netflixchurn_staging2
GROUP BY tenure_months
ORDER BY tenure_months DESC;

-- Analyze churn by age group
SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '56+'
    END AS age_group,
    COUNT(*) AS total_churned
FROM netflixchurn_staging2
WHERE churned = 1
GROUP BY age_group
ORDER BY total_churned DESC;

-- Compare churn by country
SELECT
    country,
    COUNT(*) AS total_customers,
    SUM(churned = 1) AS churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_rate
FROM netflixchurn_staging2
GROUP BY country
HAVING COUNT(*) >= 20
ORDER BY churn_rate DESC;

-- Analyze average customer spending
SELECT
    churned,
    ROUND(AVG(monthly_fee), 2) AS avg_monthly_fee
FROM netflixchurn_staging2
GROUP BY churned;

-- Investigate pricing and discounts
SELECT
    discount_percent,
    COUNT(*) AS total_customers,
    SUM(churned = 1) AS churned_customers,
    ROUND(AVG(churned) * 100, 2) AS churn_rate
FROM netflixchurn_staging2
GROUP BY discount_percent
ORDER BY discount_percent;


