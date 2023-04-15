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
END;
/

-- 2. Function to calculate moving average of sales
CREATE OR REPLACE FUNCTION get_sales_moving_avg(
    p_days_window IN NUMBER
) RETURN SYS_REFCURSOR AS
    v_result SYS_REFCURSOR;
BEGIN
    OPEN v_result FOR
        SELECT 
            sale_date,
            sale_amount,
            ROUND(AVG(sale_amount) OVER (
                ORDER BY sale_date 
                ROWS BETWEEN p_days_window-1 PRECEDING AND CURRENT ROW
            ), 2) as moving_avg
        FROM sales
        ORDER BY sale_date;
    
    RETURN v_result;
END;
/

-- 3. Procedure to identify top performers in each department
CREATE OR REPLACE PROCEDURE identify_top_performers(
    p_top_n IN NUMBER
) AS
BEGIN
    FOR r IN (
        SELECT *
        FROM (
            SELECT 
                first_name,
                department,
                salary,
                ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) as dept_rank
            FROM employees
