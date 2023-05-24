-- User Management Procedures
-- Created: April 14, 2025

CREATE OR REPLACE PACKAGE user_mgmt AS
    -- Register new user
    PROCEDURE register_user(
        p_first_name IN VARCHAR2,
        p_last_name IN VARCHAR2,
        p_email IN VARCHAR2,
        p_phone_number IN VARCHAR2,
        p_user_id OUT NUMBER
    );

    -- Update user details
    PROCEDURE update_user(
        p_user_id IN NUMBER,
        p_first_name IN VARCHAR2,
        p_last_name IN VARCHAR2,
        p_phone_number IN VARCHAR2
    );

    -- Get user booking history
    FUNCTION get_user_bookings(
        p_user_id IN NUMBER
    ) RETURN SYS_REFCURSOR;

    -- Delete user account
    PROCEDURE delete_user(
        p_user_id IN NUMBER
    );
END user_mgmt;
/

CREATE OR REPLACE PACKAGE BODY user_mgmt AS
    -- Implementation of register_user
    PROCEDURE register_user(
        p_first_name IN VARCHAR2,
        p_last_name IN VARCHAR2,
