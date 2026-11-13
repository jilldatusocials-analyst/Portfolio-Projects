-- Data Cleaning Project

SELECT *
FROM netflix_churn;

-- Created a staging table
CREATE TABLE netflixchurn_staging
LIKE netflix_churn;

SELECT * 
FROM netflixchurn_staging;

INSERT netflixchurn_staging
SELECT * 
FROM netflix_churn;

-- Remove Duplicates 
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY customer_id, age, gender, country, region, signup_date, tenure_months, subscription_type, monthly_fee, promo_used, discount_percent, acquisition_channel, payment_method, auto_renew, payment_failures, device, number_of_profiles, favorite_genre, watch_hours, avg_watch_time_per_day, avg_session_minutes, sessions_per_month, last_login_days, support_tickets, satisfaction_score, lifetime_revenue, churned, churn_date, churn_reason) AS row_num
FROM netflixchurn_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY customer_id, age, gender, country, region, signup_date, tenure_months, subscription_type, monthly_fee, promo_used, discount_percent, acquisition_channel, payment_method, auto_renew, payment_failures, device, number_of_profiles, favorite_genre, watch_hours, avg_watch_time_per_day, avg_session_minutes, sessions_per_month, last_login_days, support_tickets, satisfaction_score, lifetime_revenue, churned, churn_date, churn_reason) AS row_num
FROM netflixchurn_staging
) 
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

SELECT *
FROM netflixchurn_staging
WHERE customer_id = '00de382d-d253-4a73-ba4e-bcb8a557f956';

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY customer_id, age, gender, country, region, signup_date, tenure_months, subscription_type, monthly_fee, promo_used, discount_percent, acquisition_channel, payment_method, auto_renew, payment_failures, device, number_of_profiles, favorite_genre, watch_hours, avg_watch_time_per_day, avg_session_minutes, sessions_per_month, last_login_days, support_tickets, satisfaction_score, lifetime_revenue, churned, churn_date, churn_reason) AS row_num
FROM netflixchurn_staging
) 
DELETE
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `netflixchurn_staging2` (
  `customer_id` text,
  `age` double DEFAULT NULL,
  `gender` text,
  `country` text,
  `region` text,
  `signup_date` text,
  `tenure_months` int DEFAULT NULL,
  `subscription_type` text,
  `monthly_fee` double DEFAULT NULL,
  `promo_used` text,
  `discount_percent` int DEFAULT NULL,
  `acquisition_channel` text,
  `payment_method` text,
  `auto_renew` text,
  `payment_failures` int DEFAULT NULL,
  `device` text,
  `number_of_profiles` int DEFAULT NULL,
  `favorite_genre` text,
  `watch_hours` double DEFAULT NULL,
  `avg_watch_time_per_day` double DEFAULT NULL,
  `avg_session_minutes` double DEFAULT NULL,
  `sessions_per_month` int DEFAULT NULL,
  `last_login_days` int DEFAULT NULL,
  `support_tickets` int DEFAULT NULL,
  `satisfaction_score` double DEFAULT NULL,
  `lifetime_revenue` double DEFAULT NULL,
  `churned` int DEFAULT NULL,
  `churn_date` text,
  `churn_reason` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM netflixchurn_staging2;

INSERT INTO netflixchurn_staging2
SELECT *,
ROW_NUMBER () OVER (
PARTITION BY customer_id, age, gender, country, region, signup_date, tenure_months, subscription_type, monthly_fee, promo_used, discount_percent, acquisition_channel, payment_method, auto_renew, payment_failures, device, number_of_profiles, favorite_genre, watch_hours, avg_watch_time_per_day, avg_session_minutes, sessions_per_month, last_login_days, support_tickets, satisfaction_score, lifetime_revenue, churned, churn_date, churn_reason) AS row_num
FROM netflixchurn_staging;

SELECT *
FROM netflixchurn_staging2
WHERE row_num > 1;

DELETE 
FROM netflixchurn_staging2
WHERE row_num > 1;

SELECT *
FROM netflixchurn_staging2;

SELECT DISTINCT customer_id
FROM netflixchurn_staging2;

SELECT DISTINCT subscription_type
FROM netflixchurn_staging2;

SELECT DISTINCT (region)
FROM netflixchurn_staging2
ORDER BY 1; 

SELECT signup_date, churn_date
FROM netflixchurn_staging2;

ALTER TABLE netflixchurn_staging2
MODIFY signup_date DATE,
MODIFY churn_date DATE;

-- Null Values or blank values
SELECT * 
FROM netflixchurn_staging2
WHERE churn_reason IS NULL;

SELECT *
FROM netflixchurn_staging2
WHERE churn_reason IS NULL
   OR TRIM(churn_reason) = '';
   
SELECT
    SUM(customer_id IS NULL) AS null_customer_id,
    SUM(age IS NULL) AS null_age,
    SUM(gender IS NULL) AS null_gender,
    SUM(country IS NULL) AS null_country,
    SUM(tenure_months IS NULL) AS null_tenure,
    SUM(monthly_fee IS NULL) AS null_monthly_fee,
    SUM(churned IS NULL) AS null_churned,
    SUM(churn_reason IS NULL) AS null_churn_reason
FROM netflixchurn_staging2;
   
SELECT subscription_type, COUNT(*) AS total_records
FROM netflixchurn_staging2
GROUP BY subscription_type
ORDER BY subscription_type;

-- Remove Any Columns or Rows
ALTER TABLE netflixchurn_staging2
DROP COLUMN row_num;


 
 