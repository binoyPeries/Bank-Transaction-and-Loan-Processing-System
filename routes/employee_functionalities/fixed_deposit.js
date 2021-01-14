const express = require('express');
const router = express.Router();
const { createFixedDeposit } = require('../../controllers/employee_functionalities/fixed_deposit');

/**
 * @todo : add html file
 */

// route to create new savings account
router.post('/create', createFixedDeposit);


module.exports = router;



