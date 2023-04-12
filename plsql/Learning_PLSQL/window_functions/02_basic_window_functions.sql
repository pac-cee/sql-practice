-- Basic Window Functions Examples

-- 1. ROW_NUMBER(): Assigns unique row numbers
-- Oracle, PostgreSQL, MySQL syntax is the same
SELECT 
    first_name,
    department,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as salary_rank
FROM employees;

-- 2. RANK(): Assigns ranks with gaps
SELECT 
    first_name,
    department,
    salary,
    RANK() OVER (ORDER BY salary DESC) as salary_rank
FROM employees;

