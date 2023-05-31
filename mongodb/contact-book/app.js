const { MongoClient } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'contactBookDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- Contact Book ---');
      console.log('1. Add Contact');
      console.log('2. List Contacts');
      console.log('3. Delete Contact');
      console.log('4. Search Contact');
      console.log('5. Update Contact');
      console.log('6. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await addContact(db);
          break;
        case '2':
          await listContacts(db);
          break;
        case '3':
          await deleteContact(db);
          break;
        case '4':
          await searchContact(db);
          break;
        case '5':
          await updateContact(db);
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

async function addContact(db) {
  return new Promise((resolve) => {
    rl.question('Enter name: ', async (name) => {
      // Prevent duplicate contacts by name
      const existing = await db.collection('contacts').findOne({ name });
      if (existing) {
        console.log('Contact with this name already exists.');
        return resolve();
      }
      rl.question('Enter phone: ', (phone) => {
        rl.question('Enter email: ', async (email) => {
