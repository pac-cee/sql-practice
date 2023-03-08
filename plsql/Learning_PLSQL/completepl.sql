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


