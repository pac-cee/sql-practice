-- Enable server output
SET SERVEROUTPUT ON;

DECLARE
    -- Variables for employee management
    v_emp_id NUMBER;
    v_old_salary NUMBER;
    v_name VARCHAR2(100);
    v_department VARCHAR2(50);
    v_salary NUMBER;
    v_rating CHAR;
    v_bonus NUMBER;
BEGIN
    -- Test 1: Add new employee
    DBMS_OUTPUT.PUT_LINE('Test 1: Adding new employee');
    emp_mgmt.add_employee(
        p_first_name => 'John',
        p_last_name => 'Doe',
        p_email => 'john.doe@example.com',
