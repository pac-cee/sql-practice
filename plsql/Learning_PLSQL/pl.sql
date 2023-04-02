-- PL/SQL Tutorial

-- 1. Basic Block Structure
DECLARE
    -- Declaration section (optional)
    v_message VARCHAR2(100) := 'Hello, PL/SQL!';
BEGIN
    -- Executable section (required)
    DBMS_OUTPUT.PUT_LINE(v_message);
EXCEPTION
    -- Exception section (optional)
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred!');
END;
/

-- 2. Variables and Data Types
DECLARE
    v_number        NUMBER(10,2) := 123.45;        -- Numeric with 10 digits, 2 decimal places
    v_integer       PLS_INTEGER := 42;             -- Integer (faster than NUMBER for integers)
    v_text         VARCHAR2(100) := 'Some text';   -- Variable-length string
    v_date         DATE := SYSDATE;                -- Current date and time
    v_boolean      BOOLEAN := TRUE;                -- Boolean (can be TRUE, FALSE, or NULL)
    v_character    CHAR(10) := 'Fixed     ';       -- Fixed-length string
BEGIN
    DBMS_OUTPUT.PUT_LINE('Number: ' || v_number);
    DBMS_OUTPUT.PUT_LINE('Integer: ' || v_integer);
    DBMS_OUTPUT.PUT_LINE('Text: ' || v_text);
    DBMS_OUTPUT.PUT_LINE('Date: ' || v_date);
    DBMS_OUTPUT.PUT_LINE('Boolean: ' || v_boolean);
    DBMS_OUTPUT.PUT_LINE('Character: ' || v_character);
END;
/

-- 3. Operators
DECLARE
    v_num1 NUMBER := 10;
    v_num2 NUMBER := 20;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Addition: ' || (v_num1 + v_num2));
    DBMS_OUTPUT.PUT_LINE('Subtraction: ' || (v_num1 - v_num2));
    DBMS_OUTPUT.PUT_LINE('Multiplication: ' || (v_num1 * v_num2));
    DBMS_OUTPUT.PUT_LINE('Division: ' || (v_num1 / v_num2));
    DBMS_OUTPUT.PUT_LINE('Modulus: ' || MOD(v_num1, v_num2));
END;
/

-- 4. Control Statements
DECLARE
    v_num NUMBER := 5;
BEGIN
    IF v_num = 5 THEN
        DBMS_OUTPUT.PUT_LINE('v_num is 5');
    ELSIF v_num = 10 THEN
        DBMS_OUTPUT.PUT_LINE('v_num is 10');
    ELSE
        DBMS_OUTPUT.PUT_LINE('v_num is not 5 or 10');
