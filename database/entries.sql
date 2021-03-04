-- Branch
INSERT INTO `branch`(`branch_id`, `branch_name`, `branch_address`) VALUES (1,"Malabe","Malabe");
INSERT INTO `branch`(`branch_id`, `branch_name`, `branch_address`) VALUES (2,"Kadawathe","Kadawathe");
INSERT INTO `branch`(`branch_id`, `branch_name`, `branch_address`) VALUES (3,"Pannipitiya","Pannipitiya");

-- Branch Manager

INSERT INTO `branch_manager`(`full_name`, `date_of_birth`, `address`, `salary`, `date_of_employment`, `branch_id`, `email`, `password`) 
VALUES ("Kevan Dissanayake","1988-02-10","270 River Lane, Kadawathe",1200000,"2020-02-18",1,"k1@gmail.com","$2a$04$Yc07OfjN5Vu5zXOtuwiiUeBjZpOGz6iS0cg./6piqZjBbRjpLl/lO");

INSERT INTO `branch_manager`(`full_name`, `date_of_birth`, `address`, `salary`, `date_of_employment`, `branch_id`, `email`, `password`) 
VALUES ("Sayuri Perera","1988-02-10","241/C/9, Siriputa, Thalawathugoda",500000,"2012-03-08",2,"sp@gmail.com","$2a$04$Yc07OfjN5Vu5zXOtuwiiUeBjZpOGz6iS0cg./6piqZjBbRjpLl/lO");

INSERT INTO `branch_manager`(`full_name`, `date_of_birth`, `address`, `salary`, `date_of_employment`, `branch_id`, `email`, `password`) 
VALUES ("Akashi Perera","1988-02-10","241/C/9, Siripura, Malabe",700000,"2012-03-08",3,"aka@gmail.com","$2a$04$Yc07OfjN5Vu5zXOtuwiiUeBjZpOGz6iS0cg./6piqZjBbRjpLl/lO");

-- Employee

INSERT INTO `employee`(`full_name`, `address`, `branch_id`, `date_of_birth`, `salary`, `date_of_employment`, `email`, `password`) 
VALUES ("Mewan Perera","N0 175, Sri Sumanatissa Mw, Colombo",1,"1999-10-12",10000,"2021-01-19","mewan@gmail.com","$2a$04$Yc07OfjN5Vu5zXOtuwiiUeBjZpOGz6iS0cg./6piqZjBbRjpLl/lO");

INSERT INTO `employee`(`full_name`, `address`, `branch_id`, `date_of_birth`, `salary`, `date_of_employment`, `email`, `password`) 
VALUES ("Dinushika Bandara","155/6 Wasala Road, 13, Colombo",1,"1989-10-12",20000,"2010-01-19","dinu@gmail.com","$2a$04$Yc07OfjN5Vu5zXOtuwiiUeBjZpOGz6iS0cg./6piqZjBbRjpLl/lO");

INSERT INTO `employee`(`full_name`, `address`, `branch_id`, `date_of_birth`, `salary`, `date_of_employment`, `email`, `password`) 
VALUES ("Gayani Sirisena","298 Main Street, Colombo 11",2,"1999-08-09",15000,"2018-05-19","gayani@gmail.com","$2a$04$Yc07OfjN5Vu5zXOtuwiiUeBjZpOGz6iS0cg./6piqZjBbRjpLl/lO");

INSERT INTO `employee`(`full_name`, `address`, `branch_id`, `date_of_birth`, `salary`, `date_of_employment`, `email`, `password`) 
VALUES ("Saduni Fernando","No. 36A, Shrubbery Gardens, Colombo",2,"2001-04-23",18000,"2021-01-19","saduni@gmail.com","$2a$04$Yc07OfjN5Vu5zXOtuwiiUeBjZpOGz6iS0cg./6piqZjBbRjpLl/lO");

INSERT INTO `employee`(`full_name`, `address`, `branch_id`, `date_of_birth`, `salary`, `date_of_employment`, `email`, `password`) 
VALUES ("Lasika Herath","712 Baseline Road, Colombo 09",3,"1998-11-23",21000,"2021-01-19","lasika@gmail.com","$2a$04$Yc07OfjN5Vu5zXOtuwiiUeBjZpOGz6iS0cg./6piqZjBbRjpLl/lO");

-- Savings Account Plans

INSERT INTO `savings_account_plan`( `plan_name`, `interest_rate`, `minimum_required_balance`) VALUES ("Children",12,0);
INSERT INTO `savings_account_plan`( `plan_name`, `interest_rate`, `minimum_required_balance`) VALUES ("Teen",11,500);
INSERT INTO `savings_account_plan`( `plan_name`, `interest_rate`, `minimum_required_balance`) VALUES ("Adult",10,1000);
INSERT INTO `savings_account_plan`( `plan_name`, `interest_rate`, `minimum_required_balance`) VALUES ("Senior",13,1000);

-- FD Plans

INSERT INTO `fixed_deposit_plan`( `plan_name`, `interest_rate`, `account_period_in_months`) VALUES ("Short-Term",13,6);
INSERT INTO `fixed_deposit_plan`( `plan_name`, `interest_rate`, `account_period_in_months`) VALUES ("Mid-Term",14,12);
INSERT INTO `fixed_deposit_plan`( `plan_name`, `interest_rate`, `account_period_in_months`) VALUES ("Long-Term",15,36);

-- Loan Plans

INSERT INTO `loan_plan`(`plan_name`, `interest_rate`, `loan_period_in_months`) VALUES ("Short-Term",13,12);
INSERT INTO `loan_plan`(`plan_name`, `interest_rate`, `loan_period_in_months`) VALUES ("Mid-Term",12,36);
INSERT INTO `loan_plan`(`plan_name`, `interest_rate`, `loan_period_in_months`) VALUES ("Long-Term",11,60);