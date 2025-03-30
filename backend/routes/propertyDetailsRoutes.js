const express = require('express');
const router = express.Router();
const db = require('../config/db');
const propertyExists = require("../services/propertyExists")

// run when a property is clicked
router.get('/:id', async (req, res) => {
    const { id } = req.params
    try{
        const exist = await propertyExists(id)
        console.log(exist)
        const [property] = await db.query(
            'SELECT * from Properties WHERE PropertyID = ?',
            [id]
        ); 

        const [reviews] = await db.query(
            // use ` ` not ' ' when doing multi lines i guess
            `SELECT ReviewsAndRatings.*, Users.Name AS ReviewerName
             FROM ReviewsAndRatings
             JOIN Users ON ReviewsAndRatings.ReviewerID = Users.UserID
             WHERE ReviewsAndRatings.PropertyID = ?`,
            [id]
        );

        res.status(200).json({ message: 'successfully retrieved property data and reviews', property, reviews});

        
    } catch (err){
        console.log(err)
        res.status(500).json({ error: 'Server error' });
    }
})


router.post('/post-review', async (req, res) => {
    const { ReviewerID, propertID, Rating, Comment} = req.body
    try{
        const [result] = await db.query(
            `INSERT INTO ReviewsAndRatings (ReviewerID, PropertyID, Rating, Comment) 
             VALUES (?, ?, ?, ?)`,
            [ReviewerID, propertID, Rating, Comment]
        );
        res.status(201).json({ message: 'Review added successfully' });
    } catch (err){
        console.log(err)
    }
})


module.exports = router;