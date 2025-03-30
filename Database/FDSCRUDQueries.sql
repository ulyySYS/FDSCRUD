create database FDSCRUD;
use FDSCRUD;

CREATE TABLE Users (
    UserID INT PRIMARY KEY auto_increment,
    Name VARCHAR(255) not null,
    Email VARCHAR(255) not null unique,
    Password varchar(255) not null,
    ContactNumber VARCHAR(20) not null, 
    Role ENUM('Buyer', 'Seller', 'Agent') not null,
    City TEXT not null,
    Createdate datetime default current_timestamp
);

CREATE TABLE Properties (
    PropertyID INT PRIMARY KEY auto_increment,
    Title Varchar(255) not null,
    Description Text not null,
    City varchar(255) not null,
    Address TEXT not null,
    Price DECIMAL(15,2) not null,
    Status ENUM('Available', 'Sold', 'Renting', 'Pending') not null,
    NumberOfBedrooms INT not null,
    YearBuilt INT not null,
    DatePosted DATETIME DEFAULT CURRENT_TIMESTAMP,
    PropertyType ENUM('House', 'Condo', 'Apartment', 'Land') not null,
    SquareFootage DECIMAL(10,2) not null,
    OwnerID INT not null,
    FOREIGN KEY (OwnerID) REFERENCES Users(UserID)
);

CREATE TABLE Listing (
    ListingID INT PRIMARY KEY auto_increment,
    PropertyID INT not null,
    ListingDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ExpiryDate DATE not null,
    ListingStatus ENUM('Active', 'Sold', 'Expired') not null,
	ListingType ENUM('Sale', 'Rent', 'Either') not null,
	SellerID INT not null,
    AgentID INT not null,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (SellerID) REFERENCES Users(UserID),
	FOREIGN KEY (AgentID) REFERENCES Users(UserID)
);

CREATE TABLE Documents (
    DocumentID INT PRIMARY KEY auto_increment,
    PropertyID INT ,-- document must be for a property or a user
    UserID INT  ,-- document must be for a property or a user
    DocumentType ENUM('Title Deed', 'Contract', 'ID Verification') not null,
    DocumentDateCreated datetime default current_timestamp,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY auto_increment,
    Amount DECIMAL(15,2) not null,
    PaymentType ENUM('Down Payment', 'Full Purchase') not null,
    PaymentDate DATE not null,
    PaymentMethod ENUM('Credit Card', 'Bank Transfer', 'Cash') not null,
    TransactionStatus ENUM('Pending', 'Completed', 'Failed') not null,
    PropertyID INT not null,
    BuyerID INT not null,
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID),
	FOREIGN KEY (BuyerID) REFERENCES Users(UserID)
);

-- there should have been a column on what the contract is for (Sold or Rented)
CREATE TABLE Contracts (
    ContractID INT PRIMARY KEY auto_increment,
    ContractDate DATE not null,
    Terms TEXT not null,
    ContractStatus ENUM('Active', 'Completed', 'Cancelled') not null,
	BuyerID INT not null,
	PropertyID INT not null,
	FOREIGN KEY (BuyerID) REFERENCES Users(UserID),
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID)
);



CREATE TABLE ReviewsAndRatings (
    ReviewID INT PRIMARY KEY auto_increment,
    ReviewerID INT not null,
    PropertyID INT not null,
    Rating INT CHECK (Rating BETWEEN 1 AND 5) not null,
    Comment TEXT not null,
    Review_date  datetime default current_timestamp,
    FOREIGN KEY (reviewerID) REFERENCES Users(UserID),
    FOREIGN KEY (PropertyID) REFERENCES Properties(PropertyID)
);

INSERT INTO Users (Name, Email, Password, ContactNumber, Role, City)
VALUES
('Alice Santos', 'alice@example.com', 'pass123', '09170000001', 'Agent', 'Davao City'),
('Bob Reyes', 'bob@example.com', 'pass123', '09170000002', 'Agent', 'Panabo City'),
('Carla Gomez', 'carla@example.com', 'pass123', '09170000003', 'Agent', 'Davao City'),
('Daniel Cruz', 'daniel@example.com', 'pass123', '09170000004', 'Seller', 'Panabo City'),
('Ella Navarro', 'ella@example.com', 'pass123', '09170000005', 'Seller', 'Davao City'),
('Felix Tan', 'felix@example.com', 'pass123', '09170000006', 'Seller', 'Panabo City'),
('Gina Torres', 'gina@example.com', 'pass123', '09170000007', 'Buyer', 'Davao City'),
('Henry Lim', 'henry@example.com', 'pass123', '09170000008', 'Buyer', 'Panabo City'),
('Isabel Yu', 'isabel@example.com', 'pass123', '09170000009', 'Buyer', 'Davao City'),
('Jake Mendoza', 'jake@example.com', 'pass123', '09170000010', 'Buyer', 'Panabo City');

