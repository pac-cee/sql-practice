-- Utility Functions for Bus Booking System
-- Created: April 14, 2025

CREATE OR REPLACE PACKAGE booking_utils AS
    -- Get revenue by route
    FUNCTION get_route_revenue(
        p_start_date IN DATE,
        p_end_date IN DATE
    ) RETURN SYS_REFCURSOR;

    -- Get bus utilization report
    FUNCTION get_bus_utilization(
        p_start_date IN DATE,
        p_end_date IN DATE
    ) RETURN SYS_REFCURSOR;

    -- Get popular routes
    FUNCTION get_popular_routes(
        p_start_date IN DATE,
        p_end_date IN DATE
    ) RETURN SYS_REFCURSOR;

    -- Check bus availability
    FUNCTION is_bus_available(
        p_bus_id IN NUMBER,
        p_date IN DATE
    ) RETURN BOOLEAN;
END booking_utils;
/

CREATE OR REPLACE PACKAGE BODY booking_utils AS
    -- Implementation of get_route_revenue
    FUNCTION get_route_revenue(
        p_start_date IN DATE,
        p_end_date IN DATE
    ) RETURN SYS_REFCURSOR IS
        v_result_set SYS_REFCURSOR;
    BEGIN
