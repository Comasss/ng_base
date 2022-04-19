// OXMYSQL Wrapper code, all rights deserved to them.

const convar = GetConvar("mysql_connection_strings");

const { createPool } = require('mysql2/promise');

const { ConnectionStringParser } = require("connection-string-parser");

const connectionStringParser = new ConnectionStringParser({
	scheme: "mysql",
	hosts: []
});

const connectionObject = connectionStringParser.parse(convar);

const pool = createPool({
    host: connectionObject['hosts']['host'],
    user: connectionObject['username'],
    password: connectionObject['password'] || '',
    database: connectionObject['endpoint'],
    charset: connectionObject['options']['charset'],
    multipleStatements: false,
    namedPlaceholders: true,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

const execute = async (query, parameters) => {
    ScheduleResourceTick(GetCurrentResourceName());
    try {
        console.time(query);
        const [result] = await pool.execute(query, parameters);
        console.timeEnd(query);
        return result;
    } catch (error) {
        return console.error(error.message);
    }
};

global.exports("execute", (query, parameters, callback = () => { }) => {
    execute(query, parameters).then((result) => {
        callback(result)
    });
});
