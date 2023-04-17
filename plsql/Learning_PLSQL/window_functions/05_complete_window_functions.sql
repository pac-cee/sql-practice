-- Complete Window Functions Reference Guide
-- This file covers ALL window functions with examples for Oracle, PostgreSQL, and MySQL

/*
SECTION 1: RANKING FUNCTIONS
- ROW_NUMBER(): Assigns unique sequential numbers
- RANK(): Assigns ranks with gaps for ties
- DENSE_RANK(): Assigns ranks without gaps
- NTILE(): Divides rows into N groups
*/

-- 1.1 Comparison of all ranking functions
SELECT 
    first_name,
    department,
    salary,
    ROW_NUMBER() OVER (ORDER BY salary DESC) as row_num,
    RANK() OVER (ORDER BY salary DESC) as rank_with_gaps,
    DENSE_RANK() OVER (ORDER BY salary DESC) as rank_no_gaps,
