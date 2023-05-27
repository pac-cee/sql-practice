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
