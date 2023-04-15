-- PL/SQL Blocks and Procedures using Window Functions

-- 1. Procedure to calculate employee rankings within departments
CREATE OR REPLACE PROCEDURE calculate_dept_rankings AS
BEGIN
    -- Create a temporary table to store rankings
    EXECUTE IMMEDIATE 'CREATE GLOBAL TEMPORARY TABLE emp_rankings (
        emp_id NUMBER,
        first_name VARCHAR2(50),
        department VARCHAR2(50),
        salary NUMBER,
        dept_rank NUMBER,
        overall_rank NUMBER
    ) ON COMMIT PRESERVE ROWS';
    
    -- Insert data with rankings
    INSERT INTO emp_rankings
    SELECT 
        emp_id,
        first_name,
        department,
        salary,
        RANK() OVER (PARTITION BY department ORDER BY salary DESC) as dept_rank,
        RANK() OVER (ORDER BY salary DESC) as overall_rank
    FROM employees;
    
    -- Print results
    FOR r IN (SELECT * FROM emp_rankings ORDER BY department, dept_rank) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Employee: ' || r.first_name ||
            ' | Department: ' || r.department ||
            ' | Dept Rank: ' || r.dept_rank ||
            ' | Overall Rank: ' || r.overall_rank
        );
    END LOOP;
    
    -- Clean up
    EXECUTE IMMEDIATE 'DROP TABLE emp_rankings';
