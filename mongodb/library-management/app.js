const { MongoClient, ObjectId } = require('mongodb');
const readline = require('readline');

const uri = 'mongodb://localhost:27017';
const dbName = 'libraryManagementDB';

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// This project demonstrates indexing, performance, and security in MongoDB
async function main() {
  const client = new MongoClient(uri);
  try {
    await client.connect();
    console.log('Connected to MongoDB!');
    const db = client.db(dbName);

