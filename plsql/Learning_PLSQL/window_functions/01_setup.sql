-- Common setup for all database systems (Oracle, PostgreSQL, MySQL)

-- Create a sample employees table
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department VARCHAR2(50),
    salary NUMBER,
    hire_date DATE
);

-- Create a sales table
CREATE TABLE sales (
    sale_id NUMBER PRIMARY KEY,
    emp_id NUMBER,
    sale_date DATE,
    sale_amount NUMBER,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
