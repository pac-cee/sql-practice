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
