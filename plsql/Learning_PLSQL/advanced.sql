-- PL/SQL Advanced Concepts

-- 1. Procedures
-- Procedures are subprograms that perform specific actions
CREATE OR REPLACE PROCEDURE greet_user(p_name IN VARCHAR2) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, ' || p_name || '!');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in greet_user: ' || SQLERRM);
END;
/

-- Execute the procedure
BEGIN
    greet_user('John');
END;

-- Example 1: Simple Procedure to Display a Message
CREATE OR REPLACE PROCEDURE greet_user (p_username VARCHAR2) AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Hello, ' || p_username || '!');
END;
/

-- Calling the procedure:
BEGIN
  greet_user('Alice');
END;
/

-- Example 2: Procedure with IN, OUT, and IN OUT parameters
CREATE OR REPLACE PROCEDURE calculate_area (
  p_radius IN NUMBER,
  p_area OUT NUMBER,
  p_circumference OUT NUMBER
) AS
  pi CONSTANT NUMBER := 3.14159;
