-- Package specification
CREATE OR REPLACE PACKAGE emp_mgmt AS
    -- Add a new employee
    PROCEDURE add_employee(
        p_first_name    IN VARCHAR2,
        p_last_name     IN VARCHAR2,
        p_email         IN VARCHAR2,
        p_department_id IN NUMBER,
        p_job_title     IN VARCHAR2,
        p_salary        IN NUMBER,
        p_manager_id    IN NUMBER,
        p_employee_id   OUT NUMBER
    );
    
    -- Update employee salary
    PROCEDURE update_salary(
        p_employee_id      IN NUMBER,
        p_new_salary      IN NUMBER,
        p_reason          IN VARCHAR2,
        p_old_salary      OUT NUMBER
    );
    
    -- Transfer employee to new department
    PROCEDURE transfer_employee(
        p_employee_id   IN NUMBER,
        p_new_dept_id   IN NUMBER,
        p_new_job_title IN VARCHAR2 DEFAULT NULL
    );
    
    -- Add performance rating
    PROCEDURE add_performance_rating(
        p_employee_id IN NUMBER,
        p_rating      IN CHAR,
        p_comments    IN VARCHAR2
    );
    
    -- Calculate bonus based on performance
    FUNCTION calculate_bonus(
        p_employee_id IN NUMBER
    ) RETURN NUMBER;
    
    -- Get employee details
    PROCEDURE get_employee_details(
        p_employee_id IN NUMBER,
        p_name        OUT VARCHAR2,
        p_department  OUT VARCHAR2,
        p_salary      OUT NUMBER,
        p_rating      OUT CHAR
    );
END emp_mgmt;
/

-- Package body
CREATE OR REPLACE PACKAGE BODY emp_mgmt AS
    -- Add a new employee
    PROCEDURE add_employee(
        p_first_name    IN VARCHAR2,
        p_last_name     IN VARCHAR2,
        p_email         IN VARCHAR2,
        p_department_id IN NUMBER,
        p_job_title     IN VARCHAR2,
        p_salary        IN NUMBER,
        p_manager_id    IN NUMBER,
        p_employee_id   OUT NUMBER
    ) IS
    BEGIN
        -- Get new employee ID from sequence
        SELECT emp_id_seq.NEXTVAL INTO p_employee_id FROM DUAL;
        
        -- Insert new employee
        INSERT INTO employees (
            employee_id, first_name, last_name, email,
            department_id, job_title, salary, manager_id
        ) VALUES (
            p_employee_id, p_first_name, p_last_name, p_email,
            p_department_id, p_job_title, p_salary, p_manager_id
        );
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001, 'Error adding employee: ' || SQLERRM);
    END add_employee;
    
    -- Update employee salary
    PROCEDURE update_salary(
        p_employee_id   IN NUMBER,
        p_new_salary   IN NUMBER,
        p_reason       IN VARCHAR2,
        p_old_salary   OUT NUMBER
    ) IS
        v_history_id NUMBER;
    BEGIN
        -- Get current salary
        SELECT salary INTO p_old_salary
        FROM employees
        WHERE employee_id = p_employee_id;
        
        -- Update salary
        UPDATE employees
        SET salary = p_new_salary
        WHERE employee_id = p_employee_id;
        
        -- Record in salary history
        SELECT NVL(MAX(history_id), 0) + 1 INTO v_history_id
        FROM salary_history;
        
        INSERT INTO salary_history (
            history_id, employee_id, old_salary, new_salary, reason
        ) VALUES (
            v_history_id, p_employee_id, p_old_salary, p_new_salary, p_reason
        );
        
        COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20002, 'Employee not found');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20003, 'Error updating salary: ' || SQLERRM);
    END update_salary;
    
    -- Transfer employee
    PROCEDURE transfer_employee(
        p_employee_id   IN NUMBER,
        p_new_dept_id   IN NUMBER,
        p_new_job_title IN VARCHAR2 DEFAULT NULL
    ) IS
        v_old_dept_id NUMBER;
    BEGIN
        -- Get current department
        SELECT department_id INTO v_old_dept_id
        FROM employees
        WHERE employee_id = p_employee_id;
        
        -- Update employee
        UPDATE employees
        SET department_id = p_new_dept_id,
            job_title = NVL(p_new_job_title, job_title)
        WHERE employee_id = p_employee_id;
        
        COMMIT;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20004, 'Employee not found');
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20005, 'Error transferring employee: ' || SQLERRM);
    END transfer_employee;
