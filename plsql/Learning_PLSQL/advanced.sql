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
BEGIN
  p_area := pi * p_radius * p_radius;
  p_circumference := 2 * pi * p_radius;
END;
/

-- Calling the procedure:
DECLARE               
  v_radius NUMBER := 5;
  v_area NUMBER;
  v_circumference NUMBER;
BEGIN
  calculate_area(v_radius, v_area, v_circumference);
  DBMS_OUTPUT.PUT_LINE('Area: ' || v_area);
  DBMS_OUTPUT.PUT_LINE('Circumference: ' || v_circumference);
END;
/

-- Example 3: Procedure with exception handling
CREATE OR REPLACE PROCEDURE divide_numbers (
  p_numerator NUMBER,
  p_denominator NUMBER,
  p_result OUT NUMBER
) AS
BEGIN
  IF p_denominator = 0 THEN
    RAISE ZERO_DIVIDE;
  END IF;
  p_result := p_numerator / p_denominator;
EXCEPTION
  WHEN ZERO_DIVIDE THEN
    DBMS_OUTPUT.PUT_LINE('Error: Division by zero.');
    p_result := NULL;
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('An unexpected error occurred.');
    p_result := NULL;
END;
/
