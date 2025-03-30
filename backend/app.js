const express = require('express');
const userRoutes = require('./routes/userRoutes');
const listingsRoutes = require('./routes/listingsRoutes');
const contractRoutes = require('./routes/contractRoutes');
const propertyDetailsRoutes = require('./routes/propertyDetailsRoutes');
const paymentRoutes = require('./routes/paymentRoutes');

const app = express();
app.use(express.json());

app.use('/user', userRoutes);
app.use('/listing-properties', listingsRoutes);
app.use('/contract', contractRoutes);
app.use('/property', propertyDetailsRoutes);
app.use('/payments', paymentRoutes);

module.exports = app;