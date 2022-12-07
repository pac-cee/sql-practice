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
    
    DBMS_OUTPUT.PUT_LINE('Result: ' || v_result);
END;
/
```

### CASE Statement
```sql
DECLARE
    v_grade CHAR(1) := 'B';
    v_result VARCHAR2(20);
BEGIN
    CASE v_grade
        WHEN 'A' THEN v_result := 'Excellent';
        WHEN 'B' THEN v_result := 'Good';
        WHEN 'C' THEN v_result := 'Fair';
        ELSE v_result := 'Poor';
    END CASE;
    
    DBMS_OUTPUT.PUT_LINE('Result: ' || v_result);
END;
/
```

### CASE Expression
```sql
DECLARE
    v_grade CHAR(1) := 'B';
    v_result VARCHAR2(20);
BEGIN
    v_result := CASE v_grade
        WHEN 'A' THEN 'Excellent'
        WHEN 'B' THEN 'Good'
        WHEN 'C' THEN 'Fair'
        ELSE 'Poor'
    END;
    
    DBMS_OUTPUT.PUT_LINE('Result: ' || v_result);
