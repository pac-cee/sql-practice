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
