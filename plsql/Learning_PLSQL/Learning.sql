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
