const express = require('express');
const router = express.Router();
const db = require('../config/db');
const propertyExists = require("../services/propertyExists")
const listingExists = require("../services/listingExists")


router.post('/create-contract', async (req, res) => {
    const { contractDate, terms, contractStatus, buyerID, propertyID,ContractType  } = req.body;

    try {
        // Check if the property exists 
        const propertExists = await propertyExists(propertyID);

        if (propertExists === 0) {
            res.status(404).json({ message: 'Property not found' });
        } else{
            const [property] = await db.query(
                `SELECT Status FROM Properties WHERE PropertyID = ?`,
                [propertyID]
            );

            // ends if property is not available
            if (property[0].Status != "Available") {
                return res.status(400).json({ message: 'Contracts can only be created for sold or rented properties' });
            } 
    
            // Insert the contract
            const [result] = await db.query(
                `INSERT INTO Contracts (ContractDate, Terms, ContractStatus, BuyerID, PropertyID) 
                VALUES (?, ?, ?, ?, ?)`,
                [contractDate, terms, contractStatus, buyerID, propertyID, ContractType ]
            );
    
            res.status(201).json({ message: 'Contract created successfully', contractID: result.insertId });
        }

        
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
});

router.get('/buyer/:userID', async (req, res) => {
    const { userID } = req.params;

    try {
        const [rows] = await db.query(
            `SELECT * FROM Contracts WHERE BuyerID = ?`,
            [userID]
        );

        if (rows.length === 0) {
            return res.status(404).json({ message: 'No contracts found for this user' });
        }

        res.status(200).json(rows);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
});





module.exports = router;