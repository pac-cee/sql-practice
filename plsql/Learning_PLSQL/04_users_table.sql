-- Enable server output
SET SERVEROUTPUT ON;

-- Drop table if it exists
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

-- Create a sequence for user_id
CREATE SEQUENCE user_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
