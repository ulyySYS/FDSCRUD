const express = require('express');
const router = express.Router();
const db = require('../config/db');
const userExists = require("../services/userExists")

router.get('/login', async (req, res) => {
    const { email, password } = req.query
    try{
        const [rows] = await db.query(
            'SELECT Count(*) from Users WHERE email = ? AND password = ?',
            [email, password]
        );

        if(rows[0]['Count(*)']){
            const [userInfo] = await db.query(
                'SELECT * from Users WHERE email = ? AND password = ?',
                [email, password]
            );
            res.status(200).json({ message: 'Login successful', userInfo});
        } else {
            res.status(200).json({ message: 'Invalid Credentials'});
        }
    } catch (err){
        console.log(err)
    }
})

router.get('/all-users', async (req, res) => {
    try {
        const [users] = await db.query('SELECT * FROM Users2');

        if (users.length > 0) {
            res.status(200).json({ message: 'Users fetched successfully', users });
        } else {
            res.status(404).json({ message: 'No users found' });
        }
    } catch (err) {
        console.error('Error fetching users:', err);
        res.status(500).json({ message: 'Server error' });
    }
});

router.post('/create-new', async (req, res) => {
    const { 
        name, 
        email,
        password,
        contactNumber,
        role,
        city
    } = req.body
    try{
        console.log(req.body)
        const exists = await userExists(email);
        if(exists == 0){
            const [rows] = await db.query(
                        `INSERT INTO Users2 (name, email, password, contactNumber, role, City) VALUES (?, ?, ?, ?, ?, ?)`,
        [name, email, password, contactNumber, role, city]
                    );

                    
            res.status(200).json({ message: 'Login successful'});
                   
        } else{
            res.status(200).json({ message: 'Email already in use'});
        }
       
        
    } catch (err){
        console.log(err)
    }
})

router.put('/update-user/:id', async (req, res) => {

    //  id here should equal userID
    const { id } = req.params;
    const { name, email, password, contactNumber, role, City } = req.body;

    try {
        const [result] = await db.query(
            `UPDATE Users2 SET name = ?, email = ?, password = ?, contactNumber = ?, role = ?, City = ? WHERE UserID = ?`,
            [name, email, password, contactNumber, role, City, id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.status(200).json({ message: 'User updated successfully' });
    } catch (err) {
        console.error('Error updating user:', err);
        res.status(500).json({ message: 'Server error' });
    }
});

router.delete('/delete-user/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const [result] = await db.query(
            `DELETE FROM Users2 WHERE UserID = ?`,
            [id]
        );

        if (result.affectedRows === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.status(200).json({ message: 'User deleted successfully' });
    } catch (err) {
        console.error('Error deleting user:', err);
        res.status(500).json({ message: 'Server error' });
    }
});

// Gets all the properties the user has added on the properties
router.get('/user-properties/:id', async (req, res) => {
    const { id } = req.params;

    try {
        const [properties] = await db.query(
            `SELECT Properties.*, Listing.ListingStatus, Listing.ListingType 
             FROM Properties
             JOIN Listing ON Properties.PropertyID = Listing.PropertyID
             WHERE Listing.SellerID = ?`,
            [id]
        );

        res.status(200).json(properties);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Server error' });
    }
});

module.exports = router; 