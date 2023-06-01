const { MongoClient } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'ecommerceAnalyticsDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// This project demonstrates aggregation and analytics in MongoDB
async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- E-commerce Analytics ---');
      console.log('1. Add Order');
      console.log('2. List Orders');
      console.log('3. Sales by Product');
      console.log('4. Top Customers');
      console.log('5. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await addOrder(db);
          break;
        case '2':
          await listOrders(db);
          break;
        case '3':
