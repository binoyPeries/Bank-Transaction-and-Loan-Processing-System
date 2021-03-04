
create database bank;

use bank;
CREATE TABLE `branch` (
  `branch_id` INT NOT NULL AUTO_INCREMENT,
  `branch_name` VARCHAR(50) NOT NULL,
  `branch_address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`branch_id`)
);

CREATE TABLE `branch_manager` (
  `manager_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(50) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `salary` NUMERIC(9, 2) NOT NULL,
  `date_of_employment` DATE NOT NULL,
  `branch_id` INT NOT NULL,
  `email` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`manager_id`),
  FOREIGN KEY (`branch_id`) REFERENCES branch(`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE branch_manager ADD INDEX  (`email`);

CREATE TABLE `employee` (
  `employee_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(30) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `branch_id` INT NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `salary` NUMERIC(9, 2) NOT NULL,
  `date_of_employment` DATE NOT NULL,
  `email` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`employee_id`),
  FOREIGN KEY (`branch_id`) REFERENCES branch(`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE employee ADD INDEX  (`email`);

CREATE TABLE `customer`(
  customer_id INT NOT NULL,
  account_type ENUM("Individual", "Corporate") NOT NULL ,
  PRIMARY KEY (`customer_id`),
  CHECK (
    account_type IN ('Individual', 'Corporate')
  )
);

ALTER TABLE customer ADD INDEX  (`account_type`);


CREATE TABLE `individual_customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(40) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `national_ID` VARCHAR(10) NOT NULL,
  `date_of_birth` DATE  NOT NULL,
  `residential_contact_no` VARCHAR(10) NOT NULL,
  `personal_contact_no` VARCHAR(10) NOT NULL,
  `date_joined` DATE  NOT NULL,
  `email` VARCHAR(50) NOT NULL UNIQUE,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`customer_id`),
  FOREIGN KEY(`customer_id`) REFERENCES customer(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE individual_customer AUTO_INCREMENT = 100001;
ALTER TABLE individual_customer ADD INDEX  (`email`);


CREATE TABLE `corporate_customer` (
    `customer_id` INT NOT NULL AUTO_INCREMENT,
    `company_registration_number` VARCHAR(40) NOT NULL,
    `company_name` VARCHAR(40) NOT NULL,
    `corporate_email` VARCHAR(50) NOT NULL UNIQUE,
    `address` VARCHAR(100) NOT NULL,
    `date_of_establishment` DATE  NOT NULL,
    `contact_no` VARCHAR(10) NOT NULL,
    `date_joined` DATE  NOT NULL,
    `correspondent` VARCHAR(40) NOT NULL,
    `correspondent_email` VARCHAR(50) NOT NULL,
    `password` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`customer_id`),
    FOREIGN KEY(`customer_id`) REFERENCES customer(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
  );
ALTER TABLE corporate_customer AUTO_INCREMENT = 200001;
ALTER TABLE corporate_customer ADD INDEX  (`corporate_email`);
ALTER TABLE corporate_customer ADD INDEX (`correspondent_email`);


CREATE TABLE `savings_account_plan`(
    `savings_plan_id` INT NOT NULL AUTO_INCREMENT ,
    `plan_name` VARCHAR(10) NOT NULL,
    `interest_rate` NUMERIC(4, 2) NOT NULL,
    `minimum_required_balance` NUMERIC(6, 2) NOT NULL,
    PRIMARY KEY (`savings_plan_id`)
  );
CREATE TABLE `savings_account` (
    `savings_account_id` INT NOT NULL AUTO_INCREMENT,
    `branch_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `started_date` DATE NOT NULL,
    `bank_balance` NUMERIC(12, 2) NOT NULL,
    `no_of_withdrawals_remaining` INT NOT NULL,
    `savings_plan_id` INT NOT NULL,
    `max_withdrawal_limit` NUMERIC (9, 2) NOT NULL,
    `status` ENUM("Open", "Closed") DEFAULT "Open" NOT  NULL ,
    `monthly_addition` NUMERIC (9,2) NOT NULL ,
    `source_of_funds` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`savings_account_id`),
    FOREIGN KEY (`branch_id`) REFERENCES branch(`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`customer_id`) REFERENCES customer(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`savings_plan_id`) REFERENCES savings_account_plan(`savings_plan_id`) ON DELETE CASCADE ON UPDATE CASCADE
  );
ALTER TABLE savings_account AUTO_INCREMENT = 600001;
ALTER TABLE savings_account ADD INDEX  (`branch_id`);
ALTER TABLE savings_account ADD INDEX  (`customer_id`);




