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
