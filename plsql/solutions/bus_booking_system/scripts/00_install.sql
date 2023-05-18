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

PROMPT Creating user management procedures...
@@04_user_procedures.sql

PROMPT Loading sample data...
@@05_sample_data.sql

PROMPT Creating utility functions and views...
@@06_utility_functions.sql

PROMPT Installation complete.
PROMPT 
PROMPT To verify the installation, you can run the following tests:
PROMPT 1. Select from daily_booking_summary view
PROMPT 2. Check bus_performance_metrics view
PROMPT 3. Try booking_mgmt.create_booking procedure
PROMPT 4. Query available schedules using schedule_mgmt.get_available_schedules
PROMPT
PROMPT Example usage:
