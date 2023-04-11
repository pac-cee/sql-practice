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
  }

  static async getBalance(req, res) {
    try {
      const { walletId } = req.params;
      const balance = await WalletModel.getWalletBalance(walletId);
      res.json({ balance });
    } catch (err) {
      res.status(500).json({ error: err.message });
    }
  }
}

module.exports = WalletController;

// /backend/routes/walletRoutes.js
const express = require('express');
const WalletController = require('../controllers/walletController');
const router = express.Router();

router.post('/create', WalletController.createWallet);
router.get('/:walletId/balance', WalletController.getBalance);

module.exports = router;

// /backend/server.js
const express = require('express');
const cors = require('cors');
const database = require('./config/database');
const walletRoutes = require('./routes/walletRoutes');

const app = express();
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/wallets', walletRoutes);

// Initialize database and start server
database.initialize()
  .then(() => {
    app.listen(3000, () => {
      console.log('Server running on port 3000');
    });
  })
  .catch(err => {
    console.error('Failed to start server:', err);
  });

// Frontend Structure (React)

// /frontend/src/services/api.js
import axios from 'axios';

const API_URL = 'http://localhost:3000/api';

export const api = axios.create({
