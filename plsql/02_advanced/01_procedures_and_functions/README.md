# PL/SQL Procedures and Functions

## Introduction
Procedures and functions are named PL/SQL blocks that can be stored in the database and reused. They are the building blocks of modular PL/SQL programming.

## 1. Procedures

### Basic Procedure Structure
```sql
CREATE OR REPLACE PROCEDURE procedure_name 
    (parameter1 IN|OUT|IN OUT datatype,
     parameter2 IN|OUT|IN OUT datatype,
     ...)
IS|AS
    -- Declaration section
BEGIN
    -- Executable section
EXCEPTION
    -- Exception section
END procedure_name;
/
```

### Simple Procedure Example
```sql
CREATE OR REPLACE PROCEDURE update_salary
    (p_employee_id IN employees.employee_id%TYPE,
     p_increase_percent IN NUMBER)
IS
BEGIN
    UPDATE employees
    SET salary = salary * (1 + p_increase_percent/100)
    WHERE employee_id = p_employee_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Employee not found');
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END update_salary;
/
```

### Procedure with OUT Parameter
```sql
CREATE OR REPLACE PROCEDURE get_employee_info
    (p_employee_id IN employees.employee_id%TYPE,
     p_name OUT VARCHAR2,
     p_salary OUT NUMBER)
IS
BEGIN
    SELECT first_name || ' ' || last_name, salary
    INTO p_name, p_salary
    FROM employees
    WHERE employee_id = p_employee_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Employee not found');
END get_employee_info;
/
```

## 2. Functions

### Basic Function Structure
```sql
CREATE OR REPLACE FUNCTION function_name
    (parameter1 datatype,
     parameter2 datatype,
     ...)
RETURN return_datatype
IS|AS
    -- Declaration section
BEGIN
    -- Executable section
    RETURN value;
EXCEPTION
    -- Exception section
END function_name;
/
```

### Simple Function Example
```sql
CREATE OR REPLACE FUNCTION calculate_bonus
    (p_salary IN NUMBER,
     p_performance_rating IN VARCHAR2)
RETURN NUMBER
IS
    v_bonus_percent NUMBER;
BEGIN
    v_bonus_percent := CASE p_performance_rating
        WHEN 'A' THEN 20
        WHEN 'B' THEN 15
        WHEN 'C' THEN 10
        ELSE 5
    END;
    
    RETURN (p_salary * v_bonus_percent/100);
END calculate_bonus;
/
```

### Function with Complex Logic
```sql
CREATE OR REPLACE FUNCTION get_employee_level
    (p_employee_id IN employees.employee_id%TYPE)
RETURN VARCHAR2
IS
    v_salary employees.salary%TYPE;
    v_years_of_service NUMBER;
BEGIN
    SELECT salary, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12)
    INTO v_salary, v_years_of_service
    FROM employees
    WHERE employee_id = p_employee_id;
    
    RETURN CASE
        WHEN v_salary > 20000 OR v_years_of_service > 10 THEN 'SENIOR'
        WHEN v_salary > 10000 OR v_years_of_service > 5 THEN 'MID'
        ELSE 'JUNIOR'
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END get_employee_level;
/
```

## 3. Using Procedures and Functions

### Calling a Procedure
```sql
-- Method 1: Anonymous block
BEGIN
    update_salary(100, 10);  -- Give employee 100 a 10% raise
END;
/

-- Method 2: EXECUTE statement
EXECUTE update_salary(100, 10);

-- Method 3: With OUT parameters
DECLARE
    v_name VARCHAR2(100);
    v_salary NUMBER;
BEGIN
    get_employee_info(100, v_name, v_salary);
