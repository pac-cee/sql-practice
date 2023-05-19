-- Create tables for Smart Bus Booking System
-- Created: April 14, 2025

-- Users table
CREATE TABLE users (
    user_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    phone_number VARCHAR2(20) NOT NULL,
    created_date DATE DEFAULT SYSDATE
);

-- Bus Terminals table
CREATE TABLE bus_terminals (
    terminal_id NUMBER PRIMARY KEY,
    location VARCHAR2(100) NOT NULL,
    operating_hours VARCHAR2(50) NOT NULL,
    contact_info VARCHAR2(100) NOT NULL