INSERT INTO Properties (Title, Description, City, Address, Price, Status, NumberOfBedrooms, YearBuilt, PropertyType, SquareFootage, OwnerID)
VALUES
('Modern Family House', 'Spacious home perfect for families.', 'Davao City', '123 Palm St.', 3500000.00, 'Available', 4, 2015, 'House', 200.50, 5),
('Luxury Condo', 'High-rise condo with great view.', 'Panabo City', '45 Skyline Ave.', 2800000.00, 'Available', 2, 2020, 'Condo', 80.00, 6),
('Downtown Apartment', 'Close to all amenities.', 'Panabo City', '99 Central Blvd.', 18000.00, 'Renting', 1, 2018, 'Apartment', 50.00, 6),
('Farmland Lot', 'Perfect for agriculture.', 'Panabo City', 'Brgy. Malagamot', 900000.00, 'Pending', 0, 2005, 'Land', 1000.00, 5),
('House with Garden', 'Cozy house with backyard.', 'Panabo City', '10 Mabini St.', 3200000.00, 'Renting', 3, 2010, 'House', 180.00, 6),
('Urban Apartment', 'Modern design near city center.', 'Davao City', '23 Quirino Ave.', 22000.00, 'Renting', 2, 2019, 'Apartment', 55.00, 5),
('Small Condo', 'Ideal for singles or couples.', 'Davao City', '67 Luna St.', 1900000.00, 'Available', 1, 2021, 'Condo', 65.00, 4),
('Residential Lot', 'Clean title, good location.', 'Davao City', 'Barangay Matina', 1100000.00, 'Available', 0, 2000, 'Land', 750.00, 4),
('Studio Apartment', 'Compact and efficient.', 'Panabo City', '8 Jacinto Ext.', 16000.00, 'Renting', 1, 2022, 'Apartment', 40.00, 4),
('Countryside Land', 'Peaceful location for retreat.', 'Panabo City', 'Sitio Mabuhay', 600000.00, 'Available', 0, 1998, 'Land', 1200.00, 4),
('Classic Bungalow', 'Timeless charm.', 'Davao City', '34 Roxas Ave.', 3000000.00, 'Available', 3, 2007, 'House', 160.00, 5),
('Deluxe Condo', 'With pool access.', 'Davao City', '89 Torres St.', 2500000.00, 'Sold', 2, 2020, 'Condo', 85.00, 6),
('Penthouse Apartment', 'Top floor, great view.', 'Panabo City', '78 Sampaguita Rd.', 25000.00, 'Renting', 2, 2023, 'Apartment', 60.00, 4),
('Open Lot', 'Build your dream home.', 'Davao City', 'Lot 12, Tugbok', 950000.00, 'Available', 0, 2000, 'Land', 900.00, 6),
('Family House', 'Spacious 2-storey home.', 'Panabo City', '56 Rizal St.', 3600000.00, 'Available', 4, 2016, 'House', 210.00, 5),
('Commercial Land', 'Good for business use.', 'Panabo City', 'National Highway', 5000000.00, 'Pending', 0, 2002, 'Land', 1500.00, 4),
('Minimalist House', 'Modern clean lines.', 'Davao City', 'Brgy. Buhangin', 3300000.00, 'Available', 3, 2017, 'House', 175.00, 5),
('Riverside Lot', 'Near riverbanks, quiet area.', 'Davao City', 'Purok Mabuhay', 850000.00, 'Available', 0, 2001, 'Land', 950.00, 5);

