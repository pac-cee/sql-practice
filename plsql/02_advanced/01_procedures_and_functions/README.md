# PL/SQL Procedures and Functions

## Introduction
Procedures and functions are named PL/SQL blocks that can be stored in the database and reused. They are the building blocks of modular PL/SQL programming.

## 1. Procedures

### Basic Procedure Structure
```sql
CREATE OR REPLACE PROCEDURE procedure_name 
    (parameter1 IN|OUT|IN OUT datatype,
     parameter2 IN|OUT|IN OUT datatype,
     ...)
IS|AS
    -- Declaration section
BEGIN
    -- Executable section
EXCEPTION
    -- Exception section
