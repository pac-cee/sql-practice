
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
    LEAD(salary) OVER (ORDER BY salary) AS next_salary
FROM employees;
```

**Explanation:**  
- **LAG(salary):** Retrieves the salary from the previous row when sorted by salary.
- **LEAD(salary):** Retrieves the salary from the next row.
- **CASE Statement:** Compares the current salary with the previous salary and categorizes 
it as *HIGHER*, *LOWER*, or *EQUAL*.
- **Real-life Application:** Useful in financial reporting to track incremental changes in 
salaries, sales figures, or performance metrics.

---

## Task 2: Ranking Data within a Category

**Objective:**  
Rank records within a category (e.g., ranking employees by salary within each department) 
using both **RANK()** and **DENSE_RANK()**, and explain the difference.

**Sample Query:**

```sql
SELECT 
    employee_id,
    department,
    salary,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_salary_rank
FROM employees;
```

**Explanation:**  
- **RANK() vs. DENSE_RANK():**
  - *RANK():* Assigns the same rank to ties but leaves gaps in ranking. For example,
   if two employees tie for 1st, the next rank will be 3.
  - *DENSE_RANK():* Also assigns the same rank for ties but does not leave gaps (i.e.,
   the next rank is 2).
