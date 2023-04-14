-- Advanced Window Functions Examples

-- 1. FIRST_VALUE and LAST_VALUE
-- Get the highest and lowest salary in each department
SELECT 
    department,
    first_name,
    salary,
    FIRST_VALUE(salary) OVER (
        PARTITION BY department
         ORDER BY salary DESC
    ) as highest_dept_salary,
    LAST_VALUE(salary) OVER (
        PARTITION BY department 
        ORDER BY salary DESC
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) as lowest_dept_salary
FROM employees;

