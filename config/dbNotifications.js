const { Pool } = require('pg');
require('dotenv').config();

module.exports = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: 'notifications_db',
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT
});
