const { MongoClient } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'bankingAppDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// This project demonstrates transactions, replication, and sharding in MongoDB
async function main() {
  const client = new MongoClient(uri, { useUnifiedTopology: true });
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- Banking App ---');
      console.log('1. Create Account');
      console.log('2. Deposit');
      console.log('3. Withdraw');
      console.log('4. Transfer');
      console.log('5. Show Accounts');
      console.log('6. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await createAccount(db);
          break;
        case '2':
          await deposit(db);
          break;
        case '3':
          await withdraw(db);
          break;
        case '4':
          await transfer(db, client);
          break;
        case '5':
          await showAccounts(db);
          break;
        case '6':
          rl.close();
          await client.close();
          console.log('Goodbye!');
          return;
        default:
          console.log('Invalid option.');
      }
      showMenu();
    }
