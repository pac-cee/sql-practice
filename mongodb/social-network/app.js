const { MongoClient, ObjectId } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'socialNetworkDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// This project demonstrates user relationships, friend requests, and feed aggregation in MongoDB
async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- Social Network ---');
      console.log('1. Register User');
      console.log('2. Send Friend Request');
      console.log('3. Accept Friend Request');
      console.log('4. Post Status');
      console.log('5. View Feed');
      console.log('6. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await registerUser(db);
          break;
        case '2':
          await sendFriendRequest(db);
          break;
