-- PL/SQL Practical Examples

-- 1. Create a simple employees table
CREATE TABLE employees (
    employee_id   NUMBER PRIMARY KEY,
    first_name    VARCHAR2(50),
    last_name     VARCHAR2(50),
    email         VARCHAR2(100),
    hire_date     DATE,
    salary        NUMBER(10,2)
);

-- 2. Procedure to add a new employee
CREATE OR REPLACE PROCEDURE add_employee(
    p_first_name IN VARCHAR2,
    p_last_name  IN VARCHAR2,
    p_email      IN VARCHAR2,
    p_salary     IN NUMBER
) IS
