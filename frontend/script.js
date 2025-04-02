const express = require('express');
const app = express();
const port = 3000;


app.use(express.json());




app.get('/user/login', (req, res) => {
 
  res.send({ message: 'User login route' });
});


app.post('/user/create-new', (req, res) => {

  res.send({ message: 'New user created', data: req.body });
});


app.put('/user/update-user/:id', (req, res) => {

  res.send({ message: 'User updated', id: req.params.id, data: req.body });
});


app.delete('/user/delete-user/:id', (req, res) => {

  res.send({ message: 'User deleted', id: req.params.id });
});


app.get('/user/user-properties/:id', (req, res) => {

  res.send({ message: 'Properties for user', id: req.params.id });
});




app.get('/listing-properties/', (req, res) => {

  res.send({ message: 'All listing properties' });
});


app.get('/listing-properties/listing-properties/property/:id', (req, res) => {

  res.send({ message: 'Specific property details', id: req.params.id });
});


app.post('/listing-properties/listing-properties/listing', (req, res) => {

  res.send({ message: 'New listing created', data: req.body });
});


app.put('/listing-properties/listing/:id', (req, res) => {

  res.send({ message: 'Listing updated', id: req.params.id, data: req.body });
});


app.delete('/listing-properties/listing/:id', (req, res) => {

  res.send({ message: 'Listing deleted', id: req.params.id });
});


app.post('/contract/create-contract', (req, res) => {

  res.send({ message: 'Contract created', data: req.body });
});


app.get('/contract/user/:userID', (req, res) => {

  res.send({ message: 'Contracts for user', userID: req.params.userID });
});




app.get('/property/:id', (req, res) => {

  res.send({ message: 'Property details and reviews', id: req.params.id });
});

// POST: Post review
app.post('/property/post-review', (req, res) => {
  // TODO: Add review to property
  res.send({ message: 'Review posted', data: req.body });
});

/* ----- Payments Routes ----- */

// POST: Post payment details
app.post('/payments/', (req, res) => {
  // TODO: Process payment details
  res.send({ message: 'Payment processed', data: req.body });
});


app.get('/payments/user/:userID', (req, res) => {
 
  res.send({ message: 'Payment history for user', userID: req.params.userID });
});


app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
