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
