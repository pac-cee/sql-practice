
## Overview

**Assignment Objective:**  
Work with SQL window functions on a dataset (e.g., an employees table).
 You will use functions such as LAG(), LEAD(), RANK(), DENSE_RANK(), ROW_NUMBER(), 
 and aggregate functions with PARTITION BY. In addition to writing the queries, 
 you must explain your logic, provide real-life applications, and document your work properly.

**Teamwork & Submission:**  
- Work in pairs and create a GitHub repository (with a funny name like *ThePrimaryKeys* 
or *Commit_the_Query*).  
- Both team members must contribute, and the instructor (GitHub username: **ericmaniraguha**)
 must be added as a collaborator.  
- Push all SQL scripts (table creation, data insertion, queries) and a README with explanations
 and screenshots.  


---

## Task 1: Compare Values with Previous or Next Records

**Objective:**  
Compare a numeric column (e.g., salary) with its previous (or next) value and display
 if it is **HIGHER**, **LOWER**, or **EQUAL** compared to the previous record.

**Sample Query:**

```sql
SELECT 
    employee_id,
    salary,
    LAG(salary) OVER (ORDER BY salary) AS previous_salary,
    CASE 
        WHEN salary > LAG(salary) OVER (ORDER BY salary) THEN 'HIGHER'
        WHEN salary < LAG(salary) OVER (ORDER BY salary) THEN 'LOWER'
        ELSE 'EQUAL'
    END AS comparison_with_previous,
