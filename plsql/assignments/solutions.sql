
-- SQL Window Functions Assignment Solution

-- Dataset Creation

-- Create the e_sales table
CREATE TABLE e_sales (
    sale_id NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    category VARCHAR2(50),
    region VARCHAR2(50),
    sale_date DATE,
    quantity NUMBER,
    unit_price NUMBER,
    total_amount NUMBER
);

-- Insert sample data
INSERT INTO e_sales VALUES (1, 'iPhone 16 Pro', 'Smartphones', 'North', TO_DATE('2025-01-05', 'YYYY-MM-DD'), 10, 999, 9990);
