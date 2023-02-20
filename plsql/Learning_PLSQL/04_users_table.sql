-- Enable server output
SET SERVEROUTPUT ON;

-- Drop table if it exists
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

-- Create a sequence for user_id
CREATE SEQUENCE user_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
/

-- Create the users table with various data types and constraints
CREATE TABLE users (
    user_id         NUMBER DEFAULT user_seq.NEXTVAL PRIMARY KEY,
    username        VARCHAR2(50) NOT NULL UNIQUE,
    password_hash   VARCHAR2(64) NOT NULL,  -- For storing hashed passwords
    email           VARCHAR2(100) NOT NULL UNIQUE,
    first_name      VARCHAR2(50),
    last_name       VARCHAR2(50),
    date_of_birth   DATE,
    phone_number    VARCHAR2(20),
    status          VARCHAR2(20) DEFAULT 'ACTIVE' 
                    CHECK (status IN ('ACTIVE', 'INACTIVE', 'SUSPENDED')),
    created_at      TIMESTAMP DEFAULT SYSTIMESTAMP,
    last_login      TIMESTAMP,
    login_attempts  NUMBER(2) DEFAULT 0,
    is_admin        NUMBER(1) DEFAULT 0 CHECK (is_admin IN (0,1))
);

-- Create a procedure to add new users
CREATE OR REPLACE PROCEDURE add_user(
    p_username      IN VARCHAR2,
    p_password_hash IN VARCHAR2,
    p_email        IN VARCHAR2,
    p_first_name   IN VARCHAR2,
    p_last_name    IN VARCHAR2,
    p_date_of_birth IN DATE,
    p_phone_number IN VARCHAR2
) IS
BEGIN
    INSERT INTO users (
        username, password_hash, email, first_name, 
        last_name, date_of_birth, phone_number
    ) VALUES (
        p_username, p_password_hash, p_email, p_first_name,
        p_last_name, p_date_of_birth, p_phone_number
    );
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('User ' || p_username || ' added successfully!');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Username or email already exists!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

-- Insert some sample users
BEGIN
    -- Admin user
    add_user(
        'admin',
        'hashed_password_123',
        'admin@example.com',
        'System',
        'Administrator',
        TO_DATE('1990-01-01', 'YYYY-MM-DD'),
        '+1234567890'
    );
    
    -- Regular users
    add_user(
        'john_doe',
        'hashed_password_456',
        'john.doe@example.com',
        'John',
        'Doe',
        TO_DATE('1995-05-15', 'YYYY-MM-DD'),
        '+1987654321'
    );
    
    add_user(
