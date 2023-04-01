CREATE OR REPLACE PROCEDURE Calculate_VAT(
    p_total_amount IN NUMBER,
    p_vat_amount OUT NUMBER,
    p_final_amount OUT NUMBER
) IS
    -- Constant declaration
    c_vat_rate CONSTANT NUMBER := 0.18;
    
    -- Local variable
    v_vat_calculation NUMBER;
    
    -- Custom exception
    e_invalid_amount EXCEPTION;
BEGIN
    -- Input validation
    IF p_total_amount <= 0 THEN
        RAISE e_invalid_amount;
    END IF;
    
