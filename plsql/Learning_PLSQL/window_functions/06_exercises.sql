-- Window Functions Practical Exercises
-- These exercises progress from basic to advanced concepts

/*
Exercise 1: Employee Rankings
Task: Analyze employee salaries within departments
*/

-- 1.1 Create department salary analysis
SELECT 
    department,
    first_name,
    salary,
    -- Basic ranking
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dept_rank,
    -- Percentile within department
    ROUND(
        PERCENT_RANK() OVER (PARTITION BY department ORDER BY salary),
        3
    ) as salary_percentile,
    -- Salary comparison to department average
    ROUND(
        salary / AVG(salary) OVER (PARTITION BY department) * 100,
        2
    ) as pct_of_dept_avg
FROM employees
ORDER BY department, salary DESC;

/*
Exercise 2: Sales Analysis
Task: Calculate various sales metrics
*/

-- 2.1 Sales performance metrics
SELECT 
    sale_date,
    emp_id,
    sale_amount,
