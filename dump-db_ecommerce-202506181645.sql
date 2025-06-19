-- MySQL dump 10.13  Distrib 9.3.0, for macos15.4 (arm64)
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
INSERT INTO `categoria` VALUES (1,'Elettronica'),(2,'Abbigliamento'),(3,'Casa'),(4,'Food'),(5,'Arredamento'),(6,'Cancelleria'),(7,'Alimentari'),(8,'Sport e Tempo Libero'),(9,'Salute e Bellezza'),(10,'Giocattoli'),(11,'Auto e Moto'),(12,'Informatica'),(13,'Libri'),(14,'Musica e Film'),(15,'Gioielli e Orologi'),(16,'Telefonia e Accessori'),(17,'Animali'),(18,'Giardinaggio'),(19,'Bricolage e Fai da te'),(20,'Strumenti Musicali'),(21,'Videogiochi');
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
INSERT INTO `marca` VALUES (1,'Apple'),(2,'Samsung'),(3,'Adidas'),(4,'Red bull'),(5,'Ikea'),(6,'Staedtler'),(7,'Nokia'),(8,'Sony'),(9,'Microsoft'),(10,'Nike'),(11,'HP'),(12,'Canon'),(13,'Lego'),(14,'Bosch'),(15,'Philips'),(16,'Panasonic'),(17,'Nestlé'),(18,'Barilla'),(19,'Amazon Basics'),(20,'Zara'),(21,'L\'Oréal'),(22,'PlayStation'),(23,'Nintendo'),(24,'Breil'),(25,'Garmin'),(26,'Thrustmaster'),(27,'PetSafe'),(28,'Black+Decker'),(29,'Mondadori'),(30,'Sony Music');
/*!40000 ALTER TABLE `marca` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1,'0025-06-12','12GB ram, 256 GB storage, Processore Exynos 800','Galaxy S24 Ultra',900,200,1,2,'s24ultra.jpg',_binary ''),(2,'0025-06-12','Chip apple silicon M1, 128 GB ssd, 12 GB ram','Macbook pro M1 13\"',1200.23,9,1,1,'prom1.jpeg',_binary '\0'),(3,'0025-06-12','Mobile ufficio color noce, 25x25x25','Kallax',19.99,200,5,5,'mobile.webp',_binary '\0'),(4,'0025-06-12','Matita digitale emr','Mars Lumograph Digital',29.99,200,6,6,'lumographdigital.jpg',_binary ''),(6,'1999-01-01','Bevanda energetica gusto taurina','Red bull',0.8,100,4,4,'redbull.webp',_binary ''),(8,'2024-11-15','Cuffie wireless con cancellazione del rumore','Sony WH-1000XM4',299.99,50,1,8,'sonyvh.jpeg',_binary '\0'),(9,'2025-03-10','Ultrabook touchscreen leggero con Windows 11','Microsoft Surface Laptop 5',1249,20,12,9,'surface.jpeg',_binary '\0'),(10,'2025-01-22','Scarpe da running versatili per allenamenti quotidiani','Nike Air Zoom Pegasus',129.99,4,8,10,'nikeair.jpeg',_binary ''),(11,'2024-12-05','Set da costruzione per bambini 9+ anni','LEGO Star Wars X-Wing',89.9,60,10,13,'lego.jpeg',_binary ''),(12,'2023-09-30','Trapano a batteria per lavori domestici','Trapano Avvitatore Bosch PSR 18',89.99,25,18,14,'bosh.webp',_binary '\0'),(13,'2024-10-12','Tecnologia sonica per una pulizia profonda','Spazzolino Elettrico Philips Sonicare',59.99,100,9,15,'oralb.webp',_binary '\0'),(14,'2025-05-01','Pasta di semola di grano duro','Barilla Pasta Penne Rigate 500g',1.19,29,7,18,'pennerigate.jpeg',_binary '\0'),(15,'2024-06-25','Orologio cronografo in acciaio','Orologio Breil Tribe Uomo',129,15,14,24,'tribe.jpeg',_binary '\0'),(16,'2025-02-01','Videocamera per auto compatta con controllo vocale','Garmin Dash Cam 57',179.99,12,11,25,'garmin.jpeg',_binary ''),(17,'2025-04-20','Dispenser d’acqua automatico 1.5L','Fontanella per Gatti PetSafe',32.99,0,16,27,'fontanella.jpeg',_binary ''),(18,'2024-09-10','Romanzo storico di Umberto Eco, ed. Mondadori','Il Nome della Rosa',14.9,100,13,29,'ilnomedellarosa.jpeg',_binary '\0'),(19,'2024-08-01','Ristampa in vinile dell’album leggendario','Vinile - Thriller di Michael Jackson',25,0,14,30,'thriller.jpeg',_binary ''),(20,'2023-05-12','Gioco per Nintendo Switch','The Legend of Zelda: Tears of the Kingdom',69.99,40,20,23,'zelda.jpeg',_binary '\0');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKsb8bbouer5wak8vyiiy4pf2bx` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'raff.vallifuoco@gmail.com','Raffo','{noop}pass','profile1.png','RaffoV'),(2,'user.gmail.com','User','{noop}pass','profile1.png','User');
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
INSERT INTO `user_roles` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'db_ecommerce'
--
