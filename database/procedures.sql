-- First, change the default delimiter to $$
-- Second, use (;) in the body of the stored procedure and $$ after the END keyword to end the stored procedure.
-- Third, change the default delimiter back to a semicolon (;)


-- TBD --

-- COMPLETED PROCEDURES THAT RUN FINE --
-- BRANCH MANAGER STUFF
DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_branch_manager` (
  `full_name` VARCHAR(50),
  `date_of_birth` DATE,
  `address`  VARCHAR(100),
  `salary` NUMERIC(9,2),
  `date_of_employment`  DATE,
  `branch_id` INT,
  `email` VARCHAR(50),
  `password` VARCHAR(100))
BEGIN
    set AUTOCOMMIT = 0;
    INSERT INTO `branch_manager` (`full_name`,`date_of_birth`,`address`,`salary` ,
    `date_of_employment`,`branch_id`,`email`,`password`) VALUES 
    (full_name,date_of_birth,address,salary,date_of_employment,branch_id,email,password);
    commit;
END$$

DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_employee` (
  `full_name` VARCHAR(30),
  `address` VARCHAR(100),
  `branch_id` INT,
  `date_of_birth` DATE,
  `salary` NUMERIC(9,2) ,
  `date_of_employment` DATE,
  `email` VARCHAR(50),
  `password` VARCHAR(100))
BEGIN
    set AUTOCOMMIT = 0;
    INSERT INTO `employee` (`full_name`,`address`,`branch_id`,`date_of_birth` ,
    `salary`,`date_of_employment`,`email`,`password`) VALUES 
    (full_name,address,branch_id,date_of_birth,salary,date_of_employment,email,password);
    commit;
END$$


-- EMPLOYEE STUFF 
DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_individual_customer` (
    IN `full_name` VARCHAR(20),
    IN `address` VARCHAR(100),
    IN `national_ID` VARCHAR(10),
    IN `date_of_birth` DATE,
    IN `residential_contact_no` VARCHAR(10),
    IN `personal_contact_no` VARCHAR(10),
    IN `date_joined` DATE,
    IN `email` VARCHAR(50),
    IN `password` VARCHAR(100))

BEGIN
    DECLARE id INT DEFAULT 0;
    START TRANSACTION;
        SELECT AUTO_INCREMENT INTO id FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'bank' AND TABLE_NAME = 'individual_customer'; 
        SELECT id;
        INSERT INTO `customer`(`customer_id`,`account_type`) VALUES (id, "Individual");
        INSERT INTO `individual_customer` (`full_name`,`address`,`national_ID`,`date_of_birth` ,`residential_contact_no`,`personal_contact_no`,`date_joined`,`email`,`password`) VALUES (full_name,address,national_ID,date_of_birth,residential_contact_no,personal_contact_no,date_joined,email,password);
        COMMIT;
END$$

DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_corporate_customer` (
  IN `company_registration_number` VARCHAR(40) ,
  IN `company_name` VARCHAR(20),
  IN `corporate_email` VARCHAR(50),
  IN `address` VARCHAR(100),
  IN `date_of_establishment` DATE,
  IN `contact_no` VARCHAR(10) ,
  IN `date_joined` DATE,
  IN `correspondent` VARCHAR(20) ,
  IN `correspondent_email` VARCHAR(50),
  IN `password` VARCHAR(100))
BEGIN
    DECLARE id INT DEFAULT 0;
    START TRANSACTION;
      SELECT AUTO_INCREMENT INTO id FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'bank' AND TABLE_NAME = 'corporate_customer';
      SELECT id;
      INSERT INTO `customer`(`customer_id`,`account_type`) VALUES (id, "Corporate");
      INSERT INTO `corporate_customer` (`company_registration_number`,`company_name`,`company_email`,`address` ,
      `date_of_establishment`,`contact_no`,`date_joined`,`correspondent`,`correspondent_email`,`password`) VALUES 
      (company_registration_number,company_name,company_email,address,date_of_establishment,contact_no,date_joined,correspondent,correspondent_email,password);
      COMMIT;
END$$