CREATE TABLE `checking_account` (
    `checking_account_id` INT NOT NULL AUTO_INCREMENT,
    `branch_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `started_date` DATE NOT NULL,
    `bank_balance` NUMERIC(12, 2) NOT NULL,
    `status` ENUM("Open", "Closed") DEFAULT "Open" NOT NULL ,
    PRIMARY KEY (`checking_account_id`),
    FOREIGN KEY (`branch_id`) REFERENCES branch(`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`customer_id`) REFERENCES customer(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE
  );
ALTER TABLE checking_account AUTO_INCREMENT = 700001;
ALTER TABLE checking_account ADD INDEX  (`branch_id`);
ALTER TABLE checking_account ADD INDEX  (`customer_id`);


CREATE TABLE `fixed_deposit_plan`(
  `fixed_deposit_plan_id` INT NOT NULL AUTO_INCREMENT ,
  `plan_name` VARCHAR(10) NOT NULL,
  `interest_rate` NUMERIC(4,2) NOT NULL,
  `account_period_in_months` INT NOT NULL,
  PRIMARY KEY (`fixed_deposit_plan_id`)
);

CREATE TABLE `fixed_deposit` (
  `fixed_deposit_id` INT NOT NULL AUTO_INCREMENT,
  `fixed_deposit_plan_id` INT NOT NULL,
  `branch_id` INT NOT NULL,
  `savings_account_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `deposit_amount` NUMERIC(12,2) NOT NULL,
  `started_date` DATE NOT NULL,
  `monthly_addition` NUMERIC (9,2) NOT NULL ,
  `status` ENUM("Open", "Closed") DEFAULT "Open" NOT NULL ,
  PRIMARY KEY (`fixed_deposit_id`),
  FOREIGN KEY (`branch_id`) REFERENCES branch(`branch_id`),
  FOREIGN KEY (`customer_id`) REFERENCES customer(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`fixed_deposit_plan_id`) REFERENCES fixed_deposit_plan(`fixed_deposit_plan_id`)  ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`savings_account_id`) REFERENCES savings_account(`savings_account_id`)  ON DELETE CASCADE ON UPDATE CASCADE
);
ALTER TABLE fixed_deposit AUTO_INCREMENT= 800001;
ALTER TABLE fixed_deposit ADD INDEX  (`customer_id`);
ALTER TABLE fixed_deposit ADD INDEX  (`branch_id`);


-- DEPOSITS TABLE --
CREATE TABLE `deposit` (
  `deposit_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `account_id` INT NOT NULL,
  `amount` NUMERIC (9, 2) NOT NULL,
  PRIMARY KEY (`deposit_id`),
  FOREIGN KEY (`account_id`) REFERENCES savings_account(`savings_account_id`)  ON DELETE RESTRICT  ON UPDATE RESTRICT 

);
ALTER TABLE deposit AUTO_INCREMENT= 70000001;
ALTER TABLE deposit ADD INDEX  (`account_id`);
ALTER TABLE deposit ADD INDEX  (`date`);

