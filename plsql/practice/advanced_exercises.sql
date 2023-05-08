-- Advanced PL/SQL Practice Exercises

/*
Exercise 1: Cursor and Exception Handling
Create a procedure that gives salary raises based on years of service.
Use cursors to process employees and handle various exceptions.
*/
CREATE OR REPLACE PROCEDURE process_service_based_raises AS
    CURSOR emp_cursor IS
        SELECT employee_id, salary, hire_date
        FROM employees
        FOR UPDATE OF salary;
        
    v_years_of_service NUMBER;
    v_raise_percentage NUMBER;
    e_invalid_salary EXCEPTION;
BEGIN
    FOR emp_rec IN emp_cursor LOOP
        -- Calculate years of service
