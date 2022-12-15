# SQL in PL/SQL

## Introduction
PL/SQL seamlessly integrates SQL statements within its procedural constructs. This integration is one of PL/SQL's most powerful features.

## 1. SELECT INTO Statement

### Single Row SELECT
```sql
DECLARE
    v_employee_name employees.first_name%TYPE;
    v_salary        employees.salary%TYPE;
BEGIN
    SELECT first_name, salary
    INTO v_employee_name, v_salary
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_employee_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Employee not found');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Multiple employees found');
END;
/
```

### Using %ROWTYPE
```sql
DECLARE
    v_emp_record employees%ROWTYPE;
BEGIN
    SELECT *
    INTO v_emp_record
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_emp_record.first_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || v_emp_record.salary);
END;
/
```

## 2. DML Operations

### INSERT Statement
```sql
DECLARE
    v_emp_id employees.employee_id%TYPE := 1000;
BEGIN
    INSERT INTO employees (
        employee_id,
        first_name,
        last_name,
        email,
        hire_date,
        job_id
    ) VALUES (
        v_emp_id,
        'John',
        'Doe',
        'JDOE',
        SYSDATE,
        'IT_PROG'
    );
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
```
