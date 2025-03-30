const express = require('express');
const router = express.Router();
const db = require('../config/db');
const propertyExists = require("../services/propertyExists")
const listingExists = require("../services/listingExists")



router.get('/', async (req, res) => {
    try{
        const query = `
        SELECT 
            Properties.PropertyID,
            Properties.Title,
            Properties.Description,
            Properties.City,
            Properties.Address,
            Properties.Price,
            Properties.Status,
            Properties.NumberOfBedrooms,
            Properties.YearBuilt,
            Properties.DatePosted,
            Properties.PropertyType,
            Properties.SquareFootage,
            Users.Name AS OwnerName,
            Listing.ListingID,
            Listing.ListingDate,
            Listing.ExpiryDate,
            Listing.ListingStatus,
            Listing.ListingType,
            Seller.Name AS SellerName,
            Agent.Name AS AgentName
            
            FROM Properties
            JOIN Listing ON Properties.PropertyID = Listing.PropertyID
            JOIN Users AS Seller ON Listing.SellerID = Seller.UserID
            JOIN Users AS Agent ON Listing.AgentID = Agent.UserID
            JOIN Users ON Properties.OwnerID = Users.UserID;
    `;

    const [rows] = await db.query(query);
    console.log(rows);
    res.status(200).json({ message: 'listings retrieved', rows });
    } catch(err){
         console.error('Error fetching listed properties:', error);
        res.status(500).json({ error: 'Server error while fetching properties.' });
    }
});

// gets specific properties based on property ID
router.get('/property/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const exists = await propertyExists(id);

        if(exists === 1) {
            const [rows] = await db.query(
            'SELECT * FROM Properties WHERE PropertyID = ?',
            [id]
            );

            res.status(200).json({ message: 'property found', rows});

        }
        
            res.status(404).json({ message: 'Property not found' });
        
    } catch (err) {
        console.error('Error fetching property:', err);
        res.status(500).json({ error: 'Server error' });
    }
});


// posting a new listing
router.post('/listing', async (req, res) => {
    const { propertyID, expiryDate, listingStatus, listingType, sellerID, agentID } = req.body;

    try {
        // Insert the new listing
        const exists = await propertyExists(propertyID)
        console.log(exists)
        if(exists == 1){
            console.log("pass")
            const [result] = await db.query(
                `INSERT INTO Listing (PropertyID, ExpiryDate, ListingStatus, ListingType, SellerID, AgentID) 
                VALUES (?, ?, ?, ?, ?, ?)`,
                [propertyID, expiryDate, listingStatus, listingType, sellerID, agentID]
            );

            res.status(201).json({ message: 'Listing created successfully', listingID: result.insertId });
        } else{
            console.log("pass2")
            res.status(201).json({ message: 'Listing failed, property doesnt exist' });    
                    
        }
        
       
     
    } catch (err) {
        console.error('Error creating listing:', err);
        res.status(500).json({ error: 'Server error' });
    }
});

//update listing
router.put('/listing/:id', async (req, res) => {
    const { id } = req.params;
    const { expiryDate, listingStatus, listingType, sellerID, agentID } = req.body;

    try {
        const exists = await listingExists(id)
        if(exists == 1){
            const [result] = await db.query(
                        `UPDATE Listing 
                        SET ExpiryDate = ?, ListingStatus = ?, ListingType = ?, SellerID = ?, AgentID = ?
                        WHERE ListingID = ?`,
                        [expiryDate, listingStatus, listingType, sellerID, agentID, id]
                    );
             res.status(200).json({ message: 'Listing updated successfully' });
        } else{
             res.status(404).json({ message: 'Listing not found' });
        }
        
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
});

// delete listing
router.delete('/listing/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const exists = await listingExists(id);
        if(exists === 1){
            const [result] = await db.query(
                `DELETE FROM Listing WHERE ListingID = ?`,
                [id]
            );
            res.status(200).json({ message: 'Listing deleted successfully' });
        }
        else {
            res.status(404).json({ message: 'Listing not found' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
});


module.exports = router;