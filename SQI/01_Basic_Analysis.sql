/*
=============================================================================
                          HR ANALYTICS SQL PROJECT
------------------------------------------------------------------------------
Author: Sahil Paruthi
Database: PostgreSQL
=============================================================================
*/

--===========================================================================
-- SECTION 1 : Data Exploration
--===========================================================================

-- Query 1 : View First 20 Employees
SELECT *
FROM hr_data
LIMIT 20;

-- Query 2 : Total Employees
SELECT COUNT (*) AS total_employees
FROM hr_data;

-- Query 3 : Total Departmets
SELECT COUNT ( DISTINCT department) AS total_departments
FROM hr_data;

-- Query 4 : Total Cities
SELECT COUNT (DISTINCT city) AS total_cities
FROM hr_data;

--========================================================================
-- SECTION 2 : Employee Analysis
--========================================================================

-- Query 5 : Employees by Department
SELECT 
department,
COUNT(*) AS total_employees
FROM hr_data
GROUP BY department 
ORDER BY total_employees DESC;

-- Query 6 : Employees by Gender
SELECT
gender,
COUNT (*) AS total_employees
FROM hr_data
GROUP BY gender;

-- Query 7 : Employees by Education
SELECT
education,
COUNT (*) AS total_employees
FROM hr_data
GROUP BY education
ORDER BY total_employees DESC;

-- Query 8 : Employees by City
SELECT
city,
COUNT (8) AS total_employees 
FROM hr_data
GROUP BY city
ORDER BY total_employees DESC;

-- Query 9 : Employees by Work Location
SELECT
work_location,
COUNT(8) AS total_employees
FROM hr_data
GROUP BY work_location;

--==========================================================================
-- SECTION 3 : Salary Analysis
--==========================================================================

-- Query 10: Average Salary
SELECT 
ROUND(AVG(salary),2) AS average_salary
FROM hr_daTa;

-- Query 11 : Highest Salary
SELECT
MAX(salary) AS highest_salary
FROM hr_data;

-- Query 12 : Lowest Salary
SELECT
MIN(salary) AS lowest_salary
FROM hr_data;

-- Query 13 : Average Salary by Department
SELECT
department,
ROUND(AVG(salary),2) AS avg_salary
FROM hr_data
GROUP BY department
ORDER BY avg_salary DESC;

-- Query 14 : Top 10 Highest Paid Employees
SELECT
employee_id,
first_name,
last_name,
department,
salary
FROM hr_data
ORDER BY salary DESC
LIMIT 10;

-- Query 15 :Top Paying Department
SELECT
department,
ROUND(AVG(salary),2) AS avg_salary
FROM hr_data
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 1;

--=========================================================================
-- SECTION 4 : Attrition Analysis
--=========================================================================

-- Query 16 : Overall Attrition Rate
SELECT
ROUND(
SUM(CASE WHEN attrition='Yes' THEN 1 ELSE 0 END)
*100.0/
COUNT(*),2)
AS attrition_rate
FROM hr_data;

-- Query 17 : Attrition by Department
SELECT
department,
COUNT(*) FILTER (WHERE attrition='Yes') AS attrition_count
FROM hr_data
GROUP BY department
ORDER BY attrition_count DESC;

-- Query 18 : Attrition by Gender
SELECT
gender,
COUNT(*) FILTER (WHERE attrition='Yes') AS attrition
FROM hr_data
GROUP BY gender;

-- Query 19 : Attrition by Work Location
SELECT
work_location,
COUNT(*) FILTER (WHERE attrition='Yes') AS attrition
FROM hr_data
GROUP BY work_location;

--=========================================================================
--SECTION 5 : Performance Analysis
--=========================================================================

-- Query 20 : Average Performance Rating
SELECT
ROUND(AVG(performance_rating),2) AS average_rating
FROM hr_data;

-- Query 21 : Performance Rating Distribution
SELECT
performance_rating,
COUNT(*) AS employees
FROM hr_data
GROUP BY performance_rating
ORDER BY performance_rating DESC;

-- Query 22 : Average Job Satisfaction
SELECT
ROUND(AVG(job_satisfaction),2) AS average_satisfaction
FROM hr_data;

-- Query 23 : Job Satisfaction Distribution
SELECT
job_satisfaction,
COUNT(*) AS employees
FROM hr_data
GROUP BY job_satisfaction
ORDER BY job_satisfaction;

-- Query 24 : Average Training Hours
SELECT
ROUND(AVG(training_hours),2) AS avg_training_hours
FROM hr_data;

--=========================================================================
-- SECTION 6 : Experience & Promotion Analysis 
--===========================================================================

-- Query 25 : Average Experience
SELECT
ROUND(AVG(experience_years),2) AS average_experience
FROM hr_data;

-- Query 26 : Promotion Rate
SELECT
ROUND(
SUM(CASE WHEN promotion_last_5yrs='Yes' THEN 1 ELSE 0 END)
*100.0/
COUNT(*),2)
AS promotion_rate
FROM hr_data;

-- Query 27 : Average Experience by Department
SELECT
department,
ROUND(AVG(experience_years),2) AS avg_experience
FROM hr_data
GROUP BY department
ORDER BY avg_experience DESC;

--=========================================================================
-- SECTION 7 : Hiring Analysis
--=========================================================================

-- Query 28 : Hiring Trend by Year
SELECT
EXTRACT(YEAR FROM hire_date) AS hiring_year,
COUNT(*) AS employees_hired
FROM hr_data
GROUP BY hiring_year
ORDER BY hiring_year;

-- Query 29 : Hiring by Department
SELECT
department,
COUNT(*) AS hires
FROM hr_data
GROUP BY department
ORDER BY hires DESC;

--========================================================================
-- SECTION 8 : Business Insights
--========================================================================

-- Query 30 : Department with Highest Average Salary
SELECT
department,
ROUND(AVG(salary),2) AS avg_salary
FROM hr_data
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 1;

-- Query 31 : Department with Highest Attrition
SELECT
department,
COUNT(*) FILTER (WHERE attrition='Yes') AS attrition
FROM hr_data
GROUP BY department
ORDER BY attrition DESC
LIMIT 1;

-- Query 32 : Department with Highest Average Performance
SELECT
department,
ROUND(AVG(performance_rating),2) AS avg_rating
FROM hr_data
GROUP BY department
ORDER BY avg_rating DESC;

-- Query 33 : Employees Working Overtime
SELECT
overtime,
COUNT(*) AS employees
FROM hr_data
GROUP BY overtime;

-- Query 34 : Overtime Percentage
SELECT
ROUND(
SUM(CASE WHEN overtime='Yes' THEN 1 ELSE 0 END)
*100.0/
COUNT(*),2)
AS overtime_percentage
FROM hr_data;





