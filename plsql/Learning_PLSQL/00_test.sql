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