INSERT INTO Listing (PropertyID, ListingDate, ExpiryDate, ListingStatus, ListingType, SellerID, AgentID)
VALUES
(3, '2025-03-01', '2025-06-01', 'Active', 'Rent', 6, 2),
(6, '2025-03-02', '2025-06-02', 'Active', 'Rent', 5, 1),
(9, '2025-03-03', '2025-06-03', 'Active', 'Rent', 4, 3),
(13, '2025-03-04', '2025-06-04', 'Active', 'Rent', 4, 2),
(1, '2025-03-05', '2025-09-05', 'Active', 'Sale', 5, 1),
(2, '2025-03-06', '2025-09-06', 'Active', 'Sale', 6, 2),
(4, '2025-03-07', '2025-09-07', 'Active', 'Either', 5, 3),
(5, '2025-03-08', '2025-09-08', 'Active', 'Either', 6, 1),
(7, '2025-03-09', '2025-09-09', 'Active', 'Sale', 4, 3),
(8, '2025-03-10', '2025-09-10', 'Active', 'Sale', 4, 1),
(10, '2025-03-11', '2025-09-11', 'Active', 'Sale', 4, 3),
(11, '2025-03-12', '2025-09-12', 'Active', 'Sale', 5, 2),
(12, '2025-03-13', '2025-09-13', 'Sold', 'Sale', 6, 3),
(14, '2025-03-14', '2025-09-14', 'Active', 'Sale', 6, 1),
(15, '2025-03-15', '2025-09-15', 'Active', 'Sale', 4, 1),
(16, '2025-03-16', '2025-09-16', 'Active', 'Sale', 4, 2),
(17, '2025-03-17', '2025-09-17', 'Active', 'Sale', 5, 2),
(18, '2025-03-18', '2025-09-18', 'Active', 'Sale', 5, 3);

-- Contracts for the Rented Apartments
INSERT INTO Contracts (ContractDate, Terms, ContractStatus, BuyerID, PropertyID, ContractType)
VALUES
('2025-03-01', '12-month lease with 2 months deposit.', 'Active', 5, 3, 'Rented'),  
('2025-03-02', '6-month lease with monthly renewal.', 'Active', 6, 7, 'Rented'),   
('2025-03-03', '1-year lease with upfront payment.', 'Active', 8, 11, 'Rented');   
select * from properties;
-- Contract for the Sold Property
INSERT INTO Contracts (ContractDate, Terms, ContractStatus, BuyerID, PropertyID, ContractType)
VALUES
('2025-03-05', 'Full property purchase agreement.', 'Completed', 4, 2, 'Sold');

desc contracts;
-- Payment for Sold House
INSERT INTO Payments (Amount, PaymentType, PaymentDate, PaymentMethod, TransactionStatus, PropertyID, BuyerID)
VALUES
(4500000.00, 'Full Purchase', '2025-03-05', 'Bank Transfer', 'Completed', 2, 4);

-- Payments for Rented Apartments
INSERT INTO Payments (Amount, PaymentType, PaymentDate, PaymentMethod, TransactionStatus, PropertyID, BuyerID)
VALUES
(24000.00, 'Down Payment', '2025-03-01', 'Cash', 'Completed', 3, 5),  
(18000.00, 'Down Payment', '2025-03-02', 'Credit Card', 'Completed', 7, 6), 
(30000.00, 'Down Payment', '2025-03-03', 'Bank Transfer', 'Completed', 11, 8); 

-- Review for the Sold house
INSERT INTO ReviewsAndRatings (ReviewerID, PropertyID, Rating, Comment)
VALUES
(4, 2, 5, 'Smooth transaction, the house was in excellent condition.');

-- Reviews for the first Rented Apartment 1 
INSERT INTO ReviewsAndRatings (ReviewerID, PropertyID, Rating, Comment)
VALUES
(5, 3, 4, 'Nice apartment, quiet neighborhood.'),
(9, 3, 3, 'Decent place but a bit far from my workplace.');

-- Reviews for the 2nd Apartment 2 
INSERT INTO ReviewsAndRatings (ReviewerID, PropertyID, Rating, Comment)
VALUES
(6, 7, 5, 'Loved the layout and amenities.'),
(10, 7, 4, 'Convenient location and affordable rent.');

-- Reviews for the 3rd Apartment 3 
INSERT INTO ReviewsAndRatings (ReviewerID, PropertyID, Rating, Comment)
VALUES
(8, 11, 4, 'Spacious and clean, great value.'),
(9, 11, 5, 'Perfect for students, highly recommend.'),
(10, 11, 4, 'Landlord was responsive and kind.');

ALTER TABLE Users
ADD CONSTRAINT unique_email UNIQUE (Email);

ALTER TABLE Listing 
MODIFY COLUMN ListingDate DATETIME DEFAULT CURRENT_TIMESTAMP;

INSERT INTO Properties (Title, Description, City, Address, Price, Status, NumberOfBedrooms, YearBuilt, DatePosted, PropertyType, SquareFootage, OwnerID) 
VALUES (
    'Modern 3-Bedroom House',
    'A beautiful modern house with spacious rooms and a large backyard.',
    'Davao City',
    '123 Palm Street, Davao City',
    8500000.00,
    'Available',
    3,
    2018,
    NOW(),
    'House',
    120.50,
    2
);

