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
