-- Project Structure
/*
wallet-app/
├── backend/
│   ├── database/
│   │   ├── tables/
│   │   ├── procedures/
│   │   ├── functions/
│   │   ├── triggers/
│   │   └── packages/
│   └── api/
│       └── controllers/
├── frontend/
│   ├── src/
│   │   ├── components/
│   │   ├── pages/
│   │   ├── services/
│   │   └── utils/
│   └── public/
└── docs/
*/

-- 1. Database Tables Creation
CREATE TABLE users (
    user_id NUMBER GENERATED ALWAYS AS IDENTITY,
    username VARCHAR2(50) NOT NULL UNIQUE,
    email VARCHAR2(100) NOT NULL UNIQUE,
    password_hash VARCHAR2(256) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_users PRIMARY KEY (user_id)
);

CREATE TABLE wallets (
    wallet_id NUMBER GENERATED ALWAYS AS IDENTITY,
    user_id NUMBER NOT NULL,
    wallet_name VARCHAR2(50) NOT NULL,
    currency VARCHAR2(3) DEFAULT 'USD',
    balance NUMBER(15,2) DEFAULT 0,
