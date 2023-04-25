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
    -- Daily comparison
    sale_amount - LAG(sale_amount) OVER (
        PARTITION BY emp_id 
        ORDER BY sale_date
    ) as day_over_day_change,
    -- Running total per employee
    SUM(sale_amount) OVER (
        PARTITION BY emp_id 
        ORDER BY sale_date
    ) as running_total,
    -- 3-day moving average
    ROUND(
        AVG(sale_amount) OVER (
            ORDER BY sale_date 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ),
        2
    ) as moving_avg
FROM sales
ORDER BY emp_id, sale_date;

/*
Exercise 3: Advanced Analytics
Task: Complex window calculations
*/

-- 3.1 Employee salary bands and rankings
WITH SalaryStats AS (
    SELECT 
        department,
        AVG(salary) as avg_salary,
        STDDEV(salary) as stddev_salary
    FROM employees
    GROUP BY department
),
EmployeeAnalysis AS (
    SELECT 
        e.department,
        e.first_name,
        e.salary,
        s.avg_salary,
        s.stddev_salary,
        CASE
            WHEN e.salary > s.avg_salary + s.stddev_salary THEN 'Above Range'
            WHEN e.salary < s.avg_salary - s.stddev_salary THEN 'Below Range'
            ELSE 'Within Range'
        END as salary_range,
        NTILE(4) OVER (PARTITION BY e.department ORDER BY e.salary) as salary_quartile
    FROM employees e
    JOIN SalaryStats s ON e.department = s.department
)
SELECT 
    department,
    first_name,
    salary,
    ROUND(avg_salary, 2) as dept_avg,
    ROUND(stddev_salary, 2) as dept_stddev,
