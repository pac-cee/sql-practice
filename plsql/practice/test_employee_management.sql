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
        p_department_id => 10,
        p_job_title => 'Software Engineer',
        p_salary => 75000,
        p_manager_id => NULL,
        p_employee_id => v_emp_id
    );
    DBMS_OUTPUT.PUT_LINE('Added employee with ID: ' || v_emp_id);
    
    -- Test 2: Add performance rating
    DBMS_OUTPUT.PUT_LINE('Test 2: Adding performance rating');
    emp_mgmt.add_performance_rating(
        p_employee_id => v_emp_id,
        p_rating => 'A',
        p_comments => 'Excellent performance in first quarter'
    );
    DBMS_OUTPUT.PUT_LINE('Added performance rating');
    
    -- Test 3: Update salary
    DBMS_OUTPUT.PUT_LINE('Test 3: Updating salary');
