import mysql from 'mysql2/promise';

const sql_client = await mysql.createConnection({
  host: '127.0.0.1',
  port: 3306,
  user: 'root',
  password: '1234',
  database: 'mysql',
});

console.log('✅ Connected to MariaDB');

export default sql_client;