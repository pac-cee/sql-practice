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

-- 3. DENSE_RANK(): Assigns ranks without gaps
SELECT 
    first_name,
    department,
    salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) as salary_rank
FROM employees;

-- 4. Partitioning: Ranking within departments
SELECT 
    first_name,
    department,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as dept_salary_rank
FROM employees;

-- 5. Moving Average (3-day sales average)
-- Oracle and PostgreSQL:
SELECT 
