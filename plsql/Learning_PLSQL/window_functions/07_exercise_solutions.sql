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
