-- MySQL dump 10.13  Distrib 9.3.0, for macos15.2 (arm64)
--
-- Host: localhost    Database: db_ecommerce
-- ------------------------------------------------------
-- Server version	8.4.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Elettronica'),(2,'Moda'),(3,'Accessori'),(4,'Health'),(5,'Cura della persona');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marca`
--

DROP TABLE IF EXISTS `marca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marca` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marca`
--

LOCK TABLES `marca` WRITE;
/*!40000 ALTER TABLE `marca` DISABLE KEYS */;
INSERT INTO `marca` VALUES (1,'Apple'),(2,'Samsung'),(3,'Adidas'),(4,'Red bull'),(8,'Sony'),(9,'Xiaomi'),(10,'HP'),(11,'Zara'),(12,'Nike'),(13,'Adidas'),(14,'Fossil'),(15,'Garmin'),(16,'Fitbit'),(17,'Suunto'),(18,'Swisse'),(19,'BioTechUSA'),(20,'L’Oréal'),(21,'Nivea'),(22,'Gillette');
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine_prodotto`
--

DROP TABLE IF EXISTS `ordine_prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine_prodotto` (
  `ordine_id` bigint NOT NULL,
  `prodotto_id` int NOT NULL,
  PRIMARY KEY (`ordine_id`,`prodotto_id`),
  KEY `FKfq0s585f52itmew450cl804x0` (`prodotto_id`),
  CONSTRAINT `FKa6uja7ct2912x00h6eoefneny` FOREIGN KEY (`ordine_id`) REFERENCES `ordini` (`id`),
  CONSTRAINT `FKfq0s585f52itmew450cl804x0` FOREIGN KEY (`prodotto_id`) REFERENCES `prodotto` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine_prodotto`
--

LOCK TABLES `ordine_prodotto` WRITE;
/*!40000 ALTER TABLE `ordine_prodotto` DISABLE KEYS */;
INSERT INTO `ordine_prodotto` VALUES (1,82),(3,85),(4,88),(4,89),(8,90),(2,91),(5,92),(1,93),(7,93),(5,94),(7,95),(9,97),(6,103),(10,105);
/*!40000 ALTER TABLE `ordine_prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordini`
--

DROP TABLE IF EXISTS `ordini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordini` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `data_ordine` date DEFAULT NULL,
  `prezzo_totale` double DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKyc3mdr9xdlf6b282hawpix10` (`user_id`),
  CONSTRAINT `FKtjyptindibynniim7gjtyo93k` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordini`
--

LOCK TABLES `ordini` WRITE;
/*!40000 ALTER TABLE `ordini` DISABLE KEYS */;
INSERT INTO `ordini` VALUES (1,'2024-04-15',351.49,2),(2,'2024-04-16',229.9,3),(3,'2024-04-18',179.99,4),(4,'2024-04-20',499.99,5),(5,'2024-05-01',89.9,6),(6,'2024-05-03',29.9,7),(7,'2024-05-05',139.99,8),(8,'2024-05-06',179.9,9),(9,'2024-05-07',299,10),(10,'2024-05-10',3.99,11);
/*!40000 ALTER TABLE `ordini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `data_produzione` date NOT NULL,
  `descrizione` varchar(600) DEFAULT NULL,
  `nome` varchar(100) NOT NULL,
  `prezzo` double NOT NULL,
  `quantita` int NOT NULL,
  `categoria_id` int NOT NULL,
  `marca_id` int NOT NULL,
  `foto_path` varchar(255) DEFAULT NULL,
  `evidence` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp54y50a2i7pdiipduc60tttrw` (`categoria_id`),
  KEY `FKf6r71vff7d4upf38gxa21c0no` (`marca_id`),
  CONSTRAINT `FKf6r71vff7d4upf38gxa21c0no` FOREIGN KEY (`marca_id`) REFERENCES `marca` (`id`),
  CONSTRAINT `FKp54y50a2i7pdiipduc60tttrw` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1,'0025-06-12','12GB ram, 256 GB storage, Processore Exynos 800','Galaxy S24 Ultra',900,200,1,2,'s24ultra.jpg',_binary ''),(2,'0025-06-12','Chip apple silicon M1, 128 GB ssd, 12 GB ram','Macbook pro M1 13\"',1200.23,9,1,1,'prom1.jpeg',_binary '\0'),(81,'2024-04-10','Bevanda energetica per sportivi e studenti','Red Bull Energy Drink 250ml',1.5,120,4,4,'redbull.webp',_binary ''),(82,'2024-03-01','Cuffie wireless con cancellazione del rumore avanzata','Sony WH-1000XM5 Headphones',349.99,15,1,8,'sonyvh1000.jpeg',_binary '\0'),(83,'2024-05-20','Smartband con monitoraggio attivita e sonno','Xiaomi Mi Band 8',49.99,40,1,9,'xiaomiband.jpeg',_binary '\0'),(84,'2024-01-05','Notebook convertibile con touchscreen e AMD Ryzen','HP Envy x360 Laptop',899,10,1,10,'envy.jpeg',_binary '\0'),(85,'2024-05-09','Smartphone economico con batteria a lunga durata','Nokia G21 Smartphone',179.99,0,1,8,'nokia.jpeg',_binary ''),(86,'2024-03-30','Smartwatch sportivo con GPS avanzato','Garmin Forerunner 255',299.99,20,1,15,'garmin.jpeg',_binary '\0'),(87,'2024-05-01','Fitness tracker con sensori salute integrati','Fitbit Charge 6',149.99,30,1,16,'fitbit.jpeg',_binary ''),(88,'2022-11-11','Orologio multisport resistente e preciso','Suunto 9 Peak Pro',499.99,0,1,17,'suunto.webp',_binary ''),(89,'2024-01-15','Console di nuova generazione per gaming immersivo','Sony PlayStation 5',549,7,1,8,'ps5.jpg',_binary '\0'),(90,'2024-02-10','Monitor con risoluzione 1080p e pannello IPS','HP Monitor 27 Full HD',179.9,18,1,10,'hpmonitor.jpg',_binary '\0'),(91,'2024-03-08','Aspirapolvere intelligente con mappatura laser','Xiaomi Robot Vacuum S10',229.9,14,1,9,'xiaomivac.jpg',_binary '\0'),(92,'2024-03-12','Giacca elegante in tessuto tecnico','Zara Giacca Uomo',89.9,25,2,11,'zara.avif',_binary ''),(93,'2024-04-05','Sneaker iconiche con ammortizzazione Air','Nike Air Max 270',139.99,20,2,12,'nikeair.jpg',_binary '\0'),(94,'2024-03-22','Felpa comoda con logo frontale','Adidas Hoodie Essentials',59.99,30,2,3,'adihod.avif',_binary '\0'),(95,'2024-05-15','Pantaloni versatili con tasche multiple','Zara Pantaloni Cargo Donna',49.9,18,2,11,'zaracargo.jpg',_binary '\0'),(96,'2024-02-01','Borsa in pelle per uso quotidiano o lavoro','Fossil Borsa Messenger Uomo',129,10,3,14,'fossil.jpg',_binary '\0'),(97,'2024-04-22','Orologio ibrido elegante con funzionalita smart','Garmin Vivomove Trend',299,8,3,15,'vivo.jpeg',_binary '\0'),(98,'2024-03-28','Smartwatch con Wear OS e funzioni fitness','Fossil Orologio Smartwatch Gen 6',269,9,3,14,'fossilgen.jpg',_binary '\0'),(99,'2024-04-11','Zaino sportivo ideale per scuola o tempo libero','Adidas Zaino Classic',39.99,22,3,3,'adizaino.jpeg',_binary ''),(100,'2024-05-04','Cappellino traspirante per allenamento','Nike Cappello Pro Dri-FIT',24.99,50,3,12,'drifit.jpeg',_binary ''),(101,'2024-02-18','Integratore completo per il benessere maschile','Swisse Multivitaminico Uomo',14.9,60,4,18,'swisse.jpg',_binary '\0'),(102,'2024-03-20','Supporto per muscoli e sistema nervoso','Swisse Magnesio e Potassio',12.5,75,4,18,'swissemg.webp',_binary '\0'),(103,'2024-04-02','Proteine isolate senza zuccheri aggiunti','BioTechUSA Iso Whey Zero 908g',29.9,40,4,19,'bio.webp',_binary '\0'),(104,'2024-03-25','Aminoacidi ramificati per recupero muscolare','BioTechUSA BCAA 8-1-1',24.5,35,4,19,'biocaa.jpg',_binary '\0'),(105,'2024-05-05','Crema idratante per viso corpo e mani','Nivea Crema Soft 300ml',3.99,100,5,21,'niveasoft.webp',_binary '\0'),(106,'2024-03-30','Rasoio manuale con 5 lame e testina flessibile','Gillette Fusion5 Rasoio',11.99,60,5,22,'fusion.webp',_binary '\0'),(107,'2024-04-14','Shampoo nutriente per capelli lunghi','LOreal Shampoo Elvive Dream Long',4.5,80,5,20,'elvive.jpg',_binary ''),(108,'2024-03-18','Deodorante antialoni con protezione 48h','Nivea Deo Roll-on Black and White',2.99,90,5,21,'roll.jpeg',_binary '\0'),(109,'2024-05-10','Gel da barba lenitivo per pelli sensibili','Gillette Gel da Barba Sensitive',3.49,85,5,22,'gillettegel.png',_binary '\0'),(111,'2025-05-26','Gel da barba lenitivo per pelli sensibili','Gillette Gel da Barba Sensitive',3.49,0,5,22,'gel.jpg',_binary '\0'),(113,'2025-06-10','Crema idratante per viso corpo e mani','Nivea Crema Soft 300ml',3.99,2,5,21,'niveasoft.jpg',_binary '\0');
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKbjxn5ii7v7ygwx39et0wawu0q` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ADMIN'),(2,'USER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(60) NOT NULL,
  `name` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `username` varchar(30) NOT NULL,
  `sesso` enum('F','M') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKsb8bbouer5wak8vyiiy4pf2bx` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'raff.vallifuoco@gmail.com','Raffo','{noop}pass','profile2.png','RaffoV',NULL),(2,'mirko.onorato@gmail.com','Onorato Mirko','{noop}pass','profile2.png','mirko.onorato','M'),(3,'gino.visciano@gmail.com','Visciano Gino','{noop}pass','profile3.png','gino.visciano','M'),(4,'amelia.milone@gmail.com','Milone Amelia','{noop}pass','profile4.png','amelia.milone','F'),(5,'luigi.armarolo@gmail.com','Armarolo Luigi','{noop}pass','profile1.png','luigi.armarolo','M'),(6,'nicola.dangelo@gmail.com','Dangelo Nicola','{noop}pass','profile2.png','nicola.dangelo','M'),(7,'marcello.daniele@gmail.com','Daniele Marcello','{noop}pass','profile2.png','marcello.daniele','M'),(8,'antoniojoseph.diroberto@gmail.com','Di Roberto Antonio Joseph','{noop}pass','profile2.png','antoniojoseph.diroberto','M'),(9,'christian.esposito@gmail.com','Esposito Christian','{noop}pass','profile1.png','christian.esposito','M'),(10,'marco.granata@gmail.com','Granata Marco','{noop}pass','profile3.png','marco.granata','M'),(11,'tommaso.iovino@gmail.com','Iovino Tommaso','{noop}pass','profile1.png','tommaso.iovino','M'),(12,'fabrizio.lettieri@gmail.com','Lettieri Fabrizio','{noop}pass','profile3.png','fabrizio.lettieri','M'),(13,'paolo.mariani@gmail.com','Mariani Paolo','{noop}pass','profile1.png','paolo.mariani','M'),(14,'fiorella.pelli@gmail.com','Pelli Fiorella','{noop}pass','profile3.png','fiorella.pelli','F'),(15,'sabrina.saldamarco@gmail.com','Saldamarco Sabrina','{noop}pass','profile3.png','s','F'),(16,'giovanna.scuotto@gmail.com','Scuotto Giovanna','{noop}pass','profile3.png','giovanna.scuotto','F'),(17,'gerardo.tozio@gmail.com','Tozio Gerardo','{noop}pass','profile2.png','gerardo.tozio','M'),(200,'user.gmail.com','User','{noop}pass','profile1.png','User',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` int NOT NULL,
  `roles_id` int NOT NULL,
  PRIMARY KEY (`user_id`,`roles_id`),
  KEY `FKj9553ass9uctjrmh0gkqsmv0d` (`roles_id`),
  CONSTRAINT `FK55itppkw3i07do3h7qoclqd4k` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `FKj9553ass9uctjrmh0gkqsmv0d` FOREIGN KEY (`roles_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` VALUES (1,1),(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(8,2),(9,2),(10,2),(11,2),(12,2),(13,2),(14,2),(15,2),(16,2),(17,2),(200,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-26 10:36:39
