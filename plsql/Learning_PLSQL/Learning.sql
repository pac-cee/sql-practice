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

