-- Solutions to Window Functions Practice Questions

/*
Solution 1: Employees paid more than 1.5x department average
This solution demonstrates using window functions for salary comparison
*/

SELECT 
    department,
    first_name,
    salary,
    ROUND(AVG(salary) OVER (PARTITION BY department), 2) as dept_avg,
    ROUND(salary / AVG(salary) OVER (PARTITION BY department), 2) as ratio_to_avg
FROM employees
WHERE salary > 1.5 * AVG(salary) OVER (PARTITION BY department)
ORDER BY department, salary DESC;

/*
Solution 2: Monthly running totals
This solution shows how to reset running totals periodically
*/

SELECT 
    emp_id,
    sale_date,
    sale_amount,
    EXTRACT(MONTH FROM sale_date) as month,
    EXTRACT(YEAR FROM sale_date) as year,
    SUM(sale_amount) OVER (
        PARTITION BY emp_id, 
                     EXTRACT(YEAR FROM sale_date),
                     EXTRACT(MONTH FROM sale_date)
        ORDER BY sale_date
    ) as monthly_running_total
FROM sales
ORDER BY emp_id, sale_date;

/*
Solution 3: Salary comparison with predecessor and successor
This solution uses multiple window functions to compare values
*/

WITH SalaryComparison AS (
    SELECT 
        first_name,
        department,
        salary,
        hire_date,
        LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) as prev_salary,
        LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) as next_salary
    FROM employees
)
SELECT 
    first_name,
    department,
    salary,
    hire_date
FROM SalaryComparison
WHERE salary > COALESCE(prev_salary, 0)
  AND salary > COALESCE(next_salary, 0);

/*
Solution 4: Highest paid employee per department per year
This solution combines window functions with row filtering
*/

WITH RankedSalaries AS (
    SELECT 
        first_name,
        department,
        salary,
        EXTRACT(YEAR FROM hire_date) as hire_year,
        RANK() OVER (
            PARTITION BY department, EXTRACT(YEAR FROM hire_date)
            ORDER BY salary DESC
        ) as salary_rank
    FROM employees
)
SELECT 
    hire_year,
    department,
    first_name,
    salary
FROM RankedSalaries
WHERE salary_rank = 1
ORDER BY hire_year, department;

/*
Solution 5: Median salary calculation
This solution shows how to calculate median using window functions
*/

WITH SalaryRanks AS (
    SELECT 
        department,
