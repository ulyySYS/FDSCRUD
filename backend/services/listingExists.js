const express = require('express');
const db = require('../config/db');

const listingExists = async(ListingID) => {
    console.log("checking for lsiting")
    try{
        
        const [rows] = await db.query(
            'SELECT Count(*) from listing WHERE ListingID = ? ;',
            [ListingID]
        );
        console.log(rows[0]['Count(*)'])
        return rows[0]['Count(*)'];
    } catch (err) {
        console.log("error with checking if listing exists", err)
    }
}

module.exports = listingExists;