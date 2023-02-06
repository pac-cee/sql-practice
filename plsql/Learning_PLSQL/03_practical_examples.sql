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
    v_employee_id NUMBER;
BEGIN
    -- Get next employee ID
    SELECT NVL(MAX(employee_id), 0) + 1
    INTO v_employee_id
    FROM employees;
    
    -- Insert new employee
    INSERT INTO employees (
        employee_id, first_name, last_name, 
        email, hire_date, salary
    ) VALUES (
        v_employee_id, p_first_name, p_last_name,
        p_email, SYSDATE, p_salary
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Employee added successfully. ID: ' || v_employee_id);
EXCEPTION
