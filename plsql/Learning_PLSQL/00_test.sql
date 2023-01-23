-- 1. DDL (Data Definition Language)
alter session set container = PACIFIQUE;
-- CREATE commands
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    salary NUMBER(10,2),
    hire_date DATE DEFAULT SYSDATE
);

select * from employees;
drop table employees;

-- ALTER commands
ALTER TABLE employees ADD (department VARCHAR2(50));
ALTER TABLE employees MODIFY (name VARCHAR2(150));
ALTER TABLE employees DROP COLUMN department;
ALTER TABLE employees RENAME COLUMN name TO full_name;

-- DROP commands
DROP TABLE employees;
DROP VIEW emp_view;
DROP SEQUENCE emp_seq;

-- TRUNCATE command
TRUNCATE TABLE employees;

-- RENAME command
ALTER TABLE employees RENAME TO staff;
/





2. DML (Data Manipulation Language)

-- INSERT commands
INSERT INTO employees (emp_id, name, salary) 
VALUES (1, 'John Doe', 50000);

INSERT INTO employees 
SELECT * FROM old_employees;

-- UPDATE commands
UPDATE employees 
SET salary = salary * 1.1
WHERE department = 'IT';

-- DELETE commands
DELETE FROM employees 
WHERE salary < 30000;

-- MERGE command
MERGE INTO target_table t
USING source_table s
ON (t.id = s.id)