-- WITHDRAWALS TABLE --
CREATE TABLE `withdrawal` (
  `withdrawal_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `account_id` INT NOT NULL,
  `amount` decimal(9, 2) NOT NULL,
  PRIMARY KEY (`withdrawal_id`),
  FOREIGN KEY (`account_id`) REFERENCES savings_account(`savings_account_id`)  ON DELETE RESTRICT  ON UPDATE RESTRICT 

);
ALTER TABLE withdrawal AUTO_INCREMENT= 80000001;
ALTER TABLE withdrawal ADD INDEX  (`account_id`);
ALTER TABLE withdrawal ADD INDEX  (`date`);

-- TRANSACTIONS TABLE --
CREATE TABLE `transactional_table` (
  `account_id` int(11) NOT NULL,
  `account_type` enum('Savings','Checking') NOT NULL,
  `branch_id` int(11) NOT NULL,
  PRIMARY KEY (`account_id`),
  FOREIGN KEY (`branch_id`) REFERENCES branch(`branch_id`)  ON DELETE RESTRICT  ON UPDATE RESTRICT 
);

ALTER TABLE transactional_table ADD INDEX  (`account_type`);

CREATE TABLE `transaction` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE  NOT NULL,
  `initiating_account_id` INT NOT NULL,
  `receiving_account_id` INT NOT NULL,
  `transaction_amount` NUMERIC(10,2) NOT NULL,
  PRIMARY KEY (`transaction_id`),
  FOREIGN KEY (`initiating_account_id`) REFERENCES transactional_table(`account_id`) ON DELETE RESTRICT  ON UPDATE RESTRICT ,
  FOREIGN KEY (`receiving_account_id`) REFERENCES transactional_table(`account_id`) ON DELETE RESTRICT  ON UPDATE RESTRICT 
);
ALTER TABLE transaction AUTO_INCREMENT= 90000001;
ALTER TABLE transaction ADD INDEX  (`date`);



CREATE TABLE `loan_plan`(
    `loan_plan_id` INT NOT NULL AUTO_INCREMENT,
    `plan_name` VARCHAR(10) NOT NULL,
    `interest_rate` NUMERIC(4, 2) NOT NULL,
    `loan_period_in_months` INT NOT NULL,
    PRIMARY KEY (`loan_plan_id`)
  );

CREATE TABLE `loan`(
    `loan_id` INT NOT NULL PRIMARY key,
    `loan_type` ENUM("Normal", "Online") NOT NULL 
  );

  
CREATE TABLE `normal_loan` (
    `loan_id` INT NOT NULL AUTO_INCREMENT,
    `loan_plan_id` INT NOT NULL,
    `account_id` VARCHAR(30) NOT NULL,
    `customer_id` INT NOT NULL,
    `branch_id` INT NOT NULL,
    `loan_installment` NUMERIC(12, 2) NOT NULL,
    `created_date` DATE NOT NULL,
    `loan_amount` NUMERIC(12, 2) NOT NULL,
    `status` ENUM('Pending','Rejected','Approved','Closed')  NOT NULL DEFAULT 'Pending',
    PRIMARY KEY (`loan_id`),
    FOREIGN KEY (`loan_id`) REFERENCES loan(`loan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`branch_id`) REFERENCES branch(`branch_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`customer_id`) REFERENCES customer(`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`loan_plan_id`) REFERENCES loan_plan(`loan_plan_id`) ON DELETE CASCADE ON UPDATE CASCADE
  );

ALTER TABLE normal_loan AUTO_INCREMENT = 400001;
ALTER TABLE normal_loan ADD INDEX  (`account_id`);
ALTER TABLE normal_loan ADD INDEX  (`customer_id`);
ALTER TABLE normal_loan ADD INDEX  (`branch_id`);

ALTER TABLE normal_loan ADD INDEX  (`status`);


CREATE TABLE `online_loan` (
    `loan_id` INT NOT NULL AUTO_INCREMENT,
    `loan_plan_id` INT NOT NULL,
    `fixed_deposit_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `branch_id` INT NOT NULL,
    `loan_installment` NUMERIC(12, 2) NOT NULL,
    `loan_amount` NUMERIC(8, 2) NOT NULL,
    `created_date` DATE NOT NULL,
    `status` ENUM("Open", "Closed") DEFAULT "Open",
    PRIMARY KEY (`loan_id`),
    FOREIGN KEY (`loan_id`) REFERENCES loan(`loan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`fixed_deposit_id`) REFERENCES fixed_deposit(`fixed_deposit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`loan_plan_id`) REFERENCES loan_plan(`loan_plan_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`branch_id`) REFERENCES branch(`branch_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
    CHECK ((`loan_amount` <= 500000.00))
  );
ALTER TABLE online_loan AUTO_INCREMENT = 500001;
ALTER TABLE online_loan ADD INDEX  (`fixed_deposit_id`);
ALTER TABLE online_loan ADD INDEX  (`customer_id`);
ALTER TABLE online_loan ADD INDEX  (`branch_id`);

CREATE TABLE `loan_installment` (
    `installment_id` INT NOT NULL AUTO_INCREMENT,
    `loan_id` INT NOT NULL,
    `due_date` DATE NOT NULL,
    `loan_installment` NUMERIC(12, 2) NOT NULL,
    `remaining_no_of_installments` INT NOT NULL,
    PRIMARY KEY (`installment_id`),
    FOREIGN KEY (`loan_id`) REFERENCES loan(`loan_id`) ON DELETE CASCADE ON UPDATE CASCADE
  );
ALTER TABLE loan_installment AUTO_INCREMENT = 30000001;

CREATE TABLE `late_loan_installment` (
    `installment_id` INT NOT NULL,
    `due_month` INT DEFAULT MONTH(CURRENT_DATE),
    `due_year` INT DEFAULT YEAR(CURRENT_DATE) , 
    `status` ENUM("Paid", "Not paid") DEFAULT "Not paid",
    FOREIGN KEY (`installment_id`) REFERENCES loan_installment(`installment_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
  );
ALTER TABLE late_loan_installment ADD INDEX  (`due_month`);
ALTER TABLE late_loan_installment ADD INDEX  (`due_year`);