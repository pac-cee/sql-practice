-- Window Functions Tutorial with Examples
-- First, let's create and populate sample tables

-- Create an employees table for our examples
CREATE TABLE employees (
    emp_id NUMBER,
    emp_name VARCHAR2(50),
    department VARCHAR2(50),
    salary NUMBER,
    hire_date DATE
);

-- Insert sample data
INSERT INTO employees VALUES (1, 'John Smith', 'IT', 75000, DATE '2020-01-15');
INSERT INTO employees VALUES (2, 'Mary Johnson', 'IT', 85000, DATE '2019-03-20');
INSERT INTO employees VALUES (3, 'Robert Brown', 'HR', 65000, DATE '2021-06-10');
INSERT INTO employees VALUES (4, 'Patricia Davis', 'HR', 72000, DATE '2020-09-15');
INSERT INTO employees VALUES (5, 'Michael Wilson', 'Finance', 90000, DATE '2018-12-01');
INSERT INTO employees VALUES (6, 'Linda Jones', 'Finance', 82000, DATE '2019-08-25');
INSERT INTO employees VALUES (7, 'James Miller', 'IT', 78000, DATE '2020-04-30');
INSERT INTO employees VALUES (8, 'Elizabeth Taylor', 'HR', 68000, DATE '2021-02-14');

-- 1. ROW_NUMBER, RANK, and DENSE_RANK
-- These functions are used for ranking rows within a partition

SELECT 
    emp_name,
    department,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as row_num,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) as rank_num,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dense_rank_num
FROM employees;

-- 2. LAG and LEAD
-- These functions access data from previous or subsequent rows

SELECT 
    emp_name,
    department,
    salary,
    LAG(salary) OVER (PARTITION BY department ORDER BY hire_date) as previous_salary,
    LEAD(salary) OVER (PARTITION BY department ORDER BY hire_date) as next_salary
FROM employees;

-- 3. FIRST_VALUE and LAST_VALUE
-- Get the first and last values in a window

SELECT 
    emp_name,
    department,
    salary,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY hire_date) as first_salary,
    LAST_VALUE(salary) OVER (
        PARTITION BY department 
        ORDER BY hire_date
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
