const { pool } = require('../startup/mysql_database');

class BranchManager {

    static enterEmployee(body) {
        return new Promise((resolve, reject) => {
            const result = pool.query("CALL create_employee (?,?,?,?,?,?,?,?)",
                [
                    body.full_name,
                    body.address,
                    body.branch_id,
                    body.date_of_birth,
                    body.salary,
                    body.date_of_employment,
                    body.email,
                    body.password
                ],
                function (error, results, fields) {
                    if (error) {
                        reject(error);
                    };
                    resolve(console.log("Done"));
                }
            )
        })
    }

    static getAllTransationsHO(month, year) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM transaction_information WHERE EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ? ",
                [
                    month,
                    year
                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        console.log(error);
                        reject(error);
                    };
                    console.log(result.sql);
                    console.log(results);
                    resolve(results);
                }
            )
        })
    }

    static getAllTransations(branch_id,month, year) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM transaction_information WHERE EXTRACT(MONTH FROM date) = ? AND EXTRACT(YEAR FROM date) = ? AND branch_id = ?",
                [
                    month,
                    year,
                    branch_id
                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                    console.log(result.sql);
                    console.log(results);
                    resolve(results);
                }
            )
        })
    }

    static getLateLoanInstallments(branch_id, month, year) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM late_loan_information WHERE due_month = ? AND due_year = ? AND branch_id=?",
                [
                    month,
                    year,
                    branch_id
                    

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                    console.log(result.sql);
                    console.log(results);
                    resolve(results);
                }
            )
        })
    }

    static getLateLoanInstallmentsHO( month, year) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM late_loan_information WHERE due_month = ? AND due_year = ? ",
                [
                    month,
                    year,
                    

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                    console.log(result.sql);
                    console.log(results);
                    resolve(results);
                }
            )
        })
    }

    static getPendingLoans(branch_id) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM normal_loan NATURAL JOIN loan_plan WHERE normal_loan.status = 'Pending' AND normal_loan.branch_id = ?",
                [
                    branch_id,
                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                    console.log(result.sql);
                    console.log(results);
                    resolve(results);
                }
            )
        })
    }

    static getAllPendingLoans() {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM normal_loan NATURAL JOIN loan_plan WHERE normal_loan.status = 'Pending'",
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                    console.log(result.sql);
                    console.log(results);
                    resolve(results);
                }
            )
        })
    }

    static approveLoan(loan_id) {
        return new Promise((resolve, reject) => {
            const result = pool.query("UPDATE `normal_loan` SET normal_loan.status = ? WHERE normal_loan.loan_id = ?",
                [
                    "Approved",
                    loan_id
                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                    console.log(result.sql);
                    resolve("Accepted");
                }
            )
        })
    }

    static declineLoan(loan_id) {
        return new Promise((resolve, reject) => {
            const result = pool.query("UPDATE `normal_loan` SET normal_loan.status = ? WHERE normal_loan.loan_id = ?",
                [
                    'Rejected',
                    loan_id
                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                 
                    resolve("Rejected");
                }
            )
        })
    }





    
    // SELECT * FROM corporate_customer WHERE  EXTRACT(MONTH FROM date_of_establishment) =3;
}

module.exports = BranchManager;