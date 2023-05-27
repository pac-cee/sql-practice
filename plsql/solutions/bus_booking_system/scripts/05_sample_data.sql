-- Sample Data for Smart Bus Booking System
-- Created: April 14, 2025

-- Insert Bus Terminals
INSERT INTO bus_terminals (terminal_id, location, operating_hours, contact_info) VALUES
(terminal_seq.NEXTVAL, 'Kigali Central Terminal', '04:00-23:00', '+250789123456');
INSERT INTO bus_terminals (terminal_id, location, operating_hours, contact_info) VALUES
(terminal_seq.NEXTVAL, 'Huye Bus Station', '05:00-22:00', '+250789123457');
INSERT INTO bus_terminals (terminal_id, location, operating_hours, contact_info) VALUES
(terminal_seq.NEXTVAL, 'Musanze Terminal', '05:00-21:00', '+250789123458');
INSERT INTO bus_terminals (terminal_id, location, operating_hours, contact_info) VALUES
(terminal_seq.NEXTVAL, 'Rubavu Bus Park', '06:00-22:00', '+250789123459');

-- Insert Buses
INSERT INTO buses (bus_id, terminal_id, seating_capacity, service_route, bus_type) VALUES
(bus_seq.NEXTVAL, 1, 45, 'Kigali-Huye', 'LUXURY');
INSERT INTO buses (bus_id, terminal_id, seating_capacity, service_route, bus_type) VALUES
(bus_seq.NEXTVAL, 1, 50, 'Kigali-Musanze', 'STANDARD');
INSERT INTO buses (bus_id, terminal_id, seating_capacity, service_route, bus_type) VALUES
(bus_seq.NEXTVAL, 1, 45, 'Kigali-Rubavu', 'LUXURY');
INSERT INTO buses (bus_id, terminal_id, seating_capacity, service_route, bus_type) VALUES
(bus_seq.NEXTVAL, 2, 50, 'Huye-Kigali', 'STANDARD');

-- Insert Routes
INSERT INTO routes (route_id, origin, destination, base_fare) VALUES
(route_seq.NEXTVAL, 'Kigali', 'Huye', 5000);
INSERT INTO routes (route_id, origin, destination, base_fare) VALUES
(route_seq.NEXTVAL, 'Huye', 'Kigali', 5000);
INSERT INTO routes (route_id, origin, destination, base_fare) VALUES
(route_seq.NEXTVAL, 'Kigali', 'Musanze', 4000);
INSERT INTO routes (route_id, origin, destination, base_fare) VALUES
(route_seq.NEXTVAL, 'Musanze', 'Kigali', 4000);
INSERT INTO routes (route_id, origin, destination, base_fare) VALUES
(route_seq.NEXTVAL, 'Kigali', 'Rubavu', 6000);
INSERT INTO routes (route_id, origin, destination, base_fare) VALUES
(route_seq.NEXTVAL, 'Rubavu', 'Kigali', 6000);

-- Insert Sample Schedules (for next 7 days)
DECLARE
    v_current_date DATE := TRUNC(SYSDATE);
    v_route_id NUMBER;
    v_bus_id NUMBER;
BEGIN
    -- For each route
    FOR route IN (SELECT route_id, origin FROM routes) LOOP
        -- For next 7 days
        FOR i IN 0..6 LOOP
            -- Morning schedule
            INSERT INTO schedules (
                schedule_id,
                route_id,
                bus_id,
                departure_time,
                arrival_time,
                frequency
            ) VALUES (
                schedule_seq.NEXTVAL,
                route.route_id,
                CASE 
                    WHEN route.origin = 'Kigali' THEN 1
                    WHEN route.origin = 'Huye' THEN 4
                    WHEN route.origin = 'Musanze' THEN 2
                    ELSE 3
                END,
                TIMESTAMP '2025-04-14 07:00:00' + i,
                TIMESTAMP '2025-04-14 10:00:00' + i,
                'DAILY'
            );

            -- Afternoon schedule
            INSERT INTO schedules (
                schedule_id,
                route_id,
                bus_id,
                departure_time,
                arrival_time,
