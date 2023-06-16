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
        case '3':
          await acceptFriendRequest(db);
          break;
        case '4':
          await postStatus(db);
          break;
        case '5':
          await viewFeed(db);
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

    showMenu();
  } catch (err) {
    console.error('Error:', err);
    rl.close();
    await client.close();
  }
}

// Register a new user
async function registerUser(db) {
  return new Promise((resolve) => {
    rl.question('Enter username: ', async (username) => {
      if (!username.trim()) {
        console.log('Username required.');
        return resolve();
      }
      const exists = await db.collection('users').findOne({ username });
      if (exists) {
        console.log('Username already taken.');
        return resolve();
      }
      await db.collection('users').insertOne({ username, friends: [], requests: [] });
      console.log('User registered!');
      resolve();
    });
  });
}

// Send a friend request
async function sendFriendRequest(db) {
  return new Promise((resolve) => {
    rl.question('Your username: ', async (from) => {
      rl.question('Send request to username: ', async (to) => {
        if (from === to) {
          console.log('Cannot friend yourself.');
          return resolve();
        }
        const user = await db.collection('users').findOne({ username: to });
        if (!user) {
          console.log('User not found.');
          return resolve();
        }
        if (user.requests.includes(from) || user.friends.includes(from)) {
          console.log('Request already sent or you are already friends.');
          return resolve();
        }
        await db.collection('users').updateOne(
          { username: to },
          { $push: { requests: from } }
        );
        console.log('Friend request sent!');
        resolve();
      });
    });
  });
}

// Accept a friend request
async function acceptFriendRequest(db) {
  return new Promise((resolve) => {
    rl.question('Your username: ', async (username) => {
      const user = await db.collection('users').findOne({ username });
      if (!user || user.requests.length === 0) {
        console.log('No pending requests.');
        return resolve();
      }
      console.log('Pending requests:', user.requests.join(', '));
      rl.question('Accept request from: ', async (from) => {
        if (!user.requests.includes(from)) {
          console.log('No such request.');
          return resolve();
        }
        // Add each other as friends
        await db.collection('users').updateOne(
          { username },
