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
