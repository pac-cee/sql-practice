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
        case '3':
          await listPosts(db);
          break;
        case '4':
          await addComment(db);
          break;
        case '5':
          await listComments(db);
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

// Add an author
async function addAuthor(db) {
  return new Promise((resolve) => {
    rl.question('Enter author name: ', async (name) => {
      if (!name.trim()) {
        console.log('Author name is required.');
        return resolve();
      }
      await db.collection('authors').insertOne({ name });
      console.log('Author added!');
