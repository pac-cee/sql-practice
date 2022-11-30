# PL/SQL Basic Blocks

## Introduction to PL/SQL Blocks

A PL/SQL block is the basic unit of a PL/SQL program. Every PL/SQL program consists of blocks that can be nested within each other.

### Block Structure

```sql
DECLARE
    -- Declaration section (Optional)
    -- Variables, cursors, user-defined types
BEGIN
    -- Executable section (Mandatory)
    -- PL/SQL statements
EXCEPTION
    -- Exception section (Optional)
    -- Error handling
END;
