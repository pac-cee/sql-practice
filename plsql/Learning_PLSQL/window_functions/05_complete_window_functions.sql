-- Complete Window Functions Reference Guide
-- This file covers ALL window functions with examples for Oracle, PostgreSQL, and MySQL

/*
SECTION 1: RANKING FUNCTIONS
- ROW_NUMBER(): Assigns unique sequential numbers
- RANK(): Assigns ranks with gaps for ties
- DENSE_RANK(): Assigns ranks without gaps
- NTILE(): Divides rows into N groups
*/

-- 1.1 Comparison of all ranking functions
SELECT 
    first_name,
    department,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as row_num,
    RANK() OVER (ORDER BY salary DESC) as rank_with_gaps,
    DENSE_RANK() OVER (ORDER BY salary DESC) as rank_no_gaps,
    NTILE(4) OVER (ORDER BY salary DESC) as quartile
FROM employees;

/*
SECTION 2: OFFSET FUNCTIONS
- LAG(): Access data from previous rows
- LEAD(): Access data from subsequent rows
- FIRST_VALUE(): Get first value in window
- LAST_VALUE(): Get last value in window
- NTH_VALUE(): Get nth value in window
*/

-- 2.1 Complete offset function comparison
SELECT 
    first_name,
    department,
    salary,
    hire_date,
    LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) as prev_salary,
    LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) as next_salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department 
        ORDER BY hire_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as first_salary,
    LAST_VALUE(salary) OVER (
        PARTITION BY department 
        ORDER BY hire_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as last_salary,
    NTH_VALUE(salary, 2) OVER (
        PARTITION BY department 
        ORDER BY salary DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as second_highest_salary
FROM employees;

/*
SECTION 3: STATISTICAL FUNCTIONS
- PERCENT_RANK(): Relative rank (0-1)
- CUME_DIST(): Cumulative distribution
- RATIO_TO_REPORT(): Ratio of value to sum
*/

-- 3.1 Statistical analysis
SELECT 
    first_name,
    department,
    salary,
    ROUND(PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary), 3) as percent_rank,
    ROUND(CUME_DIST() OVER (PARTITION BY department ORDER BY salary), 3) as cume_dist,
    ROUND(
        salary / SUM(salary) OVER (PARTITION BY department),
        3
    ) as ratio_to_dept_total
FROM employees;

/*
SECTION 4: AGGREGATE WINDOW FUNCTIONS
Demonstrates all aggregate functions used as window functions
*/

-- 4.1 Comprehensive aggregates
SELECT 
    first_name,
    department,
    salary,
    COUNT(*) OVER (PARTITION BY department) as dept_count,
    SUM(salary) OVER (PARTITION BY department) as dept_total_salary,
    ROUND(AVG(salary) OVER (PARTITION BY department), 2) as dept_avg_salary,
    MIN(salary) OVER (PARTITION BY department) as dept_min_salary,
    MAX(salary) OVER (PARTITION BY department) as dept_max_salary,
    ROUND(STDDEV(salary) OVER (PARTITION BY department), 2) as dept_salary_stddev,
    ROUND(VARIANCE(salary) OVER (PARTITION BY department), 2) as dept_salary_variance
FROM employees;

