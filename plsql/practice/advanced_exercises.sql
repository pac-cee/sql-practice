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
        WHERE CURRENT OF emp_cursor;
        
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN e_invalid_salary THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20101, 'Salary exceeds maximum limit');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20102, 'Error: ' || SQLERRM);
END process_service_based_raises;
/

/*
Exercise 2: Package for Department Statistics
Create a package that manages department statistics with multiple functions and procedures.
*/
CREATE OR REPLACE PACKAGE dept_stats AS
    -- Get department average salary
    FUNCTION get_dept_avg_salary(p_dept_id NUMBER) RETURN NUMBER;
    
    -- Get department headcount
    FUNCTION get_dept_headcount(p_dept_id NUMBER) RETURN NUMBER;
    
    -- Get department performance summary
    PROCEDURE get_dept_performance_summary(
        p_dept_id IN NUMBER,
        p_avg_rating OUT NUMBER,
        p_top_performers OUT NUMBER,
        p_needs_improvement OUT NUMBER
    );
    
    -- Generate department report
    PROCEDURE generate_dept_report(p_dept_id IN NUMBER);
END dept_stats;
/

CREATE OR REPLACE PACKAGE BODY dept_stats AS
    -- Get department average salary
    FUNCTION get_dept_avg_salary(p_dept_id NUMBER) RETURN NUMBER IS
        v_avg_salary NUMBER;
    BEGIN
        SELECT AVG(salary)
        INTO v_avg_salary
        FROM employees
        WHERE department_id = p_dept_id;
        
        RETURN v_avg_salary;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END get_dept_avg_salary;
    
    -- Get department headcount
    FUNCTION get_dept_headcount(p_dept_id NUMBER) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM employees
        WHERE department_id = p_dept_id;
        
        RETURN v_count;
    END get_dept_headcount;
    
    -- Get department performance summary
    PROCEDURE get_dept_performance_summary(
        p_dept_id IN NUMBER,
        p_avg_rating OUT NUMBER,
        p_top_performers OUT NUMBER,
        p_needs_improvement OUT NUMBER
    ) IS
    BEGIN
        -- Get average rating (A=4, B=3, C=2, D=1)
        SELECT AVG(CASE rating
                    WHEN 'A' THEN 4
                    WHEN 'B' THEN 3
                    WHEN 'C' THEN 2
                    WHEN 'D' THEN 1
                END)
        INTO p_avg_rating
        FROM employees e
        JOIN performance_ratings pr ON e.employee_id = pr.employee_id
        WHERE e.department_id = p_dept_id
        AND pr.rating_date = (
            SELECT MAX(rating_date)
            FROM performance_ratings
            WHERE employee_id = e.employee_id
        );
        
        -- Get count of top performers (A rating)
        SELECT COUNT(*)
        INTO p_top_performers
        FROM employees e
