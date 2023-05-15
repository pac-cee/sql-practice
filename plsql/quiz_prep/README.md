# Comprehensive PL/SQL Concepts Guide

This guide is designed to help you not only ace your quiz but also become proficient in PL/SQL for real-world database development and administration. Each section covers:
- In-depth explanations
- Syntax and structure
- Real-world best practices
- Advanced tips
- Practical code examples
- Common pitfalls and troubleshooting

**Covered Topics:**
- Windows Functions
- Cursors
- Functions
- Triggers
- Packages

---

## 1. Windows Functions (Analytic Functions)

### What Are Windows Functions?
Windows (analytic) functions allow you to perform calculations across rows that are related to the current row, without collapsing the result set like GROUP BY. They are powerful for analytics, reporting, and complex data analysis.

### Syntax
```sql
function_name([arguments]) OVER (
    [PARTITION BY expr_list]
    [ORDER BY expr_list]
    [ROWS | RANGE window_frame]
)
```

- **PARTITION BY**: Divides the result set into partitions to which the function is applied.
- **ORDER BY**: Defines the logical order of rows within each partition.
- **ROWS | RANGE**: Specifies the window frame (e.g., current row, preceding/following rows).

### Common Analytic Functions
- `ROW_NUMBER()`: Assigns a unique number to each row.
- `RANK()`, `DENSE_RANK()`: Ranking rows based on a value.
- `SUM()`, `AVG()`, `COUNT()`: Aggregates over a window.
- `LEAD()`, `LAG()`: Access data from subsequent or previous rows.

### Real-World Example
**Find the top 3 earners in each department:**
```sql
SELECT department_id, employee_id, salary,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_salary_rank
FROM employees
WHERE dept_salary_rank <= 3;
```

**Calculate running totals:**
```sql
SELECT employee_id, salary,
       SUM(salary) OVER (ORDER BY hire_date) AS running_total
FROM employees;
```

### Best Practices
- Use window functions for analytics, not for transactional logic.
- Use PARTITION BY to avoid mixing unrelated groups.
- Always specify ORDER BY for predictable results.
- Use window frames for moving averages or cumulative sums.

### Common Pitfalls
- Using window functions in WHERE clause (not allowed; use in SELECT or ORDER BY).
- Not understanding default window frame (can lead to unexpected results).
- Performance: Large partitions can be slow; index your ORDER BY columns.

### Troubleshooting
- If results look strange, check your PARTITION BY and ORDER BY logic.
- Use explicit window frames for clarity.

### Advanced Tip
You can combine multiple window functions in one SELECT for powerful analytics!

### Advanced Examples

**Moving Average Calculation**
```sql
SELECT 
  employee_id, 
  hire_date, 
  salary,
  AVG(salary) OVER (ORDER BY hire_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_salary
FROM employees;
```
*Calculates the average salary for the current and previous two hires.*

**Difference Between Current and Previous Row**
```sql
SELECT 
  employee_id, 
  salary,
  salary - LAG(salary, 1, 0) OVER (ORDER BY salary) AS diff_from_prev
FROM employees;
```
*Shows the difference in salary from the previous row.*

### Practice Exercises
1. Write a query to assign a unique row number to each employee within their department, ordered by salary descending.
2. Calculate the cumulative sum of salaries for all employees, ordered by hire date.
3. For each employee, display their salary and the average salary of their department (using a window function).

---

## 2. Cursors

### What Are Cursors?
A cursor is a pointer to the context area in memory where a SQL statement’s result set is stored. Cursors allow you to process query results row by row, which is useful for complex logic that can’t be handled by set-based SQL alone.

### Types of Cursors
- **Implicit Cursor**: Automatically created by Oracle for single SQL statements (e.g., SELECT INTO, DML).
- **Explicit Cursor**: Declared and controlled by the programmer for multi-row queries.
- **Cursor FOR LOOP**: Simplifies explicit cursor usage by handling open/fetch/close automatically.

### Explicit Cursor Lifecycle
1. **Declare**: Define the cursor and its query.
2. **Open**: Execute the query and populate the result set.
3. **Fetch**: Retrieve rows one at a time.
4. **Close**: Release resources.

### Example: Explicit Cursor
```sql
DECLARE
  CURSOR emp_cur IS SELECT employee_id, salary FROM employees;
  emp_id employees.employee_id%TYPE;
  emp_sal employees.salary%TYPE;
BEGIN
  OPEN emp_cur;
  LOOP
    FETCH emp_cur INTO emp_id, emp_sal;
    EXIT WHEN emp_cur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: ' || emp_id || ' Salary: ' || emp_sal);
  END LOOP;
  CLOSE emp_cur;
END;
```

### Example: Cursor FOR LOOP
```sql
BEGIN
  FOR rec IN (SELECT employee_id, salary FROM employees) LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || rec.employee_id || ' Salary: ' || rec.salary);
  END LOOP;
END;
```

### Real-World Uses
- Batch processing (e.g., updating many rows with complex logic)
- Row-by-row validation or transformation
- Generating reports

### Best Practices
- Prefer set-based operations when possible (faster and more efficient).
- Always close explicit cursors to avoid memory leaks.
- Use `%FOUND`, `%NOTFOUND`, `%ROWCOUNT`, `%ISOPEN` for cursor status.
- Use cursor FOR LOOP for simpler code and automatic management.

### Common Pitfalls
- Not closing cursors (memory/resource leaks).
- Fetching after the last row (raises NO_DATA_FOUND).
- Using cursors for simple logic that could be done with a single SQL statement.

### Advanced Tip
You can pass parameters to cursors for dynamic queries:
```sql
CURSOR emp_cur (dept_id NUMBER) IS
  SELECT * FROM employees WHERE department_id = dept_id;
```

### Advanced Example: Parameterized Cursor
```sql
DECLARE
  CURSOR emp_cur (dept_id NUMBER) IS
    SELECT employee_id, salary FROM employees WHERE department_id = dept_id;
BEGIN
  FOR rec IN emp_cur(10) LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || rec.employee_id || ' Salary: ' || rec.salary);
  END LOOP;
END;
```

### Practice Exercises
1. Write a cursor to loop through all employees and give a 5% bonus to those with a salary below the company average.
2. Use a cursor to copy selected data from one table to another, applying a transformation (e.g., uppercase names).
3. Create a cursor that takes a parameter for department and prints all employee names in that department.

---
