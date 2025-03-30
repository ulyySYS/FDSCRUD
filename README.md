Routes
  "/user/login" -> (get) user login
  "/user/create-new" ->(post)  create new user
  "/user/update-user/:id" -> (put) update user info
  "/user/delete-user/:id" ->  (delete) delete user
  "/user/user-properties/:id" -> (get) gets all properties of the user
  "/listing-properties/" -> (get) gets all properties in listing table
  "/listing-properties/listing-properties/property/:id" -> (get) get a specific property
  "/listing-properties/listing-properties/listing" -> (post) posting a new listing
  "/listing-properties/listing/:id" -> (puts) update a property in listing
  "/listing-properties/listing/:id" -> (delete) delete a property in listing
  "/contract/create-contract" -> (post) Create contract
  "/contract/user/:userID" -> (get) gets all contracts made by the user
  "/property/:id" -> (get) get property info and details including reviews
  "/property/post-review" -> (post) Post review
  "/payments/" -> (post)  post payment details
  "/payments/user/:userID" -> (get) get payment history of user
  
