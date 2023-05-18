-- Installation Script for Smart Bus Booking System
-- Created: April 14, 2025

-- Start with a clean slate
WHENEVER SQLERROR EXIT SQL.SQLCODE ROLLBACK;
SET SERVEROUTPUT ON;
SET FEEDBACK ON;
SET ECHO ON;

PROMPT Installing Smart Bus Booking System...

PROMPT Creating tables and sequences...
@@01_create_tables.sql

PROMPT Creating booking management procedures...
@@02_booking_procedures.sql

PROMPT Creating schedule management procedures...
@@03_schedule_procedures.sql
