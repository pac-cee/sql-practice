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
