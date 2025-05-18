const mysql = require('mysql2');  
require('dotenv').config();      

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  // 1.1 Lengkapi koneksi database dengan environment variables yang sesuai (dari env). Contoh ada di line 5.
  user: process.env.DB_USER, 
  password: process.env.DB_PASSWORD,   
  database: process.env.DB_NAME, 
  port: process.env.DB_PORT || 3306, 
});

module.exports = connection;