--=========================================================================
-- SECTION 1 : WINDOW 
--=========================================================================

-- Query 1 : Top 5 Highest Paid Employees in Each Department
SELECT *
FROM ( SELECT 
employee_id,
first_name,
last_name,
department,
salary,
RANK() OVER ( 
PARTITION BY department
ORDER BY salary DESC )
AS salary_rank
FROM hr_data ) ranked 
WHERE salary_rank <=5;

-- Query 2 :  Salary Rank within Each Department
SELECT
employee_id,
first_name,
department,
salary,
RANK() OVER (
PARTITION BY department
ORDER BY salary DESC) 
AS salary_rank
FROM hr_data;


-- Query 3 : Dense Rank of Salary
SELECT
employee_id,
first_name,
department,
salary,
RANK() OVER (
PARTITION BY department
ORDER BY salary DESC)
AS salary_rank
FROM hr_data;


-- Query 4 : Running Average Salary
SELECT
employee_id,
hire_date,
salary,
ROUND(
AVG(salary) OVER (ORDER BY hire_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ),2 ) 
AS running_average_salary
FROM hr_data;

-- ============================================================================
-- SECTION 2 : COMMON TABLE EXPRESSIONS (CTEs)
-- ============================================================================

-- Query 5 : Average Salary by Department
WITH department_salary AS
( SELECT
department,
AVG(salary) AS avg_salary
FROM hr_data
GROUP BY department)
SELECT *
FROM department_salary
ORDER BY avg_salary DESC;

-- Query 6 : Employees Earning Above Department Average
WITH dept_avg AS
(SELECT
department,
AVG(salary) AS avg_salary
FROM hr_data
GROUP BY department)
SELECT
h.employee_id,
h.first_name,
h.department,
h.salary
FROM hr_data h
JOIN dept_avg d
ON h.department=d.department
WHERE h.salary>d.avg_salary;


-- Query 7 : Department Average Experience
WITH dept_exp AS
(SELECT
department,
ROUND(AVG(experience_years),2) AS avg_experience
FROM hr_data
GROUP BY department)
SELECT *
FROM dept_exp
ORDER BY avg_experience DESC;


-- ============================================================================
-- SECTION 3 : CASE STATEMENTS
-- ============================================================================

-- Query 8 : Salary Band
SELECT
employee_id,
first_name,
salary,
CASE
WHEN salary < 500000 THEN 'Low'
WHEN salary < 1000000 THEN 'Medium'
ELSE 'High'
END AS salary_band
FROM hr_data;


-- Query 9 : Experience Level
SELECT
employee_id,
first_name,
experience_years,
CASE
WHEN experience_years < 3 THEN 'Junior'
WHEN experience_years < 8 THEN 'Mid-Level'
ELSE 'Senior'
END AS experience_level
FROM hr_data;


-- Query 10 : Performance Category
SELECT
employee_id,
performance_rating,
CASE
WHEN performance_rating >=5 THEN 'Excellent'
WHEN performance_rating >=4 THEN 'Good'
WHEN performance_rating >=3 THEN 'Average'
ELSE 'Needs Improvement'
END AS performance_category
FROM hr_data;


-- ============================================================================
-- SECTION 4 : SUBQUERIES
-- ============================================================================

-- Query 11 : Employees Above Company Average Salary
SELECT
employee_id,
first_name,
salary
FROM hr_data
WHERE salary >
(SELECT AVG(salary)
FROM hr_data);


-- Query 12 : Employees with Maximum Experience
SELECT
employee_id,
first_name,
experience_years
FROM hr_data
WHERE experience_years =
(SELECT MAX(experience_years)
FROM hr_data);


-- Query 13 : Employees with Highest Performance Rating
SELECT
employee_id,
first_name,
performance_rating
FROM hr_data
WHERE performance_rating =
(SELECT MAX(performance_rating)
FROM hr_data);


-- ============================================================================
-- SECTION 5 : ADVANCED BUSINESS INSIGHTS
-- ============================================================================

-- Query 14 : Attrition Rate by Department
SELECT
department,
ROUND(COUNT(*) FILTER (WHERE attrition='Yes') *100.0 /
COUNT(*),2)
AS attrition_rate
FROM hr_data
GROUP BY department
ORDER BY attrition_rate DESC;

-- Query 15 : Promotion Rate by Department
SELECT
department,
ROUND(COUNT(*) FILTER (WHERE promotion_last_5yrs='Yes')
*100.0/
COUNT(*),2)
AS promotion_rate
FROM hr_data
GROUP BY department
ORDER BY promotion_rate DESC;

-- Query 16 : Highest Paying City
SELECT
city,
ROUND(AVG(salary),2) AS average_salary
FROM hr_data
GROUP BY city
ORDER BY average_salary DESC;


-- ============================================================================
-- SECTION 6 : ADVANCED AGGREGATIONS
-- ============================================================================

-- Query 17 : Percentage of Employees by Department
SELECT
department,
COUNT(*) AS employees,
ROUND(COUNT(*)*100.0/
SUM(COUNT(*)) OVER(),2)
AS employee_percentage
FROM hr_data
GROUP BY department
ORDER BY employee_percentage DESC;

-- Query 18 : Salary Contribution by Department
SELECT
department,
SUM(salary) AS total_salary,
ROUND(SUM(salary)*100.0/
SUM(SUM(salary)) OVER(),2)
AS salary_percentage
FROM hr_data
GROUP BY department
ORDER BY salary_percentage DESC;

-- Query 19 : Average Salary by Work Location
SELECT
work_location,
ROUND(AVG(salary),2) AS average_salary
FROM hr_data
GROUP BY work_location
ORDER BY average_salary DESC;

-- Query 20 : Highest Salary in Every Department
SELECT DISTINCT
department,
FIRST_VALUE(salary)OVER
(PARTITION BY department
ORDER BY salary DESC)
AS highest_salary
FROM hr_data;
