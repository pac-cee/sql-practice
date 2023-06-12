const { MongoClient, ObjectId } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'restaurantReservationDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// This project demonstrates reservation management and time slot handling in MongoDB
async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- Restaurant Reservation ---');
      console.log('1. Add Table');
      console.log('2. Make Reservation');
      console.log('3. List Reservations');
      console.log('4. Cancel Reservation');
      console.log('5. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await addTable(db);
          break;
        case '2':
          await makeReservation(db);
          break;
        case '3':
