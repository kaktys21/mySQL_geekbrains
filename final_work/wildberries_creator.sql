-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: wildberries
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `catalogue`
--

DROP TABLE IF EXISTS `catalogue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `catalogue` (
  `id` int NOT NULL,
  `prod_id` int NOT NULL,
  KEY `fk_catalogue_idx` (`prod_id`),
  CONSTRAINT `fk_catalogue` FOREIGN KEY (`prod_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `color`
--

DROP TABLE IF EXISTS `color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `color` (
  `id` int NOT NULL AUTO_INCREMENT,
  `color` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prod_page`
--

DROP TABLE IF EXISTS `prod_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prod_page` (
  `product_id` int NOT NULL,
  `page_name` varchar(45) NOT NULL,
  `img` blob,
  `spec` varchar(245) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `season` int DEFAULT NULL,
  `color` int DEFAULT NULL,
  `size` int DEFAULT NULL,
  `left` int DEFAULT NULL,
  `cost` float DEFAULT 0,
  KEY `fk_prod_page_types_idx` (`type`),
  KEY `fk_prod_pages_season_idx` (`season`),
  KEY `fk_prod_pages_color_idx` (`color`),
  KEY `fk_prod_page_size_idx` (`size`),
  KEY `fk_prod_page_products` (`product_id`),
  CONSTRAINT `fk_prod_page_color` FOREIGN KEY (`color`) REFERENCES `color` (`id`),
  CONSTRAINT `fk_prod_page_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `fk_prod_page_season` FOREIGN KEY (`season`) REFERENCES `season` (`id`),
  CONSTRAINT `fk_prod_page_size` FOREIGN KEY (`size`) REFERENCES `size` (`id`),
  CONSTRAINT `fk_prod_page_types` FOREIGN KEY (`type`) REFERENCES `types` (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `articul_num` bigint NOT NULL,
  `contract` bigint NOT NULL,
  `supplier` int DEFAULT NULL,
  `nomenclatura` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_products_supplier_idx` (`supplier`),
  CONSTRAINT `fk_products_supplier` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `season`
--

DROP TABLE IF EXISTS `season`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `season` (
  `id` int NOT NULL AUTO_INCREMENT,
  `season` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `shop`
--

DROP TABLE IF EXISTS `shop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `owner` int NOT NULL,
  `catalogue` int NOT NULL,
  `supplier` int NOT NULL,
  `storage` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shop_supplier_idx` (`supplier`),
  KEY `fk_shop_storage_idx` (`storage`),
  KEY `fk_shop_uprof_idx` (`owner`),
  CONSTRAINT `fk_shop_storage` FOREIGN KEY (`storage`) REFERENCES `storage` (`id`),
  CONSTRAINT `fk_shop_supplier` FOREIGN KEY (`supplier`) REFERENCES `supplier` (`id`),
  CONSTRAINT `fk_shop_uprof` FOREIGN KEY (`owner`) REFERENCES `user` (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `size`
--

DROP TABLE IF EXISTS `size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `size` (
  `id` int NOT NULL AUTO_INCREMENT,
  `size` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `storage`
--

DROP TABLE IF EXISTS `storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `storage` (
  `id` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `section` bigint DEFAULT NULL,
  `tenant` int DEFAULT NULL,
  `contract` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contract_UNIQUE` (`contract`),
  KEY `fk_storage_user_idx` (`tenant`),
  CONSTRAINT `fk_storage_user` FOREIGN KEY (`tenant`) REFERENCES `user` (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `supplier` (
  `id` int NOT NULL AUTO_INCREMENT,
  `INN` bigint NOT NULL,
  `NNO` bigint NOT NULL,
  `name` varchar(245) NOT NULL,
  `city` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `INN_UNIQUE` (`INN`),
  UNIQUE KEY `NNO_UNIQUE` (`NNO`),
  KEY `fk_supplier_city_idx` (`city`),
  CONSTRAINT `fk_supplier_city` FOREIGN KEY (`city`) REFERENCES `city` (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(245) NOT NULL,
  `phone` bigint NOT NULL,
  `password_hash` char(65) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_UNIQUE` (`phone`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile` (
  `user_id` int NOT NULL,
  `f_name` varchar(45) NOT NULL,
  `s_name` varchar(45) NOT NULL,
  `t_name` varchar(45) DEFAULT NULL,
  `adress` varchar(100) DEFAULT NULL,
  `city` int DEFAULT NULL,
  KEY `fk_uprof_user_idx` (`user_id`),
  KEY `fk_uprof_city_idx` (`city`),
  CONSTRAINT `fk_uprof_city` FOREIGN KEY (`city`) REFERENCES `city` (`id`),
  CONSTRAINT `fk_uprof_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-18 12:06:08
