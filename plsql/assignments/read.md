
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
- **Real-life Application:** Ranking employees within a department can help identify 
performance levels or determine bonus distributions where ties are possible.

---

## Task 3: Identifying Top Records

**Objective:**  
Fetch the top 3 records from each category (e.g., top 3 highest salaries per department)
 while handling duplicates appropriately.

**Sample Query:**

```sql
WITH RankedEmployees AS (
    SELECT 
        employee_id,
        department,
        salary,
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
    FROM employees
)
SELECT 
    employee_id, 
    department, 
    salary
FROM RankedEmployees
WHERE rn <= 3;
```

**Explanation:**  
- **ROW_NUMBER():** Assigns a unique sequential number within each partition (department) 
ordered by salary in descending order.
- **Filtering:** Only rows where `rn` is 1, 2, or 3 (i.e., the top three) are selected.
- **Real-life Application:** Identifying the top performers or best-selling products in
 each category is common in sales, HR analytics, and performance reviews.

---

## Task 4: Finding the Earliest Records

**Objective:**  
Retrieve the first 2 records from each category based on a date column
 (e.g., the earliest join date of employees per department).

**Sample Query:**

```sql
WITH EarliestEmployees AS (
    SELECT 
        employee_id,
        department,
        join_date,
        ROW_NUMBER() OVER (PARTITION BY department ORDER BY join_date ASC) AS rn
    FROM employees
)
SELECT 
    employee_id, 
    department, 
    join_date
FROM EarliestEmployees
WHERE rn <= 2;
```

**Explanation:**  
- **ROW_NUMBER() OVER (ORDER BY join_date ASC):** Orders employees by
 their join date (earliest first) within each department.
- **Filtering:** Selects the first two records (i.e., the earliest joiners) for each department.
- **Real-life Application:** Useful for understanding which teams have the most senior employees, 
or for recognizing early contributors in an organization.

---

## Task 5: Aggregation with Window Functions

**Objective:**  
Select all records and calculate:
- The maximum value (e.g., maximum salary) within each category.
- The overall maximum value across all records.

**Sample Query:**

```sql
SELECT 
    employee_id,
    department,
    salary,
    MAX(salary) OVER (PARTITION BY department) AS max_dept_salary,
    MAX(salary) OVER () AS overall_max_salary
FROM employees;
```

**Explanation:**  
- **MAX(salary) OVER (PARTITION BY department):** Computes the maximum salary for each department.
- **MAX(salary) OVER ():** Computes the overall maximum salary from the entire table.
- **Real-life Application:** This technique is useful for comparative analytics, 
such as determining departmental salary ceilings versus the overall maximum salary in the company.

---

## Submission Guidelines Recap

1. **GitHub Repository Setup:**
   - Create a repository for your group work.
   - Use a funny group name (e.g., *ThePrimaryKeys*, *Commit_the_Query*).
   - Add the instructor (GitHub username: **ericmaniraguha**) as a collaborator.

2. **Files to Include:**
   - **SQL Scripts:** Include scripts for table creation, data insertion, 
   and the window function queries.
   - **README.md:** Provide detailed explanations, screenshots of query results, findings, 
   and real-life applications of the window functions.

3. **Deadline:**  
   - Submit the GitHub repository link by **April 17, 2025, 11:59 pm**.

4. **Next Step:**  
   - After completing this assignment, you will take a short quiz to test your understanding 
   of window functions.

---

These sample queries and detailed explanations should give you a clear roadmap for completing
 the assignment. Make sure to tailor the dataset and queries to your specific context if you 
 choose a different domain (e.g., sales, products, students). Good luck, and happy querying!




///////////////////////////////////////


Below is an example of how you can structure your GitHub repository for this assignment.
 You should include separate SQL script files for table creation, data insertion, 
 and your window function queries. In addition, include a detailed README.md file
  that explains each script, shows screenshots of query outputs, and describes your approach.

---

### Repository File Structure

```
SQL_Window_Functions_Assignment/
├── table_creation.sql
├── data_insertion.sql
├── window_functions_queries.sql
└── README.md
```

---

### table_creation.sql

```sql
-- Create the employees table
CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department VARCHAR2(50),
    salary NUMBER,
    join_date DATE
);

-- Create the allowances table (if needed for other parts)
CREATE TABLE allowances (
    allowance_id NUMBER PRIMARY KEY,
    role_id NUMBER,
    allowance_amount NUMBER,
    is_applicable CHAR(1)
);
```

---

### data_insertion.sql

```sql
-- Insert sample data into the employees table
INSERT INTO employees (employee_id, first_name, last_name, department, salary, join_date)
 VALUES (101, 'John', 'Doe', 'Sales', 45000, TO_DATE('2021-01-15', 'YYYY-MM-DD'));
INSERT INTO employees (employee_id, first_name, last_name, department, salary, join_date) 
VALUES (102, 'Jane', 'Smith', 'Sales', 55000, TO_DATE('2020-06-10', 'YYYY-MM-DD'));
INSERT INTO employees (employee_id, first_name, last_name, department, salary, join_date) 
VALUES (103, 'Alice', 'Brown', 'HR', 48000, TO_DATE('2019-03-20', 'YYYY-MM-DD'));
INSERT INTO employees (employee_id, first_name, last_name, department, salary, join_date)
 VALUES (104, 'Bob', 'White', 'HR', 60000, TO_DATE('2022-07-05', 'YYYY-MM-DD'));
INSERT INTO employees (employee_id, first_name, last_name, department, salary, join_date) 
VALUES (105, 'Charlie', 'Black', 'IT', 70000, TO_DATE('2018-11-01', 'YYYY-MM-DD'));
COMMIT;
