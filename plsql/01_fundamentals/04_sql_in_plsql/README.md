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

### UPDATE Statement
```sql
DECLARE
    v_salary_increase NUMBER := 1000;
BEGIN
    UPDATE employees
    SET salary = salary + v_salary_increase
    WHERE department_id = 60;
    
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employees updated');
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('No employees updated');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
```

### DELETE Statement
```sql
DECLARE
    v_dept_id departments.department_id%TYPE := 10;
BEGIN
    DELETE FROM employees
    WHERE department_id = v_dept_id;
    
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employees deleted');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
```

## 3. Transaction Control

### SAVEPOINT Example
```sql
DECLARE
    v_emp_id employees.employee_id%TYPE := 100;
BEGIN
    -- First update
    UPDATE employees
    SET salary = salary * 1.1
    WHERE employee_id = v_emp_id;
    
    SAVEPOINT salary_update;
    
    -- Second update
    UPDATE employees
    SET commission_pct = commission_pct * 1.1
    WHERE employee_id = v_emp_id;
    
    IF SQL%ROWCOUNT = 0 THEN
        ROLLBACK TO salary_update;
    ELSE
        COMMIT;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
```

## 4. SQL Cursor Attributes

```sql
DECLARE
    v_salary employees.salary%TYPE;
BEGIN
    UPDATE employees
    SET salary = salary * 1.1
    WHERE department_id = 60;
    
    DBMS_OUTPUT.PUT_LINE('SQL%ROWCOUNT: ' || SQL%ROWCOUNT);
    DBMS_OUTPUT.PUT_LINE('SQL%FOUND: ' || CASE WHEN SQL%FOUND THEN 'TRUE' ELSE 'FALSE' END);
    DBMS_OUTPUT.PUT_LINE('SQL%NOTFOUND: ' || CASE WHEN SQL%NOTFOUND THEN 'TRUE' ELSE 'FALSE' END);
    
    COMMIT;
END;
/
```

## Practice Exercises

