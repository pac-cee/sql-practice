-- 1. Basic PL/SQL Block Structure
DECLARE
    -- Declaration section
    v_name VARCHAR2(50);
    v_count NUMBER := 100;
BEGIN
    -- Executable section
    v_name := 'John Doe';
    v_count := 1000;
    DBMS_OUTPUT.PUT_LINE('Hello ' || v_name);
    DBMS_OUTPUT.PUT_LINE('HELLO' || v_count);
EXCEPTION
    -- Exception handling section
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
END;
/


-- 2. Variables and Data Types
DECLARE
    v_number NUMBER(10,2) := 123.45;
    v_text VARCHAR2(100) := 'Sample text';
    v_date DATE := SYSDATE;
    v_boolean BOOLEAN := TRUE;
    -- Constant declaration
    c_tax_rate CONSTANT NUMBER := 0.08;
    -- %TYPE attribute
    v_emp_salary employees.salary%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Number: ' || v_number);
    DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(v_date, 'DD-MON-YYYY'));
END;
/

-- 3. Control Structures
DECLARE
    v_grade CHAR(1) := 'B';
