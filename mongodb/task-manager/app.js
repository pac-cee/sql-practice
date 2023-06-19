const { MongoClient } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'taskManagerDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Valid status values for tasks
const VALID_STATUS = ['pending', 'done'];

async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- Task Manager ---');
      console.log('1. Add Task');
      console.log('2. List All Tasks');
      console.log('3. Update Task Status');
      console.log('4. Delete Task');
      console.log('5. List Tasks by Status');
      console.log('6. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await addTask(db);
          break;
        case '2':
