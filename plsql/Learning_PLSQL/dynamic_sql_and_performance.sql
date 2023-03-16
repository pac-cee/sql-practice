-- =============================================
-- Dynamic SQL and Performance Optimization
-- =============================================

/*
Section 1: Dynamic SQL
Purpose: Execute SQL statements constructed at runtime
Benefits:
- Flexible query construction
- Reusable code
- Dynamic object names
- Runtime binding
*/

-- 1.1 Basic Dynamic SQL
-- --------------------
-- Purpose: Demonstrate simple dynamic SQL execution
-- Use Case: Generic queries with variable table names
CREATE OR REPLACE PROCEDURE dynamic_query(
    p_table_name IN VARCHAR2,
    p_where_clause IN VARCHAR2 DEFAULT NULL
) IS
    v_sql VARCHAR2(4000);
    v_columns VARCHAR2(4000);
    TYPE t_refcursor IS REF CURSOR;
    v_result_set t_refcursor;
    v_column_value VARCHAR2(4000);
BEGIN
    -- Get column list dynamically
    SELECT LISTAGG(column_name, ',') WITHIN GROUP (ORDER BY column_id)
    INTO v_columns
    FROM user_tab_columns
    WHERE table_name = UPPER(p_table_name);
    
    -- Construct SQL dynamically
    v_sql := 'SELECT ' || v_columns || ' FROM ' || p_table_name;
    IF p_where_clause IS NOT NULL THEN
        v_sql := v_sql || ' WHERE ' || p_where_clause;
    END IF;
    
    -- Execute and process results
    DBMS_OUTPUT.PUT_LINE('Executing: ' || v_sql);
    
    -- Log execution plan for performance monitoring
    execute_with_plan(v_sql);
END;
/

-- 1.2 Advanced Dynamic PL/SQL
-- --------------------------
-- Purpose: Dynamic PL/SQL block execution
-- Use Case: Flexible procedure calls and business logic
CREATE OR REPLACE PROCEDURE execute_dynamic_plsql(
    p_proc_name IN VARCHAR2,
    p_params IN VARCHAR2
) IS
    v_plsql_block VARCHAR2(32767);
    v_param_list VARCHAR2(4000);
BEGIN
    -- Build parameter list
    SELECT LISTAGG(param_name || ' => ' || param_value, ', ')
    INTO v_param_list
    FROM table(parse_params(p_params));
    
    -- Construct PL/SQL block
    v_plsql_block := '
    DECLARE
        -- Runtime variable declarations
        v_start_time TIMESTAMP := SYSTIMESTAMP;
    BEGIN
        -- Execute procedure with parameters
        ' || p_proc_name || '(' || v_param_list || ');
        
        -- Log execution time
        log_execution_time(
            ''' || p_proc_name || ''',
