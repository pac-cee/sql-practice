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
