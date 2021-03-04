CREATE
OR REPLACE VIEW `customer_view_savings_accounts` AS
SELECT
  savings_account_id,
  customer_id,
  branch_name,
  bank_balance,
  max_withdrawal_limit,
  savings_account_plan.plan_name,
  no_of_withdrawals_remaining,
  savings_account.status 
FROM
  (
    savings_account NATURAL
    JOIN savings_account_plan
  ) NATURAL
  JOIN branch;

CREATE
OR REPLACE VIEW `customer_view_checking_accounts` AS
SELECT
  checking_account_id,
  customer_id,
  started_date,
  branch_name,
  bank_balance,
  checking_account.status 
FROM
  (checking_account NATURAL JOIN branch);

CREATE
OR REPLACE VIEW `customer_view_fixed_deposits` AS
SELECT
  fixed_deposit_id,
  plan_name,
  fixed_deposit.customer_id,
  branch_name,
  deposit_amount,
  account_period_in_months,
  interest_rate,
  fixed_deposit.savings_account_id,
  bank_balance,
  fixed_deposit.status 
FROM
  ((
    fixed_deposit NATURAL
    JOIN fixed_deposit_plan
  ) NATURAL
  JOIN branch) JOIN savings_account ON (savings_account.savings_account_id = fixed_deposit.savings_account_id);

CREATE
OR REPLACE VIEW `all_savings_accounts` AS
SELECT
  savings_account_id,
  customer_id,
  branch_id,
  branch_name,
  bank_balance,
  plan_name,
  started_date,
  interest_rate,
  monthly_addition,
  max_withdrawal_limit,
  no_of_withdrawals_remaining,
  savings_account.status 
FROM
  (
    savings_account NATURAL
    JOIN savings_account_plan
  ) NATURAL
  JOIN branch;

CREATE
OR REPLACE VIEW `all_checking_accounts` AS
SELECT
  checking_account_id,
  customer_id,
  branch_id,
  started_date,
  branch_name,
  bank_balance,
  checking_account.status 
FROM
  (checking_account NATURAL JOIN branch);

CREATE
OR REPLACE VIEW `all_fixed_deposits` AS
SELECT
  fixed_deposit_id,
  plan_name,
  fixed_deposit.customer_id,
  branch_name,
  branch.branch_id,
  fixed_deposit.started_date,
  deposit_amount,
  account_period_in_months,
  interest_rate,
  fixed_deposit.monthly_addition,
  fixed_deposit.savings_account_id,
  bank_balance,
  fixed_deposit.status 
FROM
  ((
    fixed_deposit NATURAL
    JOIN fixed_deposit_plan
  ) NATURAL
  JOIN branch) JOIN savings_account ON (savings_account.savings_account_id = fixed_deposit.savings_account_id);

CREATE OR REPLACE VIEW `normal_loan_installment_information` AS
SELECT * FROM `normal_loan` NATURAL JOIN `loan_installment`;

CREATE OR REPLACE VIEW `online_loan_installment_information` AS
SELECT * FROM `online_loan` NATURAL JOIN `loan_installment`;

CREATE OR REPLACE VIEW `late_loan_information_more` AS
SELECT `loan_id`,`branch_id` FROM online_loan
UNION
SELECT `loan_id`,`branch_id` FROM normal_loan;


-- Not used anywhere
CREATE OR REPLACE VIEW `normal_loan_information` AS 
SELECT normal_loan.loan_id, normal_loan.customer_id,branch.branch_name, normal_loan.loan_installment, normal_loan.loan_amount, normal_loan.status,loan_plan.interest_rate,loan_plan.loan_period_in_months 
FROM normal_loan JOIN loan_plan ON normal_loan.loan_plan_id=loan_plan.loan_plan_id JOIN branch ON normal_loan.branch_id=branch.branch_id;

CREATE OR REPLACE VIEW transaction_information AS
SELECT `transaction_id`, `date`, `initiating_account_id`, `receiving_account_id`, `transaction_amount`,transactional_table.branch_id FROM 
transaction JOIN transactional_table ON transaction.initiating_account_id = transactional_table.account_id;

CREATE OR REPLACE VIEW `late_loan_information` AS
SELECT  `loan_installment`.`installment_id`, loan_installment.loan_id, `due_date`, `loan_installment`, `remaining_no_of_installments`,`due_month`, `due_year`, `status` ,`branch_id`
FROM loan_installment JOIN late_loan_installment 
ON (loan_installment.installment_id = late_loan_installment.installment_id) JOIN late_loan_information_more ON (loan_installment.loan_id = late_loan_information_more.loan_id);



