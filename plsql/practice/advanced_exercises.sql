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
        v_years_of_service := TRUNC(MONTHS_BETWEEN(SYSDATE, emp_rec.hire_date) / 12);
        
        -- Determine raise percentage
        v_raise_percentage := 
            CASE 
                WHEN v_years_of_service >= 10 THEN 10
                WHEN v_years_of_service >= 5 THEN 7
                WHEN v_years_of_service >= 3 THEN 5
                ELSE 3
            END;
            
        -- Validate new salary
        IF emp_rec.salary * (1 + v_raise_percentage/100) > 150000 THEN
            RAISE e_invalid_salary;
        END IF;
        
        -- Update salary
        UPDATE employees
        SET salary = salary * (1 + v_raise_percentage/100)
