-- Booking Management Procedures
-- Created: April 14, 2025

CREATE OR REPLACE PACKAGE booking_mgmt AS
    -- Check seat availability
    FUNCTION check_seat_availability(
        p_schedule_id IN NUMBER,
        p_seat_number IN NUMBER
    ) RETURN BOOLEAN;

    -- Create new booking
    PROCEDURE create_booking(
        p_user_id IN NUMBER,
        p_schedule_id IN NUMBER,
        p_seat_number IN NUMBER,
        p_booking_id OUT NUMBER
    );

    -- Cancel booking
    PROCEDURE cancel_booking(
        p_booking_id IN NUMBER
    );

    -- Update payment status
    PROCEDURE update_payment_status(
        p_booking_id IN NUMBER,
        p_status IN VARCHAR2
    );
END booking_mgmt;
/

CREATE OR REPLACE PACKAGE BODY booking_mgmt AS
    -- Implementation of check_seat_availability
    FUNCTION check_seat_availability(
        p_schedule_id IN NUMBER,
        p_seat_number IN NUMBER
    ) RETURN BOOLEAN IS
        v_count NUMBER;
