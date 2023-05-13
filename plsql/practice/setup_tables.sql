-- Create sequence for employee IDs
CREATE SEQUENCE emp_id_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Create departments table
CREATE TABLE departments (
    department_id   NUMBER PRIMARY KEY,
    department_name VARCHAR2(50) NOT NULL,
    location       VARCHAR2(50),
    manager_id     NUMBER
);

-- Create employees table
CREATE TABLE employees (
    employee_id    NUMBER PRIMARY KEY,
    first_name     VARCHAR2(50) NOT NULL,
