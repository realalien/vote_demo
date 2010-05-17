-- MySQL dump 10.13  Distrib 5.1.30, for Win32 (ia32)
--
-- Host: localhost    Database: vote_demo_development
-- ------------------------------------------------------
-- Server version	5.1.30-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT '',
  `comment` text,
  `commentable_id` int(11) DEFAULT NULL,
  `commentable_type` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_comments_on_commentable_id` (`commentable_id`),
  KEY `index_comments_on_commentable_type` (`commentable_type`),
  KEY `index_comments_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_answer_by_users`
--

DROP TABLE IF EXISTS `question_answer_by_users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `question_answer_by_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `question_answer_by_users`
--

LOCK TABLES `question_answer_by_users` WRITE;
/*!40000 ALTER TABLE `question_answer_by_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `question_answer_by_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `hint` text,
  `is_commentable` tinyint(1) DEFAULT NULL,
  `is_rateable` tinyint(1) DEFAULT NULL,
  `is_voteable` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `section_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'life quality','how do you feel?','',1,1,0,'2010-05-10 05:55:30','2010-05-10 05:55:30',NULL),(2,'life quality','Have you any suggestion for the improvement of the office?','',1,1,0,'2010-05-10 05:56:05','2010-05-10 05:56:05',NULL),(3,'Quality of Life','Does your quality of life match your expectations? Are you comfortable in your living situation, able to enjoy free time and looking forward to tomorrow? 1','',1,1,0,'2010-05-11 03:13:52','2010-05-17 07:31:44',NULL),(4,'Quality of Work Environment','Does your work environment provide the support and structure required for you to achieve your goals without stress or frustration? ','',1,1,0,'2010-05-11 03:14:14','2010-05-11 03:14:14',NULL),(5,'Quality of Studio Culture','How positive is the culture at Spicy Horse and in your department? Do you feel that you and your work are acknowledged, cared about and respected? ','',1,1,0,'2010-05-11 03:14:34','2010-05-11 03:14:34',NULL),(6,NULL,'Name some things that limit your ability to contribute more to our projects/studio:','',1,0,0,'2010-05-11 03:15:18','2010-05-11 03:15:18',NULL),(7,NULL,'Name some things that stop you from achieving all your goals at work and home:','',1,0,0,'2010-05-11 03:15:32','2010-05-11 03:15:32',NULL),(8,NULL,'Name the things you most like to contribute to the project/studio:','',1,0,0,'2010-05-11 03:15:50','2010-05-11 03:15:50',NULL),(9,'How satisfied are you with your:	','Salary','',0,1,0,'2010-05-11 03:16:19','2010-05-11 03:16:19',NULL),(10,'How satisfied are you with your:','Position','',0,1,0,'2010-05-11 03:16:39','2010-05-11 03:16:39',NULL),(11,'How satisfied are you with your:','Responsibilities ','',0,1,0,'2010-05-11 03:16:55','2010-05-11 03:16:55',NULL),(12,'How satisfied are you with your:','Contribution','',0,1,0,'2010-05-11 03:17:11','2010-05-11 03:17:11',NULL),(13,'How satisfied are you with your:','Advancement','',0,1,0,'2010-05-11 03:17:32','2010-05-11 03:17:32',NULL),(14,'Gets Results','Rank ability to complete tasks fully, on time and with high quality:','',1,1,0,'2010-05-11 03:18:04','2010-05-11 03:18:04',NULL),(15,'Communication & Understanding 	','Rank ability to communicate with manager and teammates to understand responsibilities within the studio and project.','',1,1,0,'2010-05-11 03:18:23','2010-05-11 03:18:23',NULL),(16,'Team Player','Rank your ability to support the team and its efforts by coming to work on time, engaging your co-workers in a constructive manner.','',1,1,0,'2010-05-11 03:18:38','2010-05-11 03:18:38',NULL),(17,NULL,'Teammate\'s Comments','',1,0,0,'2010-05-11 03:19:05','2010-05-11 03:19:05',NULL),(18,NULL,'Manager\'s Comments','',1,0,0,'2010-05-11 03:19:21','2010-05-11 03:19:21',NULL);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rater_id` int(11) DEFAULT NULL,
  `rateable_id` int(11) DEFAULT NULL,
  `rateable_type` varchar(255) DEFAULT NULL,
  `stars` int(11) NOT NULL,
  `dimension` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_rates_on_rateable_id_and_rateable_type` (`rateable_id`,`rateable_type`),
  KEY `index_rates_on_rater_id` (`rater_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
INSERT INTO `rates` VALUES (1,1,1,'Question',9,'description','2010-05-10 06:04:29','2010-05-10 06:04:51'),(2,1,2,'Question',9,'description','2010-05-10 06:04:32','2010-05-11 03:07:16'),(3,2,1,'Question',5,'description','2010-05-10 08:41:56','2010-05-10 08:53:57'),(4,2,2,'Question',4,'description','2010-05-10 08:42:08','2010-05-10 08:53:59'),(5,3,1,'Question',9,'description','2010-05-10 09:35:59','2010-05-11 03:10:37'),(6,3,2,'Question',10,'description','2010-05-10 09:36:07','2010-05-11 03:10:39'),(7,1,3,'Question',8,'description','2010-05-11 07:42:32','2010-05-11 08:07:54'),(8,3,3,'Question',6,'description','2010-05-11 08:18:59','2010-05-11 08:18:59'),(9,3,4,'Question',7,'description','2010-05-11 08:19:03','2010-05-11 08:19:03'),(10,4,3,'Question',6,'description','2010-05-11 09:34:54','2010-05-11 09:34:54'),(11,4,4,'Question',6,'description','2010-05-11 09:34:59','2010-05-11 09:34:59'),(12,5,3,'Question',1,'description','2010-05-11 10:01:10','2010-05-13 10:06:01'),(13,5,4,'Question',10,'description','2010-05-11 10:01:14','2010-05-11 10:01:53'),(14,5,15,'Question',7,'description','2010-05-12 08:42:40','2010-05-12 08:42:40'),(15,5,16,'Question',7,'description','2010-05-12 08:42:44','2010-05-12 08:42:44'),(16,5,5,'Question',6,'description','2010-05-12 10:16:24','2010-05-12 10:16:24'),(17,5,9,'Question',7,'description','2010-05-12 10:16:33','2010-05-12 10:16:33'),(18,5,10,'Question',6,'description','2010-05-12 10:16:35','2010-05-12 10:16:35'),(19,5,11,'Question',6,'description','2010-05-12 10:16:39','2010-05-12 10:16:39'),(20,5,12,'Question',6,'description','2010-05-12 10:16:42','2010-05-12 10:16:42'),(21,5,13,'Question',5,'description','2010-05-12 10:16:45','2010-05-12 10:16:45'),(22,5,14,'Question',6,'description','2010-05-12 10:16:48','2010-05-12 10:16:48');
/*!40000 ALTER TABLE `rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `response_versions`
--

DROP TABLE IF EXISTS `response_versions`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `response_versions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `response_id` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `answer_text` text,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `response_versions`
--

LOCK TABLES `response_versions` WRITE;
/*!40000 ALTER TABLE `response_versions` DISABLE KEYS */;
INSERT INTO `response_versions` VALUES (1,1,2,1,7,NULL,'2010-05-10 06:04:29'),(2,2,2,1,7,NULL,'2010-05-10 06:04:32'),(3,1,3,1,7,'','2010-05-10 06:04:40'),(4,2,3,1,7,'','2010-05-10 06:04:40'),(5,1,4,1,9,'','2010-05-10 06:04:51'),(6,2,4,1,9,'','2010-05-10 06:08:37'),(7,2,5,1,2,'','2010-05-10 06:08:44'),(8,3,2,2,7,NULL,'2010-05-10 08:41:57'),(9,4,2,2,6,NULL,'2010-05-10 08:42:08'),(10,4,3,2,7,NULL,'2010-05-10 08:43:21'),(11,3,3,2,5,NULL,'2010-05-10 08:53:58'),(12,4,4,2,4,NULL,'2010-05-10 08:53:59'),(13,5,2,3,6,NULL,'2010-05-10 09:35:59'),(14,6,2,3,7,NULL,'2010-05-10 09:36:07'),(15,1,5,1,9,'asasa','2010-05-10 09:39:38'),(16,2,6,1,2,'asasa','2010-05-10 09:39:38'),(17,11,2,3,NULL,'sdsds','2010-05-10 11:12:49'),(18,12,2,3,NULL,'sdsd','2010-05-10 11:12:49'),(19,2,7,1,9,'asasa','2010-05-11 03:07:16'),(20,1,6,1,9,'asasadfdfdd','2010-05-11 03:07:17'),(21,2,8,1,9,'asasadfdfd','2010-05-11 03:07:17'),(22,11,3,3,9,'sdsds','2010-05-11 03:10:37'),(23,12,3,3,10,'sdsd','2010-05-11 03:10:39'),(24,11,4,3,9,'dfdfdf','2010-05-11 03:10:46'),(25,12,4,3,10,'adfdafd','2010-05-11 03:10:46'),(26,11,5,3,9,'asasas','2010-05-11 05:14:01'),(27,12,5,3,10,'asasa','2010-05-11 05:14:01'),(28,29,2,1,NULL,'dfdfsdad','2010-05-11 08:15:08'),(29,30,2,1,NULL,'','2010-05-11 08:15:08'),(30,31,2,1,NULL,'','2010-05-11 08:15:08'),(31,32,2,1,NULL,'','2010-05-11 08:15:08'),(32,33,2,1,NULL,'','2010-05-11 08:15:08'),(33,34,2,1,NULL,'','2010-05-11 08:15:08'),(34,35,2,1,NULL,'','2010-05-11 08:15:08'),(35,36,2,1,NULL,'','2010-05-11 08:15:08'),(36,37,2,1,NULL,'','2010-05-11 08:15:08'),(37,38,2,1,NULL,'','2010-05-11 08:15:08'),(38,39,2,1,NULL,'','2010-05-11 08:15:08'),(39,40,2,1,NULL,'','2010-05-11 08:15:08'),(40,41,2,1,NULL,'','2010-05-11 08:15:08'),(41,42,2,1,NULL,'','2010-05-11 08:15:08'),(42,43,2,1,NULL,'','2010-05-11 08:15:08'),(43,44,2,1,NULL,'','2010-05-11 08:15:08'),(44,13,2,3,6,NULL,'2010-05-11 08:18:59'),(45,14,2,3,7,NULL,'2010-05-11 08:19:03'),(46,13,3,3,6,'asasas','2010-05-11 08:20:47'),(47,14,3,3,7,'asasa','2010-05-11 08:20:47'),(48,15,2,3,NULL,'','2010-05-11 08:20:47'),(49,16,2,3,NULL,'','2010-05-11 08:20:47'),(50,17,2,3,NULL,'','2010-05-11 08:20:47'),(51,18,2,3,NULL,'','2010-05-11 08:20:47'),(52,19,2,3,NULL,'','2010-05-11 08:20:47'),(53,20,2,3,NULL,'','2010-05-11 08:20:47'),(54,21,2,3,NULL,'','2010-05-11 08:20:47'),(55,22,2,3,NULL,'','2010-05-11 08:20:47'),(56,23,2,3,NULL,'','2010-05-11 08:20:47'),(57,24,2,3,NULL,'','2010-05-11 08:20:47'),(58,25,2,3,NULL,'','2010-05-11 08:20:47'),(59,26,2,3,NULL,'','2010-05-11 08:20:47'),(60,27,2,3,NULL,'','2010-05-11 08:20:47'),(61,28,2,3,NULL,'','2010-05-11 08:20:47'),(62,27,3,3,NULL,'asasasas','2010-05-11 08:21:15'),(63,45,2,4,6,NULL,'2010-05-11 09:34:54'),(64,46,2,4,6,NULL,'2010-05-11 09:34:59'),(65,45,3,4,6,'dfdfsfds','2010-05-11 09:35:05'),(66,46,3,4,6,'dsfsdfsd','2010-05-11 09:35:05'),(67,47,2,4,NULL,'','2010-05-11 09:35:05'),(68,48,2,4,NULL,'','2010-05-11 09:35:05'),(69,49,2,4,NULL,'','2010-05-11 09:35:05'),(70,50,2,4,NULL,'','2010-05-11 09:35:05'),(71,51,2,4,NULL,'','2010-05-11 09:35:05'),(72,52,2,4,NULL,'','2010-05-11 09:35:05'),(73,53,2,4,NULL,'','2010-05-11 09:35:05'),(74,54,2,4,NULL,'','2010-05-11 09:35:06'),(75,55,2,4,NULL,'','2010-05-11 09:35:06'),(76,56,2,4,NULL,'','2010-05-11 09:35:06'),(77,57,2,4,NULL,'','2010-05-11 09:35:06'),(78,58,2,4,NULL,'','2010-05-11 09:35:06'),(79,59,2,4,NULL,'','2010-05-11 09:35:06'),(80,60,2,4,NULL,'','2010-05-11 09:35:06'),(81,61,2,5,8,NULL,'2010-05-11 10:01:10'),(82,62,2,5,8,NULL,'2010-05-11 10:01:14'),(83,61,3,5,8,'adfdfdfd','2010-05-11 10:01:25'),(84,62,3,5,8,'dfddfdfd','2010-05-11 10:01:25'),(85,63,2,5,NULL,'','2010-05-11 10:01:25'),(86,64,2,5,NULL,'','2010-05-11 10:01:25'),(87,65,2,5,NULL,'','2010-05-11 10:01:25'),(88,66,2,5,NULL,'','2010-05-11 10:01:25'),(89,67,2,5,NULL,'','2010-05-11 10:01:25'),(90,68,2,5,NULL,'','2010-05-11 10:01:25'),(91,69,2,5,NULL,'','2010-05-11 10:01:25'),(92,70,2,5,NULL,'','2010-05-11 10:01:25'),(93,71,2,5,NULL,'','2010-05-11 10:01:25'),(94,72,2,5,NULL,'','2010-05-11 10:01:25'),(95,73,2,5,NULL,'','2010-05-11 10:01:25'),(96,74,2,5,NULL,'','2010-05-11 10:01:25'),(97,75,2,5,NULL,'','2010-05-11 10:01:25'),(98,76,2,5,NULL,'','2010-05-11 10:01:25'),(99,62,4,5,10,'dfddfdfd','2010-05-11 10:01:53'),(100,73,3,5,7,'','2010-05-12 08:42:40'),(101,74,3,5,7,'','2010-05-12 08:42:44'),(102,73,4,5,7,'ffgfg','2010-05-12 09:14:23'),(103,74,4,5,7,'fgfg','2010-05-12 09:14:23'),(104,63,3,5,6,'','2010-05-12 10:16:24'),(105,67,3,5,7,'','2010-05-12 10:16:33'),(106,68,3,5,6,'','2010-05-12 10:16:35'),(107,69,3,5,6,'','2010-05-12 10:16:39'),(108,70,3,5,6,'','2010-05-12 10:16:42'),(109,71,3,5,5,'','2010-05-12 10:16:45'),(110,72,3,5,6,'','2010-05-12 10:16:48'),(111,63,4,5,6,'dfdfdfdffdf','2010-05-12 10:16:57'),(112,64,3,5,NULL,'dfdfdffddf','2010-05-12 10:16:57'),(113,65,3,5,NULL,'dfdfdfdfd','2010-05-12 10:16:57'),(114,66,3,5,NULL,'dfdfdddff','2010-05-12 10:16:57'),(115,67,4,5,7,'dfsf','2010-05-12 10:16:57'),(116,68,4,5,6,'dsfsdfsf','2010-05-12 10:16:57'),(117,69,4,5,6,'sdfsfsdfs','2010-05-12 10:16:57'),(118,70,4,5,6,'sddfsdf','2010-05-12 10:16:57'),(119,71,4,5,5,'sdfds','2010-05-12 10:16:57'),(120,72,4,5,6,'sfsfsfsd','2010-05-12 10:16:57'),(121,73,5,5,7,'ffgfgsd','2010-05-12 10:16:58'),(122,74,5,5,7,'fgfgsf','2010-05-12 10:16:58'),(123,75,3,5,NULL,'sfsd','2010-05-12 10:16:58'),(124,76,3,5,NULL,'sdfsdff','2010-05-12 10:16:58'),(125,61,4,5,1,'adfdfdfd','2010-05-13 10:06:02');
/*!40000 ALTER TABLE `response_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responses`
--

DROP TABLE IF EXISTS `responses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_sheet_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `answer_text` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `version` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `responses`
--

LOCK TABLES `responses` WRITE;
/*!40000 ALTER TABLE `responses` DISABLE KEYS */;
INSERT INTO `responses` VALUES (1,1,1,1,9,'asasadfdfdd','2010-05-10 05:56:17','2010-05-11 03:07:17',6),(2,1,1,2,9,'asasadfdfd','2010-05-10 05:56:17','2010-05-11 03:07:17',8),(3,2,2,1,5,NULL,'2010-05-10 08:41:53','2010-05-10 08:53:58',3),(4,2,2,2,4,NULL,'2010-05-10 08:41:53','2010-05-10 08:53:59',4),(11,6,3,1,9,'asasas','2010-05-10 10:07:06','2010-05-11 05:14:01',5),(12,6,3,2,10,'asasa','2010-05-10 10:07:06','2010-05-11 05:14:01',5),(13,7,3,3,6,'asasas','2010-05-11 03:19:52','2010-05-11 09:22:05',3),(14,7,3,4,7,'asasa','2010-05-11 03:19:52','2010-05-11 09:22:05',3),(15,7,3,5,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:05',2),(16,7,3,6,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:05',2),(17,7,3,7,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:05',2),(18,7,3,8,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:05',2),(19,7,3,9,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(20,7,3,10,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(21,7,3,11,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(22,7,3,12,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(23,7,3,13,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(24,7,3,14,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(25,7,3,15,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(26,7,3,16,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(27,7,3,17,NULL,'asasasas','2010-05-11 03:19:52','2010-05-11 09:22:06',3),(28,7,3,18,NULL,'','2010-05-11 03:19:52','2010-05-11 09:22:06',2),(29,8,1,3,NULL,'dfdfsdad','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(30,8,1,4,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(31,8,1,5,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(32,8,1,6,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(33,8,1,7,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(34,8,1,8,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(35,8,1,9,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(36,8,1,10,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(37,8,1,11,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(38,8,1,12,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(39,8,1,13,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(40,8,1,14,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(41,8,1,15,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(42,8,1,16,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(43,8,1,17,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(44,8,1,18,NULL,'','2010-05-11 08:14:54','2010-05-11 09:53:39',2),(45,9,4,3,6,'dfdfsfds','2010-05-11 09:34:43','2010-05-11 09:35:05',3),(46,9,4,4,6,'dsfsdfsd','2010-05-11 09:34:43','2010-05-11 09:35:05',3),(47,9,4,5,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:05',2),(48,9,4,6,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:05',2),(49,9,4,7,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:05',2),(50,9,4,8,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:05',2),(51,9,4,9,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:05',2),(52,9,4,10,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:05',2),(53,9,4,11,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:05',2),(54,9,4,12,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:06',2),(55,9,4,13,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:06',2),(56,9,4,14,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:06',2),(57,9,4,15,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:06',2),(58,9,4,16,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:06',2),(59,9,4,17,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:06',2),(60,9,4,18,NULL,'','2010-05-11 09:34:43','2010-05-11 09:35:06',2),(61,10,5,3,1,'adfdfdfd','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(62,10,5,4,10,'dfddfdfd','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(63,10,5,5,6,'dfdfdfdffdf','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(64,10,5,6,NULL,'dfdfdffddf','2010-05-11 09:59:58','2010-05-13 10:06:05',3),(65,10,5,7,NULL,'dfdfdfdfd','2010-05-11 09:59:58','2010-05-13 10:06:05',3),(66,10,5,8,NULL,'dfdfdddff','2010-05-11 09:59:58','2010-05-13 10:06:05',3),(67,10,5,9,7,'dfsf','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(68,10,5,10,6,'dsfsdfsf','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(69,10,5,11,6,'sdfsfsdfs','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(70,10,5,12,6,'sddfsdf','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(71,10,5,13,5,'sdfds','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(72,10,5,14,6,'sfsfsfsd','2010-05-11 09:59:58','2010-05-13 10:06:05',4),(73,10,5,15,7,'ffgfgsd','2010-05-11 09:59:58','2010-05-13 10:06:05',5),(74,10,5,16,7,'fgfgsf','2010-05-11 09:59:58','2010-05-13 10:06:05',5),(75,10,5,17,NULL,'sfsd','2010-05-11 09:59:58','2010-05-13 10:06:05',3),(76,10,5,18,NULL,'sdfsdff','2010-05-11 09:59:58','2010-05-13 10:06:05',3),(77,11,6,3,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(78,11,6,4,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(79,11,6,5,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(80,11,6,6,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(81,11,6,7,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(82,11,6,8,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(83,11,6,9,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(84,11,6,10,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(85,11,6,11,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(86,11,6,12,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(87,11,6,13,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(88,11,6,14,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(89,11,6,15,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(90,11,6,16,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(91,11,6,17,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1),(92,11,6,18,NULL,NULL,'2010-05-12 03:14:27','2010-05-12 03:14:27',1);
/*!40000 ALTER TABLE `responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_users`
--

DROP TABLE IF EXISTS `roles_users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `roles_users` (
  `role_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  KEY `index_roles_users_on_role_id` (`role_id`),
  KEY `index_roles_users_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `roles_users`
--

LOCK TABLES `roles_users` WRITE;
/*!40000 ALTER TABLE `roles_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20100401123342'),('20100401123420'),('20100401132628'),('20100412053608'),('20100412062450'),('20100412065253'),('20100412070644'),('20100413095259'),('20100413095950'),('20100414063344'),('20100414071014'),('20100415011737'),('20100419033456'),('20100420030626'),('20100422015940'),('20100422085348'),('20100423034416'),('20100423055137'),('20100510070335'),('20100512071447'),('20100512083424'),('20100514055830'),('20100514084449'),('20100514084515');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `survey_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,1,'YOU (Completed by Teammates)',2,'2010-05-14 09:40:40','2010-05-17 07:46:06');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sheet_answer_relations`
--

DROP TABLE IF EXISTS `sheet_answer_relations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sheet_answer_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_sheet_id` int(11) DEFAULT NULL,
  `answer_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sheet_answer_relations`
--

LOCK TABLES `sheet_answer_relations` WRITE;
/*!40000 ALTER TABLE `sheet_answer_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `sheet_answer_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sheet_histories`
--

DROP TABLE IF EXISTS `sheet_histories`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sheet_histories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `when_submit` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `survey_sheet_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sheet_histories`
--

LOCK TABLES `sheet_histories` WRITE;
/*!40000 ALTER TABLE `sheet_histories` DISABLE KEYS */;
INSERT INTO `sheet_histories` VALUES (1,5,'2010-05-12 09:14:23','2010-05-12 09:14:23','2010-05-12 09:14:23',10),(2,5,'2010-05-12 10:16:57','2010-05-12 10:16:57','2010-05-12 10:16:57',10),(3,5,'2010-05-13 10:06:05','2010-05-13 10:06:05','2010-05-13 10:06:05',10);
/*!40000 ALTER TABLE `sheet_histories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sheet_question_relations`
--

DROP TABLE IF EXISTS `sheet_question_relations`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sheet_question_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_sheet_id` int(11) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `sheet_question_relations`
--

LOCK TABLES `sheet_question_relations` WRITE;
/*!40000 ALTER TABLE `sheet_question_relations` DISABLE KEYS */;
INSERT INTO `sheet_question_relations` VALUES (1,1,1,'2010-05-10 05:56:17','2010-05-10 05:56:17'),(2,1,2,'2010-05-10 05:56:17','2010-05-10 05:56:17'),(3,2,1,'2010-05-10 08:41:53','2010-05-10 08:41:53'),(4,2,2,'2010-05-10 08:41:53','2010-05-10 08:41:53'),(5,3,1,'2010-05-10 09:35:53','2010-05-10 09:35:53'),(6,3,2,'2010-05-10 09:35:53','2010-05-10 09:35:53'),(7,4,1,'2010-05-10 09:36:29','2010-05-10 09:36:29'),(8,4,2,'2010-05-10 09:36:29','2010-05-10 09:36:29'),(9,5,1,'2010-05-10 09:38:25','2010-05-10 09:38:25'),(10,5,2,'2010-05-10 09:38:25','2010-05-10 09:38:25'),(11,6,1,'2010-05-10 10:07:06','2010-05-10 10:07:06'),(12,6,2,'2010-05-10 10:07:06','2010-05-10 10:07:06'),(13,7,3,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(14,7,4,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(15,7,5,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(16,7,6,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(17,7,7,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(18,7,8,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(19,7,9,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(20,7,10,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(21,7,11,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(22,7,12,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(23,7,13,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(24,7,14,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(25,7,15,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(26,7,16,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(27,7,17,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(28,7,18,'2010-05-11 03:19:52','2010-05-11 03:19:52'),(29,8,3,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(30,8,4,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(31,8,5,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(32,8,6,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(33,8,7,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(34,8,8,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(35,8,9,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(36,8,10,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(37,8,11,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(38,8,12,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(39,8,13,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(40,8,14,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(41,8,15,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(42,8,16,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(43,8,17,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(44,8,18,'2010-05-11 08:14:54','2010-05-11 08:14:54'),(45,9,3,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(46,9,4,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(47,9,5,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(48,9,6,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(49,9,7,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(50,9,8,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(51,9,9,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(52,9,10,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(53,9,11,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(54,9,12,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(55,9,13,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(56,9,14,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(57,9,15,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(58,9,16,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(59,9,17,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(60,9,18,'2010-05-11 09:34:43','2010-05-11 09:34:43'),(61,10,3,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(62,10,4,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(63,10,5,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(64,10,6,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(65,10,7,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(66,10,8,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(67,10,9,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(68,10,10,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(69,10,11,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(70,10,12,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(71,10,13,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(72,10,14,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(73,10,15,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(74,10,16,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(75,10,17,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(76,10,18,'2010-05-11 09:59:58','2010-05-11 09:59:58'),(77,11,3,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(78,11,4,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(79,11,5,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(80,11,6,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(81,11,7,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(82,11,8,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(83,11,9,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(84,11,10,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(85,11,11,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(86,11,12,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(87,11,13,'2010-05-12 03:14:26','2010-05-12 03:14:26'),(88,11,14,'2010-05-12 03:14:27','2010-05-12 03:14:27'),(89,11,15,'2010-05-12 03:14:27','2010-05-12 03:14:27'),(90,11,16,'2010-05-12 03:14:27','2010-05-12 03:14:27'),(91,11,17,'2010-05-12 03:14:27','2010-05-12 03:14:27'),(92,11,18,'2010-05-12 03:14:27','2010-05-12 03:14:27');
/*!40000 ALTER TABLE `sheet_question_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smerf_forms`
--

DROP TABLE IF EXISTS `smerf_forms`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `smerf_forms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `active` int(11) NOT NULL,
  `cache` text,
  `cache_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_smerf_forms_on_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `smerf_forms`
--

LOCK TABLES `smerf_forms` WRITE;
/*!40000 ALTER TABLE `smerf_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `smerf_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smerf_forms_users`
--

DROP TABLE IF EXISTS `smerf_forms_users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `smerf_forms_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `smerf_form_id` int(11) NOT NULL,
  `responses` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `smerf_forms_users`
--

LOCK TABLES `smerf_forms_users` WRITE;
/*!40000 ALTER TABLE `smerf_forms_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `smerf_forms_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `smerf_responses`
--

DROP TABLE IF EXISTS `smerf_responses`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `smerf_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `smerf_forms_user_id` int(11) NOT NULL,
  `question_code` varchar(255) NOT NULL,
  `response` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `smerf_responses`
--

LOCK TABLES `smerf_responses` WRITE;
/*!40000 ALTER TABLE `smerf_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `smerf_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_question_assignments`
--

DROP TABLE IF EXISTS `survey_question_assignments`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `survey_question_assignments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `survey_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `sequence` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `survey_question_assignments`
--

LOCK TABLES `survey_question_assignments` WRITE;
/*!40000 ALTER TABLE `survey_question_assignments` DISABLE KEYS */;
INSERT INTO `survey_question_assignments` VALUES (1,1,1,NULL,'2010-05-10 05:55:30','2010-05-10 05:55:30'),(2,1,2,NULL,'2010-05-10 05:56:05','2010-05-10 05:56:05'),(3,2,3,NULL,'2010-05-11 03:13:52','2010-05-11 03:13:52'),(4,2,4,NULL,'2010-05-11 03:14:14','2010-05-11 03:14:14'),(5,2,5,NULL,'2010-05-11 03:14:34','2010-05-11 03:14:34'),(6,2,6,NULL,'2010-05-11 03:15:18','2010-05-11 03:15:18'),(7,2,7,NULL,'2010-05-11 03:15:32','2010-05-11 03:15:32'),(8,2,8,NULL,'2010-05-11 03:15:50','2010-05-11 03:15:50'),(9,2,9,NULL,'2010-05-11 03:16:19','2010-05-11 03:16:19'),(10,2,10,NULL,'2010-05-11 03:16:39','2010-05-11 03:16:39'),(11,2,11,NULL,'2010-05-11 03:16:55','2010-05-11 03:16:55'),(12,2,12,NULL,'2010-05-11 03:17:11','2010-05-11 03:17:11'),(13,2,13,NULL,'2010-05-11 03:17:32','2010-05-11 03:17:32'),(14,2,14,NULL,'2010-05-11 03:18:04','2010-05-11 03:18:04'),(15,2,15,NULL,'2010-05-11 03:18:23','2010-05-11 03:18:23'),(16,2,16,NULL,'2010-05-11 03:18:38','2010-05-11 03:18:38'),(17,2,17,NULL,'2010-05-11 03:19:05','2010-05-11 03:19:05'),(18,2,18,NULL,'2010-05-11 03:19:21','2010-05-11 03:19:21');
/*!40000 ALTER TABLE `survey_question_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `survey_sheets`
--

DROP TABLE IF EXISTS `survey_sheets`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `survey_sheets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `modification_count` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `survey_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `survey_sheets`
--

LOCK TABLES `survey_sheets` WRITE;
/*!40000 ALTER TABLE `survey_sheets` DISABLE KEYS */;
INSERT INTO `survey_sheets` VALUES (1,NULL,'2010-05-10 05:56:17','2010-05-10 05:56:17',NULL,1,1),(2,NULL,'2010-05-10 08:41:53','2010-05-10 08:41:53',NULL,2,1),(6,NULL,'2010-05-10 10:07:06','2010-05-10 10:07:06',NULL,3,1),(7,NULL,'2010-05-11 03:19:52','2010-05-11 03:19:52',NULL,3,2),(8,NULL,'2010-05-11 08:14:54','2010-05-11 08:14:54',NULL,1,2),(9,NULL,'2010-05-11 09:34:43','2010-05-11 09:34:43',NULL,4,2),(10,NULL,'2010-05-11 09:59:58','2010-05-11 09:59:58',NULL,5,2),(11,NULL,'2010-05-12 03:14:26','2010-05-12 03:14:26',NULL,6,2);
/*!40000 ALTER TABLE `survey_sheets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `surveys`
--

DROP TABLE IF EXISTS `surveys`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `surveys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `category` varchar(255) DEFAULT NULL,
  `target_audience` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `guideline` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `surveys`
--

LOCK TABLES `surveys` WRITE;
/*!40000 ALTER TABLE `surveys` DISABLE KEYS */;
INSERT INTO `surveys` VALUES (1,'employee form','general info','','','2010-05-10 05:55:16','2010-05-10 05:55:16',NULL),(2,'Spicy Horse Quarterly Teammate Evaluation Form','Spicy Horse Quarterly Teammate Evaluation Form','HR','employee','2010-05-11 03:13:30','2010-05-17 04:01:32','To be completed by teammates and managers in each department each quarter. \r\nTeammate should fill in first section alone. \r\nTeammate and Manager should fill in second section together.\r\nPlease include written comments wherever possible.\r\n');
/*!40000 ALTER TABLE `surveys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `travel_places`
--

DROP TABLE IF EXISTS `travel_places`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `travel_places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `travel_places`
--

LOCK TABLES `travel_places` WRITE;
/*!40000 ALTER TABLE `travel_places` DISABLE KEYS */;
/*!40000 ALTER TABLE `travel_places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(40) DEFAULT NULL,
  `name` varchar(100) DEFAULT '',
  `email` varchar(100) DEFAULT NULL,
  `crypted_password` varchar(40) DEFAULT NULL,
  `salt` varchar(40) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `remember_token` varchar(40) DEFAULT NULL,
  `remember_token_expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'realalien','','ra@ra.com','73f7c91fbabed7d5aa54044723a6c0e29f26bab7','7a91fa4381e468e1d5f87022f8fd9e3aeb8a21ba','2010-05-10 05:55:00','2010-05-10 05:55:00',NULL,NULL),(2,'realalien2','','ra2@ra2.com','6c91f41a8032891656ffa4573f92ddaed942e4ce','7f145155915f0c34f6e13516f0286037d9b2a98a','2010-05-10 08:41:44','2010-05-10 08:41:44',NULL,NULL),(3,'realalien3','','ra3@ra3.com','d0ba75a9b09c75c5ec64fbae5e8ec9c4553d015c','01817742da8fb9c781ef3ae78beecbe073694069','2010-05-10 08:56:57','2010-05-10 08:56:57',NULL,NULL),(4,'zhujiacheng','','zz@zz.com','b49fa2c65d8d12756d3d6d2168e2fdf3334da39c','57ed9441da26fb7512c4cc200e86948baa732c0c','2010-05-11 09:34:27','2010-05-11 09:34:27',NULL,NULL),(5,'zhujiacheng2','','zhu@sh.com','599f9d663ef0d4de1bc5f71aa55ee586c387fa2d','d6b8360b5f89d22b25da97cb37d03f1de1acd43f','2010-05-11 09:59:12','2010-05-11 09:59:12',NULL,NULL),(6,'realalien22','','ra22@ra.com','6b6dd682610528f203ba00a4e4c37a3e443330a5','53068d5c701ec664674f919b452e22df8cd4a2eb','2010-05-12 03:10:25','2010-05-12 03:10:25',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vote` tinyint(1) DEFAULT '0',
  `voteable_id` int(11) NOT NULL,
  `voteable_type` varchar(255) NOT NULL,
  `voter_id` int(11) DEFAULT NULL,
  `voter_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_voteables` (`voteable_id`,`voteable_type`),
  KEY `fk_voters` (`voter_id`,`voter_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `votes`
--

LOCK TABLES `votes` WRITE;
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-05-17  9:30:35
