-- Create the customers table
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    phone VARCHAR2(20),
    address VARCHAR2(200),
    city VARCHAR2(50),
    state VARCHAR2(2),
    zip_code VARCHAR2(10),
    registration_date DATE DEFAULT SYSDATE,
    credit_limit NUMBER(10,2),
    status VARCHAR2(10) CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- Create a sequence for customer_id
CREATE SEQUENCE customer_seq
    START WITH 1
