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
