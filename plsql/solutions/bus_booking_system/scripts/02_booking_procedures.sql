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
