const mysql = require("mysql");
const pool = mysql.createPool({
    // connectionLimit: 10,
    // host: process.env.MYSQL_HOST,
    // user: process.env.MYSQL_USER,
    // password: process.env.MYSQL_ROOT_PASSWORD,
    // database: process.env.MYSQL_DATABASE,
    // port: process.env.MYSQL_PORT
    connectionLimit: 10,
    host: 'mysql',
    user: 'root',
    password: '1234',
    database: 'myapp'
});
exports.pool = pool;