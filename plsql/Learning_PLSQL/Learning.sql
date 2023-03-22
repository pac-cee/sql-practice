-- Create a table for attendance:
CREATE TABLE student_attendance (
    student_id       NUMBER,
    attendance_date  DATE,
    status           VARCHAR2(20)
);


-- Create a procedure to insert attendance records:
CREATE OR REPLACE PROCEDURE record_attendance(
    p_student_id        IN  NUMBER,
    p_attendance_date   IN  DATE,
    p_status            IN  VARCHAR2,
    p_message           OUT VARCHAR2
) 
IS
    -- 1) Declare a user-defined exception:
    attendance_already_recorded EXCEPTION;
    
    -- 2) Variable to check if record exists:
    v_count  NUMBER := 0;
BEGIN
    -- Check if the record already exists for the same student and date
    SELECT COUNT(*)
      INTO v_count
      FROM student_attendance
     WHERE student_id = p_student_id
       AND attendance_date = p_attendance_date;
       
    IF v_count > 0 THEN
        -- Raise user-defined exception if attendance exists
        RAISE attendance_already_recorded;
    ELSE
        -- Insert new attendance record
        INSERT INTO student_attendance (student_id, attendance_date, status)
        VALUES (p_student_id, p_attendance_date, p_status);
        
        -- Return success message
        p_message := 'Attendance recorded successfully for student ID ' 
                     || p_student_id 
                     || ' on ' 
                     || TO_CHAR(p_attendance_date, 'DD-MON-YYYY');
    END IF;
    
EXCEPTION
    WHEN attendance_already_recorded THEN
        p_message := 'Error: Attendance has already been recorded for student ID ' 
                     || p_student_id 
                     || ' on ' 
                     || TO_CHAR(p_attendance_date, 'DD-MON-YYYY');
                     
    WHEN OTHERS THEN
        -- Catch-all for any other errors
        p_message := 'An unexpected error occurred: ' || SQLERRM;
END record_attendance;
/



-- Test Scenario 1: New record (should succeed)
DECLARE
    v_message VARCHAR2(200);
BEGIN
    record_attendance(
        p_student_id      => 12345,
        p_attendance_date => DATE '2025-03-18',
        p_status          => 'Present',
        p_message         => v_message
    );
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
/

-- Test Scenario 2: Duplicate record (should raise the user-defined exception)
DECLARE
    v_message VARCHAR2(200);
BEGIN
    record_attendance(
        p_student_id      => 12345,
        p_attendance_date => DATE '2025-03-18',
        p_status          => 'Absent',  -- or any status
        p_message         => v_message
    );
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
/


/*
Here are some practice questions to challenge your ability to create procedures, handle exceptions, 
and work with different parameter types in PL/SQL:

---

### 1. Employee Insertion with Duplicate Check

**Task:**  
Create a procedure named `add_employee` that inserts a new employee record into an `employees` table. The 
table includes columns like `employee_id`, `first_name`, `last_name`, and `hire_date`.  
**Requirements:**  
- Accept the employee details as parameters.
- Check if an employee with the given `employee_id` already exists.
- If a duplicate is found, raise a user-defined exception and return an appropriate error message via an
 OUT parameter.
- If no duplicate exists, insert the record and return a success message.

---
*/
create table employees(
    employee_id number primary key,
    first_name varchar2(50),
    last_name varchar2(50),
    hire_date date
);

create or replace procedure add_employee(
    p_employee_id in number,
    p_first_name in varchar2,
    p_last_name in varchar2,
    p_hire_date in date,
    p_message out varchar2
) as
    employee_already_exists exception;
    PRAGMA EXCEPTION_INIT(employee_already_exists, -1); -- Initialize the exception
    v_count number := 0;
begin
    -- Check if the employee already exists
    SELECT COUNT(*)
      INTO v_count
      FROM employees
     WHERE employee_id = p_employee_id;

    IF v_count > 0 THEN
        -- Raise user-defined exception if employee exists
        RAISE employee_already_exists;
    ELSE
        -- Insert new employee record
        INSERT INTO employees (employee_id, first_name, last_name, hire_date)
        VALUES (p_employee_id, p_first_name, p_last_name, p_hire_date);
        
        -- Return success message
        p_message := 'Employee added successfully with ID ' || p_employee_id;
    END IF;
    
EXCEPTION
    WHEN employee_already_exists THEN
        p_message := 'Error: Employee with ID ' || p_employee_id || ' already exists.';
        
    WHEN OTHERS THEN
        -- Catch-all for any other errors
        p_message := 'An unexpected error occurred: ' || SQLERRM;
END add_employee;
/

-- Test Scenario 1: New employee record (should succeed)
DECLARE
    v_message VARCHAR2(200);
BEGIN
    add_employee(
        p_employee_id => 1001,
        p_first_name => 'John',
        p_last_name => 'Doe',
        p_hire_date => DATE '2025-03-18',
        p_message => v_message
    );
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
-- Test Scenario 2: Duplicate employee record (should raise the user-defined exception)
DECLARE
    v_message VARCHAR2(200);
BEGIN
    add_employee(
        p_employee_id => 1001,
        p_first_name => 'Jane',
        p_last_name => 'Smith',
        p_hire_date => DATE '2025-03-18',
        p_message => v_message
    );
    DBMS_OUTPUT.PUT_LINE(v_message);
    
    -- Test Scenario 3: New employee record (should succeed)
    add_employee(
        p_employee_id => 1002,
        p_first_name => 'Alice',
        p_last_name => 'Johnson',
        p_hire_date => DATE '2025-03-19',
        p_message => v_message
    );
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
