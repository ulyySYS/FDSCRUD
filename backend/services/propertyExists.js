const express = require('express');
const db = require('../config/db');

const propertyExists = async(propertyid) => {
    console.log("checking for property")
    try{
        
        const [rows] = await db.query(
            'SELECT Count(*) from properties WHERE propertyid = ? ;',
            [propertyid]
        );
        console.log(rows[0]['Count(*)'])
        return rows[0]['Count(*)'];
    } catch (err) {
        console.log("error with checking if property exists", err)
    }
}

module.exports = propertyExists;