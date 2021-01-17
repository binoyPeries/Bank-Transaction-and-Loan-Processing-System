const { pool } = require('../startup/mysql_database');

function getPassword(email, table) {
    let field = 'email';
    if (table == 'corporate_customer') {    
        field = 'corporate_email';
    }
    return new Promise((resolve, reject) => {
        const result = pool.query(`SELECT password FROM ${table} WHERE ${field}=?`,
            [
                email
            ],
            function (error, results, fields) {
                if (error) {
                    reject(error);
                };
                console.log(result.sql);
                console.log(results);
                console.log(results[0]);
                resolve(results[0].password);
            }
        )
    });

}

exports.getPassword = getPassword;