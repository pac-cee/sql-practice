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
