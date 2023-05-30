const { MongoClient, ObjectId } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'blogPlatformDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Blog posts can have comments and an author
async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- Blog Platform ---');
      console.log('1. Add Author');
      console.log('2. Add Post');
      console.log('3. List Posts');
      console.log('4. Add Comment to Post');
      console.log('5. List Comments for a Post');
      console.log('6. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await addAuthor(db);
          break;
        case '2':
          await addPost(db);
          break;
