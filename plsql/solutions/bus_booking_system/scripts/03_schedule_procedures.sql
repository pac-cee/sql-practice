-- Schedule Management Procedures
-- Created: April 14, 2025

CREATE OR REPLACE PACKAGE schedule_mgmt AS
    -- Add new route
    PROCEDURE add_route(
        p_origin IN VARCHAR2,
        p_destination IN VARCHAR2,
        p_base_fare IN NUMBER,
        p_route_id OUT NUMBER
    );

    -- Create new schedule
    PROCEDURE create_schedule(
        p_route_id IN NUMBER,
        p_bus_id IN NUMBER,
        p_departure_time IN TIMESTAMP,
        p_arrival_time IN TIMESTAMP,
        p_frequency IN VARCHAR2,
        p_schedule_id OUT NUMBER
    );

    -- Get available schedules
    FUNCTION get_available_schedules(
        p_origin IN VARCHAR2,
        p_destination IN VARCHAR2,
        p_travel_date IN DATE
    ) RETURN SYS_REFCURSOR;

    -- Update schedule times
    PROCEDURE update_schedule_times(
        p_schedule_id IN NUMBER,
        p_new_departure IN TIMESTAMP,
        p_new_arrival IN TIMESTAMP
    );
END schedule_mgmt;
/

CREATE OR REPLACE PACKAGE BODY schedule_mgmt AS
    -- Implementation of add_route
    PROCEDURE add_route(
        p_origin IN VARCHAR2,
        p_destination IN VARCHAR2,
        p_base_fare IN NUMBER,
        p_route_id OUT NUMBER
    ) IS
    BEGIN
        SELECT route_seq.NEXTVAL INTO p_route_id FROM DUAL;
        
        INSERT INTO routes (
            route_id,
            origin,
            destination,
            base_fare
        ) VALUES (
            p_route_id,
            p_origin,
