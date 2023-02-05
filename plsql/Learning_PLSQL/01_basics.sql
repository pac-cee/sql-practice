-- Oracle PL/SQL

-- PL/SQL Basics Tutorial

/*
PL/SQL is Oracle's procedural extension to SQL.
It combines the data manipulation power of SQL with procedural features.
*/

-- 1. Basic Block Structure
DECLARE
    -- Declaration section (optional)
    v_message VARCHAR2(100) := 'Hello, PL/SQL!';
    v_number NUMBER := 42;
BEGIN
    -- Executable section (required)
    DBMS_OUTPUT.PUT_LINE(v_message);
    DBMS_OUTPUT.PUT_LINE('The number is: ' || v_number);
EXCEPTION
