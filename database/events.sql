
-- DAILY EVENTS


-- 1
CREATE EVENT `update_monthly_addition_for_savings_accounts` ON SCHEDULE EVERY 1 DAY STARTS '2020-01-25 22:00:00' ON COMPLETION NOT PRESERVE ENABLE DO
UPDATE all_savings_accounts SET monthly_addition = monthly_addition + ( bank_balance * (interest_rate/(12*30*100)));


-- 2
CREATE EVENT `add_fd_interest_to_savings_account_balance_monthly` ON SCHEDULE EVERY 1 DAY STARTS '2020-01-25 22:00:00' ON COMPLETION NOT PRESERVE ENABLE DO 
UPDATE
  all_fixed_deposits
SET
  bank_balance = bank_balance + monthly_addition
  WHERE
  CEIL(DATEDIFF(NOW(), started_date) / 30) = DATEDIFF(NOW(), started_date) / 30;

-- 3
CREATE EVENT `transfer_to_late_loan_installment_table` ON SCHEDULE EVERY 1 DAY STARTS '2020-01-25 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO 
CALL check_for_late_installments();

DELIMITER $$
CREATE OR REPLACE PROCEDURE check_for_late_installments()
BEGIN 
  DECLARE `_rollback` BOOL DEFAULT 0;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;
  set AUTOCOMMIT = 0;
  START TRANSACTION;
  INSERT INTO `late_loan_installment` (`installment_id`) SELECT `installment_id` FROM `loan_installment` WHERE `due_date`<CURRENT_DATE;
  UPDATE loan_installment SET due_date = due_date+INTERVAL 30 DAY WHERE `due_date`<CURRENT_DATE;
  IF `_rollback` THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
END$$

-- 4
CREATE EVENT `reset_savings_account_withdrawal_limit` ON SCHEDULE EVERY 1 DAY STARTS '2020-01-25 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO
UPDATE
  all_savings_accounts
SET
  no_of_withdrawals_remaining = 5
WHERE
  CEIL(DATEDIFF(NOW(), started_date) / 30) = DATEDIFF(NOW(), started_date) / 30;


-- MONTHLY EVENTS
-- happens monthly on a date we pick (like the 27th)
-- happens after amount added to each account
-- EVENT

-- 5
CREATE EVENT `update_savings_account_balance_monthly` ON SCHEDULE EVERY 30 DAY STARTS '2020-01-25 22:00:00' ON COMPLETION NOT PRESERVE ENABLE DO
CALL update_savings_account_balance();

-- TODO:  ADD an event to reset the withdrawal limit of savings accounts


