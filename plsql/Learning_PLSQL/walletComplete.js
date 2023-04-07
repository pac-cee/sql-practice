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
          wallet_id: { dir: oracledb.BIND_OUT, type: oracledb.NUMBER }
        }
      );
      await connection.commit();
      return result.outBinds.wallet_id;
    } finally {
      await connection.close();
    }
  }

  static async getWalletBalance(walletId) {
    const connection = await oracledb.getConnection();
    try {
      const result = await connection.execute(
        `SELECT wallet_mgmt.get_wallet_balance(:wallet_id) as balance FROM dual`,
        { wallet_id: walletId }
      );
      return result.rows[0].BALANCE;
    } finally {
      await connection.close();
    }
  }
}

module.exports = WalletModel;

// /backend/controllers/walletController.js
const WalletModel = require('../models/walletModel');

class WalletController {
  static async createWallet(req, res) {
    try {
      const { userId, walletName, currency } = req.body;
      const walletId = await WalletModel.createWallet(userId, walletName, currency);
      res.json({ success: true, walletId });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
