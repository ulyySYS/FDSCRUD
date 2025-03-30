const express = require('express');
const router = express.Router();
const db = require('../config/db');
const userExists = require("../services/userExists")

router.post('/', async (req, res) => {
    const { Amount, PaymentType, PaymentDate, PaymentMethod, TransactionStatus, PropertyID, BuyerID } = req.body;

    try {
        const [result] = await db.query(
            `INSERT INTO Payments (Amount, PaymentType, PaymentDate, PaymentMethod, TransactionStatus, PropertyID, BuyerID) 
             VALUES (?, ?, ?, ?, ?, ?, ?)`,
            [Amount, PaymentType, PaymentDate, PaymentMethod, TransactionStatus, PropertyID, BuyerID]
        );

        res.status(201).json({ message: 'Payment recorded successfully'});
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
});
 

// get payment history of the user
router.get('/user/:userID', async (req, res) => {
    const { userID } = req.params;

    try {
        const [payments] = await db.query(
            `SELECT Payments.*, Properties.Address AS PropertyAddress
             FROM Payments
             JOIN Properties ON Payments.PropertyID = Properties.PropertyID
             WHERE Payments.BuyerID = ?`,
            [userID]
        );

        res.status(200).json(payments);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
});

module.exports = router; 