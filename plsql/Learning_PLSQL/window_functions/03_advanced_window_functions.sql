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

-- 2. LAG and LEAD functions
-- Compare current salary with previous and next employee's salary in same department
SELECT 
    department,
    first_name,
    salary,
    LAG(salary) OVER (PARTITION BY department ORDER BY salary) as prev_salary,
    LEAD(salary) OVER (PARTITION BY department ORDER BY salary) as next_salary
FROM employees;

-- 3. NTILE function
-- Divide employees into 4 salary quartiles
SELECT 
    first_name,
    salary,
    NTILE(4) OVER (ORDER BY salary DESC) as salary_quartile
FROM employees;

-- 4. Cumulative Distribution
