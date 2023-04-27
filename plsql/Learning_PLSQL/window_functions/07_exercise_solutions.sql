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
