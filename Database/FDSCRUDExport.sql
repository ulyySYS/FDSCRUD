-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: fdscrud
-- ------------------------------------------------------
-- Server version	9.0.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `ContractID` int NOT NULL AUTO_INCREMENT,
  `ContractDate` date NOT NULL,
  `Terms` text NOT NULL,
  `ContractStatus` enum('Active','Completed','Cancelled') NOT NULL,
  `BuyerID` int NOT NULL,
  `PropertyID` int NOT NULL,
  `ContractType` enum('Sold','Rented') NOT NULL,
  PRIMARY KEY (`ContractID`),
  KEY `BuyerID` (`BuyerID`),
  KEY `PropertyID` (`PropertyID`),
  CONSTRAINT `contracts_ibfk_1` FOREIGN KEY (`BuyerID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `contracts_ibfk_2` FOREIGN KEY (`PropertyID`) REFERENCES `properties` (`PropertyID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (5,'2025-03-01','12-month lease with 2 months deposit.','Active',5,3,'Rented'),(6,'2025-03-02','6-month lease with monthly renewal.','Active',6,7,'Rented'),(7,'2025-03-03','1-year lease with upfront payment.','Active',8,11,'Rented'),(8,'2025-03-05','Full property purchase agreement.','Completed',4,2,'Sold'),(9,'2025-03-01','1-year lease with upfront payment.','Active',5,1,'Sold');
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documents`
--

DROP TABLE IF EXISTS `documents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `documents` (
  `DocumentID` int NOT NULL AUTO_INCREMENT,
  `PropertyID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `DocumentType` enum('Title Deed','Contract','ID Verification') NOT NULL,
  `DocumentDateCreated` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`DocumentID`),
  KEY `PropertyID` (`PropertyID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `properties` (`PropertyID`),
  CONSTRAINT `documents_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documents`
--

LOCK TABLES `documents` WRITE;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listing`
--

DROP TABLE IF EXISTS `listing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listing` (
  `ListingID` int NOT NULL AUTO_INCREMENT,
  `PropertyID` int NOT NULL,
  `ListingDate` datetime DEFAULT CURRENT_TIMESTAMP,
  `ExpiryDate` date NOT NULL,
  `ListingStatus` enum('Active','Sold','Expired') NOT NULL,
  `ListingType` enum('Sale','Rent','Either') NOT NULL,
  `SellerID` int NOT NULL,
  `AgentID` int NOT NULL,
  PRIMARY KEY (`ListingID`),
  KEY `PropertyID` (`PropertyID`),
  KEY `SellerID` (`SellerID`),
  KEY `AgentID` (`AgentID`),
  CONSTRAINT `listing_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `properties` (`PropertyID`),
  CONSTRAINT `listing_ibfk_2` FOREIGN KEY (`SellerID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `listing_ibfk_3` FOREIGN KEY (`AgentID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listing`
--

LOCK TABLES `listing` WRITE;
/*!40000 ALTER TABLE `listing` DISABLE KEYS */;
INSERT INTO `listing` VALUES (1,3,'2025-03-01 00:00:00','2025-06-01','Active','Rent',6,2),(2,6,'2025-03-02 00:00:00','2025-06-02','Active','Rent',5,1),(3,9,'2025-03-03 00:00:00','2025-06-03','Active','Rent',4,3),(4,13,'2025-03-04 00:00:00','2025-06-04','Active','Rent',4,2),(5,1,'2025-03-05 00:00:00','2025-09-05','Active','Sale',5,1),(6,2,'2025-03-06 00:00:00','2025-09-06','Active','Sale',6,2),(7,4,'2025-03-07 00:00:00','2025-09-07','Active','Either',5,3),(8,5,'2025-03-08 00:00:00','2025-09-08','Active','Either',6,1),(9,7,'2025-03-09 00:00:00','2025-09-09','Active','Sale',4,3),(10,8,'2025-03-10 00:00:00','2025-09-10','Active','Sale',4,1),(11,10,'2025-03-11 00:00:00','2025-09-11','Active','Sale',4,3),(12,11,'2025-03-12 00:00:00','2025-09-12','Active','Sale',5,2),(13,12,'2025-03-13 00:00:00','2025-09-13','Sold','Sale',6,3),(14,14,'2025-03-14 00:00:00','2025-09-14','Active','Sale',6,1),(15,15,'2025-03-15 00:00:00','2025-09-15','Active','Sale',4,1),(16,16,'2025-03-16 00:00:00','2025-09-16','Active','Sale',4,2),(17,17,'2025-03-17 00:00:00','2025-09-17','Active','Sale',5,2),(18,18,'2025-03-18 00:00:00','2025-09-18','Active','Sale',5,3);
/*!40000 ALTER TABLE `listing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `Amount` decimal(15,2) NOT NULL,
  `PaymentType` enum('Down Payment','Full Purchase') NOT NULL,
  `PaymentDate` date NOT NULL,
  `PaymentMethod` enum('Credit Card','Bank Transfer','Cash') NOT NULL,
  `TransactionStatus` enum('Pending','Completed','Failed') NOT NULL,
  `PropertyID` int NOT NULL,
  `BuyerID` int NOT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `PropertyID` (`PropertyID`),
  KEY `BuyerID` (`BuyerID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`PropertyID`) REFERENCES `properties` (`PropertyID`),
  CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`BuyerID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,4500000.00,'Full Purchase','2025-03-05','Bank Transfer','Completed',2,4),(2,24000.00,'Down Payment','2025-03-01','Cash','Completed',3,5),(3,18000.00,'Down Payment','2025-03-02','Credit Card','Completed',7,6),(4,30000.00,'Down Payment','2025-03-03','Bank Transfer','Completed',11,8),(5,18000.00,'Down Payment','2025-03-02','Credit Card','Completed',7,6);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `PropertyID` int NOT NULL AUTO_INCREMENT,
  `Title` varchar(255) NOT NULL,
  `Description` text NOT NULL,
  `City` varchar(255) NOT NULL,
  `Address` text NOT NULL,
  `Price` decimal(15,2) NOT NULL,
  `Status` enum('Available','Sold','Renting','Pending') NOT NULL,
  `NumberOfBedrooms` int NOT NULL,
  `YearBuilt` int NOT NULL,
  `DatePosted` datetime DEFAULT CURRENT_TIMESTAMP,
  `PropertyType` enum('House','Condo','Apartment','Land') NOT NULL,
  `SquareFootage` decimal(10,2) NOT NULL,
  `OwnerID` int NOT NULL,
  PRIMARY KEY (`PropertyID`),
  KEY `OwnerID` (`OwnerID`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`OwnerID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,'Modern Family House','Spacious home perfect for families.','Davao City','123 Palm St.',3500000.00,'Available',4,2015,'2025-03-30 00:49:46','House',200.50,5),(2,'Luxury Condo','High-rise condo with great view.','Panabo City','45 Skyline Ave.',2800000.00,'Available',2,2020,'2025-03-30 00:49:46','Condo',80.00,6),(3,'Downtown Apartment','Close to all amenities.','Panabo City','99 Central Blvd.',18000.00,'Renting',1,2018,'2025-03-30 00:49:46','Apartment',50.00,6),(4,'Farmland Lot','Perfect for agriculture.','Panabo City','Brgy. Malagamot',900000.00,'Pending',0,2005,'2025-03-30 00:49:46','Land',1000.00,5),(5,'House with Garden','Cozy house with backyard.','Panabo City','10 Mabini St.',3200000.00,'Renting',3,2010,'2025-03-30 00:49:46','House',180.00,6),(6,'Urban Apartment','Modern design near city center.','Davao City','23 Quirino Ave.',22000.00,'Renting',2,2019,'2025-03-30 00:49:46','Apartment',55.00,5),(7,'Small Condo','Ideal for singles or couples.','Davao City','67 Luna St.',1900000.00,'Available',1,2021,'2025-03-30 00:49:46','Condo',65.00,4),(8,'Residential Lot','Clean title, good location.','Davao City','Barangay Matina',1100000.00,'Available',0,2000,'2025-03-30 00:49:46','Land',750.00,4),(9,'Studio Apartment','Compact and efficient.','Panabo City','8 Jacinto Ext.',16000.00,'Renting',1,2022,'2025-03-30 00:49:46','Apartment',40.00,4),(10,'Countryside Land','Peaceful location for retreat.','Panabo City','Sitio Mabuhay',600000.00,'Available',0,1998,'2025-03-30 00:49:46','Land',1200.00,4),(11,'Classic Bungalow','Timeless charm.','Davao City','34 Roxas Ave.',3000000.00,'Available',3,2007,'2025-03-30 00:49:46','House',160.00,5),(12,'Deluxe Condo','With pool access.','Davao City','89 Torres St.',2500000.00,'Sold',2,2020,'2025-03-30 00:49:46','Condo',85.00,6),(13,'Penthouse Apartment','Top floor, great view.','Panabo City','78 Sampaguita Rd.',25000.00,'Renting',2,2023,'2025-03-30 00:49:46','Apartment',60.00,4),(14,'Open Lot','Build your dream home.','Davao City','Lot 12, Tugbok',950000.00,'Available',0,2000,'2025-03-30 00:49:46','Land',900.00,6),(15,'Family House','Spacious 2-storey home.','Panabo City','56 Rizal St.',3600000.00,'Available',4,2016,'2025-03-30 00:49:46','House',210.00,5),(16,'Commercial Land','Good for business use.','Panabo City','National Highway',5000000.00,'Pending',0,2002,'2025-03-30 00:49:46','Land',1500.00,4),(17,'Minimalist House','Modern clean lines.','Davao City','Brgy. Buhangin',3300000.00,'Available',3,2017,'2025-03-30 00:49:46','House',175.00,5),(18,'Riverside Lot','Near riverbanks, quiet area.','Davao City','Purok Mabuhay',850000.00,'Available',0,2001,'2025-03-30 00:49:46','Land',950.00,5),(19,'Modern 3-Bedroom House','A beautiful modern house with spacious rooms and a large backyard.','Davao City','123 Palm Street, Davao City',8500000.00,'Available',3,2018,'2025-03-30 10:07:15','House',120.50,2);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviewsandratings`
--

DROP TABLE IF EXISTS `reviewsandratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviewsandratings` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `ReviewerID` int NOT NULL,
  `PropertyID` int NOT NULL,
  `Rating` int NOT NULL,
  `Comment` text NOT NULL,
  `Review_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReviewID`),
  KEY `ReviewerID` (`ReviewerID`),
  KEY `PropertyID` (`PropertyID`),
  CONSTRAINT `reviewsandratings_ibfk_1` FOREIGN KEY (`ReviewerID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `reviewsandratings_ibfk_2` FOREIGN KEY (`PropertyID`) REFERENCES `properties` (`PropertyID`),
  CONSTRAINT `reviewsandratings_chk_1` CHECK ((`Rating` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviewsandratings`
--

LOCK TABLES `reviewsandratings` WRITE;
/*!40000 ALTER TABLE `reviewsandratings` DISABLE KEYS */;
INSERT INTO `reviewsandratings` VALUES (1,4,2,5,'Smooth transaction, the house was in excellent condition.','2025-03-30 00:56:49'),(2,5,3,4,'Nice apartment, quiet neighborhood.','2025-03-30 00:57:13'),(3,9,3,3,'Decent place but a bit far from my workplace.','2025-03-30 00:57:13'),(4,6,7,5,'Loved the layout and amenities.','2025-03-30 00:57:39'),(5,10,7,4,'Convenient location and affordable rent.','2025-03-30 00:57:39'),(6,8,11,4,'Spacious and clean, great value.','2025-03-30 00:57:57'),(7,9,11,5,'Perfect for students, highly recommend.','2025-03-30 00:57:57'),(8,10,11,4,'Landlord was responsive and kind.','2025-03-30 00:57:57'),(9,9,11,4,'It was Aight','2025-03-30 16:24:39');
/*!40000 ALTER TABLE `reviewsandratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `ContactNumber` varchar(20) NOT NULL,
  `Role` enum('Buyer','Seller','Agent') NOT NULL,
  `City` text NOT NULL,
  `Createdate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `unique_email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Alice Santos','alice@example.com','pass123','09170000001','Agent','Davao City','2025-03-30 00:49:34'),(2,'Bob Reyes','bob@example.com','pass123','09170000002','Agent','Panabo City','2025-03-30 00:49:34'),(3,'Carla Gomez','carla@example.com','pass123','09170000003','Agent','Davao City','2025-03-30 00:49:34'),(4,'Daniel Cruz','daniel@example.com','pass123','09170000004','Seller','Panabo City','2025-03-30 00:49:34'),(5,'Ella Navarro','ella@example.com','pass123','09170000005','Seller','Davao City','2025-03-30 00:49:34'),(6,'Felix Tan','felix@example.com','pass123','09170000006','Seller','Panabo City','2025-03-30 00:49:34'),(7,'Gina Torres','gina@example.com','pass123','09170000007','Buyer','Davao City','2025-03-30 00:49:34'),(8,'Henry Lim','henry@example.com','pass123','09170000008','Buyer','Panabo City','2025-03-30 00:49:34'),(9,'Isabel Yu','isabel@example.com','pass123','09170000009','Buyer','Davao City','2025-03-30 00:49:34'),(10,'Jake Mendoza','jake@example.com','pass123','09170000010','Buyer','Panabo City','2025-03-30 00:49:34');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users2`
--

DROP TABLE IF EXISTS `users2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users2` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `ContactNumber` varchar(20) NOT NULL,
  `Role` enum('Buyer','Seller','Agent') NOT NULL,
  `City` text NOT NULL,
  `Createdate` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users2`
--

LOCK TABLES `users2` WRITE;
/*!40000 ALTER TABLE `users2` DISABLE KEYS */;
INSERT INTO `users2` VALUES (1,'Alice Santos','alice@example.com','pass123','09170000001','Agent','Davao City','2025-04-09 08:37:18'),(2,'Bob Reyes','bob@example.com','pass123','09170000002','Agent','Panabo City','2025-04-09 08:37:18'),(3,'Carla Gomez','carla@example.com','pass123','09170000003','Agent','Davao City','2025-04-09 08:37:18'),(4,'Daniel Cruz','daniel@example.com','pass123','09170000004','Seller','Panabo City','2025-04-09 08:37:18'),(5,'Ella Navarro','ella@example.com','pass123','09170000005','Seller','Davao City','2025-04-09 08:37:18'),(6,'Felix Tan','felix@example.com','pass123','09170000006','Seller','Panabo City','2025-04-09 08:37:18'),(7,'Gina Torres','gina@example.com','pass123','09170000007','Buyer','Davao City','2025-04-09 08:37:18'),(8,'Henry Lim','henry@example.com','pass123','09170000008','Buyer','Panabo City','2025-04-09 08:37:18'),(9,'Isabel Yu','isabel@example.com','pass123','09170000009','Buyer','Davao City','2025-04-09 08:37:18'),(11,'opaw lebronny','jkmamoguis@addu.edu.ph','pass123','091111111111','Buyer','wabad','2025-04-09 08:37:43');
/*!40000 ALTER TABLE `users2` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-09  8:44:37