--CUSTOMER STUFF
DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_online_loan` (
    IN `loan_plan_id` INT ,
    IN `fixed_deposit_id` INT ,
    IN `customer_id` INT ,
    IN `branch_id` INT ,
    IN `loan_installment` NUMERIC(12, 2) ,
    IN `loan_amount` NUMERIC(8, 2) ,
    IN `created_date` DATE )

BEGIN
    DECLARE id INT DEFAULT 0;
    START TRANSACTION;
        SELECT AUTO_INCREMENT INTO id FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'bank' AND TABLE_NAME = 'online_loan'; 
        SELECT id;
        INSERT INTO `loan`(`loan_id`,`loan_type`) VALUES (id, "Online");
        INSERT INTO `online_loan` (`loan_plan_id`,`fixed_deposit_id`,`customer_id`,`branch_id`,`loan_installment`,`loan_amount`,`created_date`)  VALUES (loan_plan_id,fixed_deposit_id,customer_id,branch_id,loan_installment,loan_amount,created_date);
        COMMIT;
END$$


-- ACCOUNT STUFF
DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_savings_account` (
  IN `branch_id` INT,
  IN `customer_id` INT,
  IN `started_date` DATE ,
  IN `bank_balance` NUMERIC(12,2),
  IN `no_of_withdrawals_remaining` INT,
  IN `savings_plan_id` INT ,
  IN `max_withdrawal_limit` NUMERIC (9,2) ,
  IN `source_of_funds` VARCHAR(20) )
BEGIN
    DECLARE id INT DEFAULT 0;
    START TRANSACTION;
      SELECT AUTO_INCREMENT INTO id FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'bank' AND TABLE_NAME = 'savings_account';
      SELECT id;
      INSERT INTO transactional_table VALUES(id, "Savings");

      INSERT INTO `savings_account` (`branch_id`,`customer_id`,`started_date`,`bank_balance` ,
      `no_of_withdrawals_remaining`,`savings_plan_id`,`max_withdrawal_limit`,`source_of_funds`) VALUES 
      (branch_id,customer_id,started_date,bank_balance,no_of_withdrawals_remaining,savings_plan_id,max_withdrawal_limit,source_of_funds);
    commit;
END$$

DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_checking_account` (
  IN `customer_id` INT,
  IN `started_date` DATE ,
  IN `bank_balance` NUMERIC(12,2),
  IN `branch_id` INT)
BEGIN
    DECLARE id INT DEFAULT 0;
    START TRANSACTION;
      SELECT AUTO_INCREMENT INTO id FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'bank' AND TABLE_NAME = 'checking_account';
      SELECT id;
      INSERT INTO transactional_table VALUES(id, "Checking");
      INSERT INTO `checking_account` (`customer_id`,`started_date`,`bank_balance`,`branch_id`) VALUES (customer_id,started_date,bank_balance,branch_id);
    commit;
END$$


DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_fixed_deposit` (
  IN `fixed_deposit_plan_id` INT,
  IN `branch_id` INT,
  IN `savings_account_id` INT,
  IN `customer_id` INT,
  IN `deposit_amount` NUMERIC(12,2),
  IN `monthly_addition` NUMERIC(9, 2),
  IN `started_date` DATE)
BEGIN
    INSERT INTO `fixed_deposit` (`fixed_deposit_plan_id`,`branch_id`,`savings_account_id`,`customer_id`,`deposit_amount`,`monthly_addition`,`started_date`)
    VALUES (fixed_deposit_plan_id,branch_id,savings_account_id,customer_id,deposit_amount,monthly_addition,started_date);
    commit;
END$$

DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_normal_loan` (
  IN `loan_plan_id_1` INT,
  IN `account_id` INT,
  IN `customer_id` INT ,
  IN `branch_id` INT,
  IN `loan_installment` NUMERIC(12, 2),
  IN `created_date` DATE,
  IN `loan_amount` NUMERIC(12, 2))
BEGIN
    DECLARE id INT DEFAULT 0;
    START TRANSACTION;
      SELECT AUTO_INCREMENT INTO id FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'bank' AND TABLE_NAME = 'normal_loan';
      INSERT INTO `loan`(`loan_id`,`loan_type`) VALUES (id, "Normal");
      INSERT INTO `normal_loan`(`loan_plan_id_1`, `account_id`, `customer_id`, `branch_id`, `loan_installment`, `created_date`, `loan_amount`) 
      VALUES (loan_plan_id, account_id, customer_id, branch_id, loan_installment, created_date, loan_amount);
    COMMIT;
END$$

DELIMITER $$
CREATE OR REPLACE PROCEDURE `create_online_loan` (
  IN `loan_plan_id_1` INT,
  IN `fixed_deposit_id_1` INT,
  IN `customer_id_1` INT ,
  IN `branch_id_1` INT,
  IN `loan_installment_1` NUMERIC(12, 2),
  IN `loan_amount_1` NUMERIC(12, 2))
BEGIN
    DECLARE id INT DEFAULT 0;
    DECLARE months INT DEFAULT 0;
    START TRANSACTION;
      SELECT loan_id+1 INTO id FROM online_loan ORDER BY loan_id DESC;
      SELECT loan_period_in_months INTO months FROM loan_plan WHERE loan_plan_id = `loan_plan_id_1`;
      INSERT INTO `loan`(`loan_id`,`loan_type`) VALUES (id, "Online");
      INSERT INTO `online_loan`(`loan_plan_id`, `fixed_deposit_id`, `customer_id`, `branch_id`, `loan_installment`, `created_date`, `loan_amount`) 
      VALUES (loan_plan_id_1, fixed_deposit_id_1, customer_id_1, branch_id_1, loan_installment_1, CURRENT_DATE, loan_amount_1);
      INSERT INTO `loan_installment`(`loan_id`, `due_date`,`remaining_no_of_installments`) VALUES (id,CURRENT_DATE,months);
    COMMIT;
END$$

-- Money Transfer Between Savings Accounts--

DELIMITER $$
CREATE OR REPLACE PROCEDURE `savings_account_money_transfer` (
  IN `date_1` DATE,
  IN `initiating_account_id_1` INT ,
  IN `receiving_account_id_1` INT,
  IN `transaction_amount_1` decimal(10, 2))
BEGIN
  
  DECLARE inititating_account_balance decimal(12, 2) DEFAULT 0;
  DECLARE receiving_account_balance decimal(12, 2) DEFAULT 0;

  SELECT IFNULL(bank_balance,0)
  INTO   inititating_account_balance
  FROM   savings_account
  WHERE  savings_account_id = initiating_account_id_1;

  SELECT IFNULL(bank_balance,0)
  INTO   receiving_account_balance
  FROM   savings_account
  WHERE  savings_account_id = receiving_account_id_1;
  IF inititating_account_balance >= transaction_amount_1 THEN
    START TRANSACTION;

      UPDATE savings_account
      SET bank_balance = inititating_account_balance - transaction_amount_1
      WHERE savings_account_id = initiating_account_id_1;

      UPDATE savings_account
      SET bank_balance = receiving_account_balance + transaction_amount_1
      WHERE savings_account_id =   receiving_account_id_1;

      INSERT INTO transaction (date,initiating_account_id,receiving_account_id,transaction_amount) VALUES(date_1, initiating_account_id_1,receiving_account_id_1,transaction_amount_1);

    COMMIT;
  END IF;
END$$

-- Money Transfer Between Checking Accounts--

DELIMITER $$
CREATE OR REPLACE PROCEDURE `checking_account_money_transfer` (
  IN `date_1` DATE,
  IN `initiating_account_id_1` INT ,
  IN `receiving_account_id_1` INT,
  IN `transaction_amount_1` decimal(10, 2))
BEGIN
  
  DECLARE inititating_account_balance decimal(12, 2) DEFAULT 0;
  DECLARE receiving_account_balance decimal(12, 2) DEFAULT 0;

  SELECT IFNULL(bank_balance,0)
  INTO   inititating_account_balance
  FROM   checking_account
  WHERE  checking_account_id = initiating_account_id_1;

  SELECT IFNULL(bank_balance,0)
  INTO   receiving_account_balance
  FROM   checking_account
  WHERE  checking_account_id = receiving_account_id_1;
  IF inititating_account_balance >= transaction_amount_1 THEN
    START TRANSACTION;

      UPDATE checking_account
      SET bank_balance = inititating_account_balance - transaction_amount_1
      WHERE checking_account_id = initiating_account_id_1;

      UPDATE checking_account
      SET bank_balance = receiving_account_balance + transaction_amount_1
      WHERE checking_account_id =   receiving_account_id_1;

      INSERT INTO transaction (date,initiating_account_id,receiving_account_id,transaction_amount) VALUES(date_1, initiating_account_id_1,receiving_account_id_1,transaction_amount_1);

    COMMIT;
  END IF;
END$$


-- Money Withdrawal From Savings Account--

DELIMITER $$
CREATE OR REPLACE PROCEDURE `savings_account_money_withdrawal` (
  IN `date_1` DATE,
  IN `account_id_1` INT ,
  IN `withdrawal_amount` decimal(9, 2) )
BEGIN
  DECLARE account_balance decimal(12, 2) DEFAULT 0;
  DECLARE max_amount decimal(9, 2) DEFAULT 0;
  DECLARE withdrawals_left INT DEFAULT 0;
  DECLARE minimum_balance decimal(6, 2) DEFAULT 0;
  SELECT IFNULL(bank_balance,0)
  INTO   account_balance
  FROM   savings_account
  WHERE   savings_account_id= account_id_1;
  
  SELECT IFNULL(max_withdrawal_limit,0)
  INTO   max_amount
  FROM   savings_account
  WHERE  savings_account_id= account_id_1;

  SELECT IFNULL(no_of_withdrawals_remaining,0)
  INTO   withdrawals_left
  FROM   savings_account
  WHERE  savings_account_id= account_id_1;

  IF account_balance >= withdrawal_amount AND withdrawal_amount<=max_amount AND withdrawals_left>0 THEN
    START TRANSACTION;

      UPDATE savings_account
      SET bank_balance = account_balance - withdrawal_amount
      WHERE savings_account_id = account_id_1;

      UPDATE savings_account
      SET no_of_withdrawals_remaining = withdrawals_left - 1
      WHERE savings_account_id = account_id_1;
      INSERT INTO withdrawal (date, account_id,amount) VALUES(date_1,account_id_1,withdrawal_amount);

    COMMIT;
  END IF;
END$$

-- Money Withdrawal From Checking Account--

-- DELIMITER $$
-- CREATE OR REPLACE PROCEDURE `checking_account_money_withdrawal` (
--   IN `date_1` DATE,
--   IN `account_id_1` INT ,
--   IN `withdrawal_amount` decimal(9, 2) )
-- BEGIN
--   DECLARE account_balance decimal(12, 2) DEFAULT 0;
--   SELECT IFNULL(bank_balance,0)
--   INTO   account_balance
--   FROM   checking_account
--   WHERE  checking_account_id= account_id_1;
  
--   IF account_balance >= withdrawal_amount THEN
--     START TRANSACTION;

--       UPDATE checking_account
--       SET bank_balance = account_balance - withdrawal_amount
--       WHERE checking_account_id = account_id_1;
--       INSERT INTO withdrawal (date, account_id,amount) VALUES(date_1,account_id_1,withdrawal_amount);

--     COMMIT;
--   END IF;
-- END$$

-- -- Money Deposit Into Checking Account--

-- DELIMITER $$
-- CREATE OR REPLACE PROCEDURE `checking_account_money_deposit` (
--   IN `date_1` DATE,
--   IN `account_id_1` INT ,
--   IN `deposit_amount` decimal(9, 2) )
-- BEGIN
--   DECLARE account_balance decimal(12, 2) DEFAULT 0;
--   SELECT IFNULL(bank_balance,0)
--   INTO   account_balance
--   FROM   checking_account
--   WHERE  checking_account_id= account_id_1;
  
--     START TRANSACTION;

--       UPDATE checking_account
--       SET bank_balance = account_balance + deposit_amount
--       WHERE checking_account_id = account_id_1;
--       INSERT INTO withdrawal (date, account_id,amount) VALUES(date_1,account_id_1,deposit_amount);

--     COMMIT;
-- END$$


-- Money Deposit Into Savings Account--

DELIMITER $$
CREATE OR REPLACE PROCEDURE `savings_account_money_deposit` (
  IN `date_1` DATE,
  IN `account_id_1` INT ,
  IN `deposit_amount` decimal(9, 2) )
BEGIN
  DECLARE account_balance decimal(12, 2) DEFAULT 0;
  SELECT IFNULL(bank_balance,0)
  INTO   account_balance
  FROM   savings_account
  WHERE  savings_account_id= account_id_1;
  
    START TRANSACTION;

      UPDATE savings_account
      SET bank_balance = account_balance + deposit_amount
      WHERE savings_account_id = account_id_1;
      INSERT INTO deposit (date, account_id,amount) VALUES(date_1,account_id_1,deposit_amount);

    COMMIT;
END$$