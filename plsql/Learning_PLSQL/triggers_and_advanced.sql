-- =============================================
-- Advanced Triggers and Complex SQL Features
-- =============================================

/*
Section 1: Database Triggers
Purpose: Automatic execution of code in response to events
Benefits:
- Automatic data validation
- Audit trailing
- Event logging
- Business rule enforcement
- Maintaining derived data
*/

-- 1.1 Row-Level Trigger
-- --------------------
-- Purpose: Maintains audit trail for each row modification
-- Fires: Once for each row affected
-- Use Case: Detailed change tracking at record level
CREATE OR REPLACE TRIGGER trg_emp_audit_row
    AFTER UPDATE OF salary, department_id
    ON employees
    FOR EACH ROW
    WHEN (NEW.salary <> OLD.salary OR 
          NEW.department_id <> OLD.department_id)
DECLARE
    v_change_type VARCHAR2(100);
BEGIN
    -- Determine type of change
    v_change_type := CASE
        WHEN :NEW.salary <> :OLD.salary AND 
             :NEW.department_id <> :OLD.department_id 
        THEN 'Salary and Department'
        WHEN :NEW.salary <> :OLD.salary 
        THEN 'Salary Only'
        ELSE 'Department Only'
    END;
    
    -- Insert audit record
    INSERT INTO employee_audit (
        emp_id,
        change_date,
        change_type,
        old_salary,
        new_salary,
        old_dept_id,
        new_dept_id,
        modified_by
    ) VALUES (
        :NEW.employee_id,
        SYSDATE,
        v_change_type,
        :OLD.salary,
        :NEW.salary,
        :OLD.department_id,
        :NEW.department_id,
