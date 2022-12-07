# PL/SQL Control Structures

## 1. Conditional Statements

### IF-THEN-ELSIF-ELSE
```sql
DECLARE
    v_grade CHAR(1) := 'B';
    v_result VARCHAR2(20);
BEGIN
    IF v_grade = 'A' THEN
        v_result := 'Excellent';
    ELSIF v_grade = 'B' THEN
        v_result := 'Good';
    ELSIF v_grade = 'C' THEN
        v_result := 'Fair';
    ELSE
        v_result := 'Poor';
    END IF;
