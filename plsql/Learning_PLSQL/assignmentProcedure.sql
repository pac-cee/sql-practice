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
