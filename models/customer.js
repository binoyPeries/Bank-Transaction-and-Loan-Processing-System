
const { pool } = require('../startup/mysql_database');

class Customer{

    static async isIndividualEmailRegistered(email) {
        var result = await new Promise((resolve, reject) => {
            const result = pool.query('SELECT customer_id FROM individual_customer WHERE email = ?',
                [email],
                function (error, results) {
                    if (error) {
                        reject(new Error(error.message));
                    }
                    resolve(results);
                }
            )
        })

        return result.length != 0;
    }


    static async isCorporateEmailRegistered(email) {
        var result = await new Promise((resolve, reject) => {
            const result = pool.query('SELECT customer_id FROM corporate_customer WHERE corporate_email = ?',
                [email],
                function (error, results) {
                    if (error) {
                        reject(new Error(error.message));
                    }
                    console.log(result.sql);
                    console.log(results);
                    resolve(results);
                }
            )
        })

        return result.length != 0;
    }

    static withdrawMoney(date, savings_account_id, withdrawal_amount) {
        return new Promise((resolve,reject) => {
            const result = pool.query("CALL savings_account_money_withdrawal(?,?,?)",
            [
                date, savings_account_id, withdrawal_amount
            ],

            function (error, results, fields) {
                if (error) {
                    reject(error);
                }
                else {
                    console.log(result.sql);
                    resolve(console.log("successssss!!!"));
                }
                
            }
            )
        })
    }

    static createOnlineLoan(body) {
        return new Promise((resolve, reject) => {
            const result = pool.query("CALL create_online_loan (?,?,?,?,?,?)",
                [
                    body.loan_plan_id,
                    body.fixed_deposit_id,
                    body.customer_id,
                    body.branch_id,
                    body.loan_installment,
                    body.loan_amount

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                        console.log(result.sql);

                    resolve(console.log("succesful"));
                }
            )
        })
    }

    static getAllSavingsAccounts(customerID) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM customer_view_savings_accounts WHERE customer_id=?",
                [
                    customerID

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(error);
                    };
                    console.log(results);
                    resolve(results);
                }
            )
        })
        
    }

    static getAllSavingsAccountsForWithdraw(customerID) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT savings_account_id,customer_id,no_of_withdrawals_remaining,max_withdrawal_limit,bank_balance FROM all_savings_accounts WHERE customer_id=?",
                [
                    customerID

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(error);
                    };
                    console.log(results);
                    resolve(results);
                }
            )
        })
        
    }

    static depositMoney(date,account_id,deposit_amount){
        return new Promise( (resolve,reject) => {
            const result = pool.query("CALL savings_account_money_deposit (?,?,?)",
            [
                date,
                account_id,
                deposit_amount
            ],
            
            function (error, results, fields) {
                if (error) {
                    reject(error);
                }
                else {
                    console.log(result.sql);
                    resolve(console.log("successssss!!!"));
                }
                
            }
            )
        })
    }


    static getAllSavingsAccountIDs(customerID) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT savings_account_id FROM all_savings_accounts WHERE customer_id=?",
                [
                    customerID

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(error);
                    };
                    console.log(results);
                    resolve(results);
                }
            )
        })
        
    }
         
    static getAllCheckingAccountIDs(customerID) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT checking_account_id  FROM all_checking_accounts WHERE customer_id=? AND status=?",
                [
                    customerID,
                    "Open"

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(error);
                    };
                    console.log(results);
                    resolve(results);
                }
            )
        })
    }

    static getAllCheckingAccounts(customerID) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM customer_view_checking_accounts WHERE customer_id=?",
                [
                    customerID

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(error);
                    };
                    console.log(results);
                    resolve(results);
                }
            )
        })
    }
f
    //online loans related
    static getAllFixedDepositsIDs(customerID) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT fixed_deposit_id,branch_id, deposit_amount FROM all_fixed_deposits WHERE customer_id=? AND status=?",
                [
                    customerID,
                    "Open"
                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(error);
                    };
                    console.log(results);
                    resolve(results);
                }
            )
        })

    }
    static getAllLoanPlans() {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM loan_plan",
                [],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(result);
                    };
                    resolve(results);
                }
            )
        })
        
    }
    
    static getOnlineLoanID() {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT AUTO_INCREMENT FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'bank' AND TABLE_NAME = 'online_loan'",
                [],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(result);
                    };
                    resolve(results);
                }
            )
        })

    }

    

    static getAllFixedDeposits(customerID) {
        return new Promise((resolve, reject) => {
            const result = pool.query("SELECT * FROM customer_view_fixed_deposits WHERE customer_id=? AND status=?",
                [
                    customerID,
                    "Open"
                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(error);
                    };
                    console.log(results);
                    resolve(results);
                }
            )
        })

    }

    static getProfileInformation(customerID, privilege_level) {
        let query;
        if (privilege_level == 3) {
            query = "SELECT * FROM corporate_customer WHERE customer_id=?"
        }
        else {
            query = "SELECT * FROM individual_customer WHERE customer_id=?"
        }

        return new Promise((resolve, reject) => {
            const result = pool.query(query,
                [
                    customerID
                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(error);
                        reject(error);
                    };
                    console.log(results);
                    resolve(results);
                }
            )
        })

    }


    static tranferMoneySavings(body) {
        return new Promise((resolve, reject) => {
            const result = pool.query("CALL savings_account_money_transfer (?,?,?)",
                [
                    body.initiating_account_id,
                    body.receiving_account_id,
                    body.transaction_amount

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                    console.log(result.sql);
                    console.log(results);
                    console.log(results.changedRows);
                    resolve(results.changedRows);
                }
            )
        })
    }

    static tranferMoneyChecking(body) {
        return new Promise((resolve, reject) => {
            const result = pool.query("CALL checking_account_money_transfer (?,?,?)",
                [
                    body.initiating_account_id,
                    body.receiving_account_id,
                    body.transaction_amount

                ],
                function (error, results, fields) {
                    if (error) {
                        console.log(result.sql);
                        reject(error);
                    };
                resolve(results.changedRows);

                }
            )
        })
    }
}


module.exports = Customer;
