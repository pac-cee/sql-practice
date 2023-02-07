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
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error adding employee: ' || SQLERRM);
END;
/

-- 3. Function to calculate annual salary with bonus
CREATE OR REPLACE FUNCTION calculate_annual_salary(
    p_employee_id IN NUMBER,
    p_bonus_percent IN NUMBER DEFAULT 10
) RETURN NUMBER IS
    v_annual_salary NUMBER;
    v_monthly_salary NUMBER;
BEGIN
    -- Get employee's monthly salary
    SELECT salary
    INTO v_monthly_salary
    FROM employees
    WHERE employee_id = p_employee_id;
    
    -- Calculate annual salary with bonus
    v_annual_salary := (v_monthly_salary * 12) * (1 + p_bonus_percent/100);
    
    RETURN v_annual_salary;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
    WHEN OTHERS THEN
        RETURN NULL;
END;
/

-- 4. Procedure to give salary raises
CREATE OR REPLACE PROCEDURE give_salary_raise(
    p_min_salary IN NUMBER,
    p_raise_percent IN NUMBER
) IS
    v_employees_updated NUMBER := 0;
BEGIN
    -- Update salaries
    UPDATE employees
    SET salary = salary * (1 + p_raise_percent/100)
    WHERE salary <= p_min_salary;
    
    v_employees_updated := SQL%ROWCOUNT;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(v_employees_updated || ' employees received a raise.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error giving raises: ' || SQLERRM);
END;
/

-- 5. Example usage of the above objects
BEGIN
