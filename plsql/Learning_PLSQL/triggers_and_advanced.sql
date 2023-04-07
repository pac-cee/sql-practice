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
        SYS_CONTEXT('USERENV', 'SESSION_USER')
    );
END;
/

-- 1.2 Statement-Level Trigger
-- --------------------------
-- Purpose: Enforces business hours for data modifications
-- Fires: Once per SQL statement
-- Use Case: Global business rule enforcement
CREATE OR REPLACE TRIGGER trg_business_hours
    BEFORE INSERT OR UPDATE OR DELETE
    ON employees
BEGIN
    -- Check if operation is during business hours (8 AM to 6 PM)
    IF TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) NOT BETWEEN 8 AND 18 OR
       TO_CHAR(SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
        RAISE_APPLICATION_ERROR(-20100, 
            'Data modifications only allowed during business hours (Mon-Fri, 8 AM - 6 PM)');
    END IF;
END;
/

/*
Section 2: Advanced SQL Features
Purpose: Complex data analysis and manipulation
Benefits:
- Enhanced data analysis
- Improved query performance
- Complex data relationships
*/

-- 2.1 Hierarchical Queries
-- -----------------------
-- Purpose: Handle tree-structured data
-- Use Case: Organization charts, parts explosions
CREATE OR REPLACE VIEW v_emp_hierarchy AS
SELECT 
    LEVEL as hierarchy_level,
    LPAD(' ', 2 * (LEVEL-1)) || emp_name as org_chart,
    emp_id,
    manager_id,
    salary,
    CONNECT_BY_ROOT emp_name as top_manager,
    SYS_CONNECT_BY_PATH(emp_name, '/') as emp_path
FROM employees
CONNECT BY PRIOR emp_id = manager_id
START WITH manager_id IS NULL;

-- 2.2 Materialized Views
-- ---------------------
-- Purpose: Pre-computed query results
-- Benefits: 
-- - Improved performance for complex queries
-- - Data replication
-- - Distributed databases
CREATE MATERIALIZED VIEW mv_dept_summary
    REFRESH ON COMMIT
AS
SELECT 
    d.department_id,
    d.department_name,
    COUNT(*) as emp_count,
    AVG(e.salary) as avg_salary,
    MIN(e.hire_date) as earliest_hire,
    MAX(e.hire_date) as latest_hire
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- 2.3 Advanced Analytical Functions
-- ------------------------------
-- Purpose: Complex statistical analysis
-- Use Case: Business intelligence and reporting
CREATE OR REPLACE VIEW v_emp_analytics AS
SELECT 
