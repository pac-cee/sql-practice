// Backend Structure (Node.js)

// /backend/config/database.js
const oracledb = require('oracledb');

const dbConfig = {
  user: 'your_username',
  password: 'your_password',
  connectString: 'localhost:1521/your_service'
};

async function initialize() {
  try {
    await oracledb.createPool(dbConfig);
    console.log('Connected to Oracle database');
  } catch (err) {
    console.error('Error connecting to database:', err);
    throw err;
  }
}

module.exports = { initialize };

// /backend/models/walletModel.js
const oracledb = require('oracledb');

class WalletModel {
  static async createWallet(userId, walletName, currency) {
    const connection = await oracledb.getConnection();
    try {
      const result = await connection.execute(
        `BEGIN
           wallet_mgmt.create_wallet(:user_id, :wallet_name, :currency, :wallet_id);
         END;`,
        {
          user_id: userId,
          wallet_name: walletName,
          currency: currency,
