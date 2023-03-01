/*Below are sample PL/SQL solutions for each exercise from the document, with plenty of inline comments so you can follow the logic and learn good commenting practices.

─────────────────────────────
Question 1: VAT Calculation Procedure for RRA
─────────────────────────────

/*This procedure accepts a transaction amount, calculates the VAT at a fixed 18% rate, and returns both the VAT and the final amount.*/
CREATE OR REPLACE PROCEDURE Calculate_VAT (
    total_amount IN NUMBER,    -- Input: total transaction amount
    vat OUT NUMBER,            -- Output: calculated VAT amount
    final_amount OUT NUMBER    -- Output: final amount after adding VAT
) AS
    -- Define a constant for the VAT rate (18%)
    VAT_RATE CONSTANT NUMBER := 0.18;
    -- Local variable to hold the computed VAT value
    temp_vat NUMBER;
BEGIN
    -- Calculate VAT by multiplying the total amount by the VAT rate
    temp_vat := total_amount * VAT_RATE;

    
    -- Set the output parameters
    vat := temp_vat;
    final_amount := total_amount + temp_vat;
    
    -- Display the results using DBMS_OUTPUT for verification
    DBMS_OUTPUT.PUT_LINE('VAT: ' || vat || ', Final Amount: ' || final_amount);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error in Calculate_VAT: ' || SQLERRM);
END Calculate_VAT;
/
/*
─────────────────────────────
Question 2: Employee Bonus Calculation
─────────────────────────────

This procedure calculates a bonus based on the employee’s performance rating: 20% for ‘A’, 10% for ‘B’, and 5% for ‘C’.
*/
CREATE OR REPLACE PROCEDURE Calculate_Bonus (
    p_employee_id IN NUMBER,   -- Employee ID (for logging purposes)
    p_salary IN NUMBER,        -- Input: employee's salary
    p_rating IN CHAR,          -- Input: performance rating ('A', 'B', 'C')
    p_bonus OUT NUMBER         -- Output: calculated bonus
) AS
BEGIN
    -- Use UPPER to handle lowercase inputs and calculate bonus accordingly
    IF UPPER(p_rating) = 'A' THEN
        p_bonus := p_salary * 0.20;  -- 20% bonus for rating A
    ELSIF UPPER(p_rating) = 'B' THEN
        p_bonus := p_salary * 0.10;  -- 10% bonus for rating B
    ELSIF UPPER(p_rating) = 'C' THEN
        p_bonus := p_salary * 0.05;  -- 5% bonus for rating C
    ELSE
        -- If the rating does not match, assign a bonus of zero
        p_bonus := 0;
    END IF;
