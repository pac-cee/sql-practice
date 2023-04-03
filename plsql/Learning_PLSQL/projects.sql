-- 1. Banking System

CREATE TABLE bank_accounts (
    account_id   NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100),
    balance      NUMBER(10,2)
);

CREATE OR REPLACE PACKAGE bank_pkg IS
    PROCEDURE deposit(p_account_id IN NUMBER, p_amount IN NUMBER);
    PROCEDURE withdraw(p_account_id IN NUMBER, p_amount IN NUMBER);
    FUNCTION get_balance(p_account_id IN NUMBER) RETURN NUMBER;
END bank_pkg;
/

CREATE OR REPLACE PACKAGE BODY bank_pkg IS
    PROCEDURE deposit(p_account_id IN NUMBER, p_amount IN NUMBER) IS
    BEGIN
        UPDATE bank_accounts
        SET balance = balance + p_amount
        WHERE account_id = p_account_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Account not found');
        END IF;
    END deposit;
    
    PROCEDURE withdraw(p_account_id IN NUMBER, p_amount IN NUMBER) IS
    BEGIN
        UPDATE bank_accounts
        SET balance = balance - p_amount
        WHERE account_id = p_account_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Account not found');
        ELSIF balance < 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Insufficient funds');
        END IF;
