const { MongoClient, ObjectId } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'inventorySystemDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// This project demonstrates stock management, transactions, and reporting in MongoDB
async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- Inventory System ---');
      console.log('1. Add Product');
      console.log('2. Update Stock');
      console.log('3. List Products');
      console.log('4. Product Report');
      console.log('5. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await addProduct(db);
          break;
        case '2':
          await updateStock(db);
          break;
        case '3':
