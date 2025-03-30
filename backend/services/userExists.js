const express = require('express');
const db = require('../config/db');

const userExists = async(email) => {
    console.log("checking duplicates")
    try{
        
        const [rows] = await db.query(
            'SELECT Count(*) from Users WHERE email = ? ;',
            [email]
        );
        console.log(rows[0]['Count(*)'])
        return rows[0]['Count(*)'];
    } catch (err) {
        console.log("error with checking email duplicates", err)
    }
}

module.exports = userExists;