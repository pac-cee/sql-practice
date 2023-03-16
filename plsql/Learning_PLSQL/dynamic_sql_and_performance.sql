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
