/*
 * Analytical SQL Queries for Employee Analysis
 * Purpose: Demonstrate the use of various window functions and analytical features
 * Author: [Your Name]
 * Date: April 10, 2025
 */

-- 1. Salary Comparison Analysis
-- This query compares each employee's salary with the previous and next salary in the ordered list
-- Using LAG and LEAD window functions for salary comparison
SELECT 
    employee_id,
    salary,
    LAG(salary) OVER (ORDER BY salary) AS previous_salary, -- Gets the previous salary in the ordered list
    CASE 
        WHEN salary > LAG(salary) OVER (ORDER BY salary) THEN 'HIGHER'
        WHEN salary < LAG(salary) OVER (ORDER BY salary) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS comparison_with_previous, -- Compares current salary with previous
