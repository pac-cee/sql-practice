const { MongoClient, ObjectId } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'studentManagementDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// This project demonstrates managing students, grades, and class assignments in MongoDB
async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

    function showMenu() {
      console.log('\n--- Student Management ---');
      console.log('1. Add Student');
      console.log('2. Assign Grade');
      console.log('3. List Students');
      console.log('4. List Grades for Student');
      console.log('5. Exit');
      rl.question('Choose an option: ', handleMenu);
    }

    async function handleMenu(option) {
      switch (option.trim()) {
        case '1':
          await addStudent(db);
          break;
        case '2':
          await assignGrade(db);
          break;
        case '3':
          await listStudents(db);
          break;
        case '4':
          await listGrades(db);
          break;
        case '5':
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
