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
