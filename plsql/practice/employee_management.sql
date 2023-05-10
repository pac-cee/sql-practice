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
