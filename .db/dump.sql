-- MySQL dump 10.13  Distrib 5.1.58, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: simplelms
-- ------------------------------------------------------
-- Server version	5.1.58-1ubuntu1

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
-- Table structure for table `accounts_userprofile`
--

DROP TABLE IF EXISTS `accounts_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `middle_name` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_userprofile`
--

LOCK TABLES `accounts_userprofile` WRITE;
/*!40000 ALTER TABLE `accounts_userprofile` DISABLE KEYS */;
INSERT INTO `accounts_userprofile` VALUES (1,2,'Отчествович'),(5,1,'Рутович');
/*!40000 ALTER TABLE `accounts_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'newcomers'),(2,'managers');
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_bda51c3c` (`group_id`),
  KEY `auth_group_permissions_1e014c8f` (`permission_id`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (3,1,40),(19,2,42),(18,2,41),(17,2,39),(16,2,38),(15,2,37),(20,2,52),(21,2,53);
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_message`
--

DROP TABLE IF EXISTS `auth_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_message_fbfc09f1` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_message`
--

LOCK TABLES `auth_message` WRITE;
/*!40000 ALTER TABLE `auth_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_e4470c6e` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add message',4,'add_message'),(11,'Can change message',4,'change_message'),(12,'Can delete message',4,'delete_message'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(25,'Can add article',9,'add_article'),(26,'Can change article',9,'change_article'),(27,'Can delete article',9,'delete_article'),(28,'Can add user profile',10,'add_userprofile'),(29,'Can change user profile',10,'change_userprofile'),(30,'Can delete user profile',10,'delete_userprofile'),(31,'Can add migration history',11,'add_migrationhistory'),(32,'Can change migration history',11,'change_migrationhistory'),(33,'Can delete migration history',11,'delete_migrationhistory'),(34,'Can add курс',12,'add_course'),(35,'Can change курс',12,'change_course'),(36,'Can delete курс',12,'delete_course'),(37,'Can add запись на курсы',13,'add_enrollment'),(38,'Can change запись на курсы',13,'change_enrollment'),(39,'Can delete запись на курсы',13,'delete_enrollment'),(40,'Can add заявка на курсы',14,'add_application'),(41,'Can change заявка на курсы',14,'change_application'),(42,'Can delete заявка на курсы',14,'delete_application'),(43,'Can add аттестат',15,'add_certificate'),(44,'Can change аттестат',15,'change_certificate'),(45,'Can delete аттестат',15,'delete_certificate'),(46,'Can add раздел',16,'add_part'),(47,'Can change раздел',16,'change_part'),(48,'Can delete раздел',16,'delete_part'),(49,'Can add элемент',17,'add_element'),(50,'Can change элемент',17,'change_element'),(51,'Can delete элемент',17,'delete_element'),(52,'Право принятия заявок',14,'accept_application'),(53,'Право отклонения заявок',14,'reject_application'),(54,'Can add лекция',18,'add_lection'),(55,'Can change лекция',18,'change_lection'),(56,'Can delete лекция',18,'delete_lection'),(57,'Can add страница',19,'add_lectionpage'),(58,'Can change страница',19,'change_lectionpage'),(59,'Can delete страница',19,'delete_lectionpage'),(60,'Can add результат',20,'add_lectionresult'),(61,'Can change результат',20,'change_lectionresult'),(62,'Can delete результат',20,'delete_lectionresult');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'root','Рут','Рутовый','root@localhost.loc','sha1$add68$cfae9514cb782c6604297496647546df672ce098',1,1,1,'2011-11-03 20:40:10','2011-10-07 16:32:28'),(2,'lex','Алексей','Фамилиев','lex.the.almighty@gmail.com','sha1$e97e2$4a100be2136f96cc62af6900c3d76b100a907f27',1,1,0,'2011-11-02 20:06:11','2011-10-07 17:11:52');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_fbfc09f1` (`user_id`),
  KEY `auth_user_groups_bda51c3c` (`group_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (3,1,2),(5,2,2);
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_fbfc09f1` (`user_id`),
  KEY `auth_user_user_permissions_1e014c8f` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_application`
--

DROP TABLE IF EXISTS `courses_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_submitted` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_application_course_id_37f941e0dd07c15c_uniq` (`course_id`,`user_id`),
  KEY `courses_application_ff48d8e5` (`course_id`),
  KEY `courses_application_fbfc09f1` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_application`
--

LOCK TABLES `courses_application` WRITE;
/*!40000 ALTER TABLE `courses_application` DISABLE KEYS */;
INSERT INTO `courses_application` VALUES (7,2,1,'2011-10-27');
/*!40000 ALTER TABLE `courses_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_certificate`
--

DROP TABLE IF EXISTS `courses_certificate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_certificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_enrolled` date NOT NULL,
  `date_finished` date NOT NULL,
  `rating` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_certificate_ff48d8e5` (`course_id`),
  KEY `courses_certificate_fbfc09f1` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_certificate`
--

LOCK TABLES `courses_certificate` WRITE;
/*!40000 ALTER TABLE `courses_certificate` DISABLE KEYS */;
/*!40000 ALTER TABLE `courses_certificate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_course`
--

DROP TABLE IF EXISTS `courses_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_created` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_course`
--

LOCK TABLES `courses_course` WRITE;
/*!40000 ALTER TABLE `courses_course` DISABLE KEYS */;
INSERT INTO `courses_course` VALUES (1,'Пробный курс','<p>Lorem Ipsum описание.</p>',1,'2011-10-23'),(2,'Еще один пробный курс','<p>Такое <em>вот</em> <strong>описание</strong>.</p>',1,'2011-10-23'),(3,'Основы jQuery','<p>Курс &mdash; введение в библиотеку <strong>jQuery</strong>.</p>',1,'2011-10-23');
/*!40000 ALTER TABLE `courses_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_element`
--

DROP TABLE IF EXISTS `courses_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_element` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `part_id` int(11) NOT NULL,
  `num` int(10) unsigned NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  `element_type_id` int(11) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  `max_rating` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_element_part_id_3b111a50e7102851_uniq` (`part_id`,`num`),
  KEY `courses_element_b9c3c5fb` (`part_id`),
  KEY `courses_element_b04ad1b5` (`element_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_element`
--

LOCK TABLES `courses_element` WRITE;
/*!40000 ALTER TABLE `courses_element` DISABLE KEYS */;
INSERT INTO `courses_element` VALUES (1,0,5,'Вводная лекция','',18,1,'0.00'),(2,1,0,'Вводная лекция','<p>Простое описание в составе курса.</p>',18,1,'0.00'),(3,1,1,'Вторая лекция','',18,2,'0.00');
/*!40000 ALTER TABLE `courses_element` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_enrollment`
--

DROP TABLE IF EXISTS `courses_enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_enrollment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_enrolled` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_enrollment_course_id_4b1872c6edb05115_uniq` (`course_id`,`user_id`),
  KEY `courses_enrollment_ff48d8e5` (`course_id`),
  KEY `courses_enrollment_fbfc09f1` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_enrollment`
--

LOCK TABLES `courses_enrollment` WRITE;
/*!40000 ALTER TABLE `courses_enrollment` DISABLE KEYS */;
INSERT INTO `courses_enrollment` VALUES (7,3,2,'2011-10-27'),(12,3,1,'2011-11-03');
/*!40000 ALTER TABLE `courses_enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_managers`
--

DROP TABLE IF EXISTS `courses_managers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_managers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_managers_course_id_2e44c079c2cfe713_uniq` (`course_id`,`user_id`),
  KEY `courses_managers_ff48d8e5` (`course_id`),
  KEY `courses_managers_fbfc09f1` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_managers`
--

LOCK TABLES `courses_managers` WRITE;
/*!40000 ALTER TABLE `courses_managers` DISABLE KEYS */;
INSERT INTO `courses_managers` VALUES (2,1,1),(3,2,2),(4,3,2);
/*!40000 ALTER TABLE `courses_managers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses_part`
--

DROP TABLE IF EXISTS `courses_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses_part` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `num` int(10) unsigned NOT NULL,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courses_part_course_id_108b4e05fea785f3_uniq` (`course_id`,`num`),
  KEY `courses_part_ff48d8e5` (`course_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_part`
--

LOCK TABLES `courses_part` WRITE;
/*!40000 ALTER TABLE `courses_part` DISABLE KEYS */;
INSERT INTO `courses_part` VALUES (1,3,0,'Вводная часть',''),(2,3,1,'Базовая часть','<p>Здесь узнаем все <strong>самое интересное</strong>.</p>');
/*!40000 ALTER TABLE `courses_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_fbfc09f1` (`user_id`),
  KEY `django_admin_log_e4470c6e` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2011-10-07 17:11:52',1,3,'2','lex',1,''),(2,'2011-10-07 17:13:21',1,3,'2','lex',2,'Changed first_name and last_name.'),(3,'2011-10-07 17:13:43',1,3,'2','lex',2,'Changed is_staff.'),(4,'2011-10-13 00:35:29',1,9,'1','Article object',1,''),(5,'2011-10-13 01:47:09',1,9,'2','Открыта регистрация',1,''),(6,'2011-10-13 03:42:52',1,9,'2','Открыта регистрация',2,'Изменен published.'),(7,'2011-10-13 03:43:05',1,9,'2','Открыта регистрация',2,'Изменен published.'),(8,'2011-10-14 23:46:53',1,9,'2','Открыта регистрация',2,'Изменен content.'),(9,'2011-10-14 23:54:14',1,9,'2','Открыта регистрация',2,'Изменен content.'),(10,'2011-10-14 23:58:23',1,9,'2','Открыта регистрация',2,'Изменен content.'),(11,'2011-10-15 01:34:41',1,3,'2','lex',2,'Изменен email.'),(12,'2011-10-15 01:38:23',1,3,'2','lex',2,'Добавлен профиль \"UserProfile object\".'),(13,'2011-10-23 13:11:39',1,3,'3','qwe',3,''),(14,'2011-10-23 17:30:41',1,3,'6','lexqt',3,''),(15,'2011-10-23 17:30:41',1,3,'5','lol',3,''),(16,'2011-10-23 17:30:41',1,3,'4','qwe',3,''),(17,'2011-10-23 17:30:41',1,3,'7','re',3,''),(18,'2011-10-23 18:08:37',1,12,'1','Пробный курс',1,''),(19,'2011-10-23 19:18:10',1,12,'2','Test 2',1,''),(20,'2011-10-23 19:22:32',1,12,'2','Еще один пробный курс',2,'Изменен title и description.'),(21,'2011-10-23 19:23:17',1,12,'3','Основы jQuery',1,''),(22,'2011-10-23 19:23:53',1,12,'1','Пробный курс',2,'Изменен is_active.'),(23,'2011-10-23 21:50:37',1,12,'1','Пробный курс',2,'Изменен description.'),(24,'2011-10-24 00:47:14',1,14,'3','Application object',3,''),(25,'2011-10-24 00:47:14',1,14,'2','Application object',3,''),(26,'2011-10-24 00:47:14',1,14,'1','Application object',3,''),(27,'2011-10-24 00:47:59',1,13,'1','Enrollment object',1,''),(28,'2011-10-24 00:53:59',1,14,'5','Application object',3,''),(29,'2011-10-26 19:25:44',1,2,'1','student',1,''),(30,'2011-10-26 19:34:13',1,2,'1','registered',2,'Изменен name.'),(31,'2011-10-26 20:02:55',1,2,'1','newcomers',2,'Изменен name.'),(32,'2011-10-26 21:53:37',1,2,'2','managers',1,''),(33,'2011-10-26 21:54:09',1,3,'1','root',2,'Изменен groups.'),(34,'2011-10-26 23:59:22',1,3,'1','root',2,'Добавлен профиль \"  Рутович\".'),(35,'2011-10-27 00:38:58',1,3,'1','root',2,'Изменен first_name и last_name.'),(36,'2011-10-27 16:37:31',1,13,'2','Enrollment object',3,''),(37,'2011-10-27 16:37:31',1,13,'1','Enrollment object',3,''),(38,'2011-10-27 16:50:23',1,13,'3','Enrollment object',3,''),(39,'2011-10-27 16:52:40',1,13,'4','Enrollment object',3,''),(40,'2011-10-27 16:53:59',1,13,'5','Enrollment object',3,''),(41,'2011-10-27 16:55:57',1,13,'6','Enrollment object',3,''),(42,'2011-10-27 19:31:17',1,3,'2','lex',2,'Изменен groups.'),(43,'2011-10-27 19:32:08',1,2,'2','managers',2,'Изменен permissions.'),(44,'2011-10-27 20:40:32',1,2,'2','managers',2,'Изменен permissions.'),(45,'2011-10-27 20:43:31',1,13,'7','Enrollment object',1,''),(46,'2011-10-27 20:52:20',1,13,'7','Enrollment object',2,'Ни одно поле не изменено.'),(47,'2011-10-27 21:40:00',1,13,'8','Enrollment object',1,''),(48,'2011-10-27 21:40:33',1,13,'8','Enrollment object',3,''),(49,'2011-10-27 21:40:51',1,13,'9','Enrollment object',1,''),(50,'2011-10-27 21:41:10',1,13,'9','Enrollment object',3,''),(51,'2011-10-27 21:46:41',1,13,'10','Enrollment object',1,''),(52,'2011-10-27 21:55:52',1,13,'10','Enrollment object',3,''),(53,'2011-10-27 21:58:38',1,13,'11','Enrollment object',1,''),(54,'2011-10-27 22:42:26',1,13,'11','Enrollment object',3,''),(55,'2011-10-30 19:28:31',1,3,'2','lex',2,'Изменен groups.'),(56,'2011-10-30 21:08:00',1,2,'2','managers',2,'Изменен permissions.'),(57,'2011-10-30 21:08:19',1,3,'2','lex',2,'Изменен groups.'),(58,'2011-10-30 21:10:02',1,12,'2','Еще один пробный курс',2,'Изменен managers.'),(59,'2011-10-30 21:26:06',1,16,'1','Вводная часть',1,''),(60,'2011-10-30 22:25:14',1,12,'3','Основы jQuery',2,'Изменен managers. Добавлен раздел \"Базовая часть\".'),(61,'2011-10-31 15:40:49',1,17,'1','1. Вводная лекция',1,''),(62,'2011-10-31 19:49:25',1,18,'1','Вводная лекция',1,''),(63,'2011-10-31 20:20:47',1,18,'1','Вводная лекция',2,'Добавлен страница \"Вводная лекция - \"Глава 1\"\".'),(64,'2011-10-31 20:23:38',1,16,'1','Вводная часть',2,'Изменены num,element_type и object_id для элемент \"0. Вводная лекция\".'),(65,'2011-11-02 18:22:13',1,18,'2','Еще одна лекция',1,''),(66,'2011-11-02 20:05:28',1,18,'2','Еще одна лекция',2,'Добавлен страница \"Еще одна лекция - \"Просто страница\"\". Добавлен страница \"Еще одна лекция - \"Просто вторая страница\"\".'),(67,'2011-11-03 20:42:28',1,16,'1','Вводная часть',2,'Добавлен элемент \"0. Вводная лекция\".'),(68,'2011-11-03 20:43:08',1,16,'1','Вводная часть',2,'Добавлен элемент \"1. Вторая лекция\".'),(69,'2011-11-03 20:43:22',1,16,'1','Вводная часть',2,'Изменен num.'),(70,'2011-11-03 20:43:22',1,16,'2','Базовая часть',2,'Изменен num.'),(71,'2011-11-03 20:43:51',1,13,'12','root - Основы jQuery',1,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'message','auth','message'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'log entry','admin','logentry'),(9,'article','news','article'),(10,'user profile','accounts','userprofile'),(11,'migration history','south','migrationhistory'),(12,'курс','courses','course'),(13,'запись на курсы','courses','enrollment'),(14,'заявка на курсы','courses','application'),(15,'аттестат','courses','certificate'),(16,'раздел','courses','part'),(17,'элемент','courses','element'),(18,'лекция','lections','lection'),(19,'страница','lections','lectionpage'),(20,'результат','lections','lectionresult');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_c25c2c28` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('9453e25b2928923a7d4250d572e6a330','MTQ3ODZhZjJjYzZmNWJkODY4NmJlMmUyMGE5NDZiNGJjNzZjM2NmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2011-10-21 17:10:33'),('f82d3dcad284c143e64d341e96f691d8','MTQ3ODZhZjJjYzZmNWJkODY4NmJlMmUyMGE5NDZiNGJjNzZjM2NmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2011-11-10 20:41:33'),('e85827dad5e919644196b1bd670421dc','MTQ3ODZhZjJjYzZmNWJkODY4NmJlMmUyMGE5NDZiNGJjNzZjM2NmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2011-11-17 20:40:10'),('b3fca3476334585bc1dc9b44d72f9d08','ZmFkYTQ0OTdiZTBmMTI1ZjFhMjgyNzY5NzI5YzM1MmVjM2QyYjk0OTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQJ1Lg==\n','2011-11-13 19:28:56');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lections_lection`
--

DROP TABLE IF EXISTS `lections_lection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lections_lection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lections_lection`
--

LOCK TABLES `lections_lection` WRITE;
/*!40000 ALTER TABLE `lections_lection` DISABLE KEYS */;
INSERT INTO `lections_lection` VALUES (1,'Вводная лекция','<p>Лекция, такая лекция!</p>'),(2,'Еще одна лекция','<p>Lorem Ipsum.</p>');
/*!40000 ALTER TABLE `lections_lection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lections_lectionpage`
--

DROP TABLE IF EXISTS `lections_lectionpage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lections_lectionpage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lection_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `content` longtext NOT NULL,
  `num` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lections_lectionpage_cadd5579` (`lection_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lections_lectionpage`
--

LOCK TABLES `lections_lectionpage` WRITE;
/*!40000 ALTER TABLE `lections_lectionpage` DISABLE KEYS */;
INSERT INTO `lections_lectionpage` VALUES (1,1,'Вступление','<p>Вступление, такое вступление!</p>',0),(2,1,'Глава 1','<p>Тут что-то пишем-пишем...</p>',1),(3,2,'Просто страница','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut tincidunt purus leo, et pharetra turpis. Curabitur venenatis ultricies mauris sed rhoncus. Donec eu ipsum lectus. Integer vitae purus turpis, nec consectetur erat. Vestibulum sodales adipiscing mauris, a gravida justo lobortis sed. Pellentesque ipsum massa, varius vel elementum convallis, hendrerit id purus. Vestibulum ac dui at mi scelerisque sodales et at orci. Phasellus est urna, feugiat pellentesque fringilla a, tristique nec tortor.</p>\r\n<p>Integer nulla magna, ultrices eget vehicula ac, dignissim sed eros. Curabitur at felis ac sem placerat rutrum eu eget quam. Nunc gravida ipsum ante. Pellentesque aliquam eleifend leo sed condimentum. Cras congue pretium sem a eleifend. Suspendisse ut orci at nisl ullamcorper placerat. Cras sit amet mi et orci suscipit cursus. Suspendisse sit amet ipsum risus, sed aliquam lorem. Quisque aliquet velit eget velit dapibus vulputate. Nulla tincidunt orci id augue molestie pellentesque molestie nulla fringilla. Ut ante sapien, blandit in faucibus ac, porttitor bibendum odio.</p>\r\n<p>Donec id leo metus, non elementum justo. Aenean interdum vehicula vehicula. Nunc ultricies euismod justo, tincidunt adipiscing arcu pretium ac. Morbi molestie, tortor vitae dictum blandit, sem ligula suscipit lorem, vitae facilisis mi elit ut felis. Praesent vehicula, libero nec congue ultrices, lectus odio posuere metus, at laoreet mauris neque id mi. Fusce quis magna mauris, vel fringilla mi. Donec sem lacus, egestas vitae scelerisque quis, pellentesque sed nisl. In vel ultricies ligula. Cras elementum, ante sed viverra sodales, diam augue fermentum tortor, ut egestas urna est sodales enim. Nunc laoreet fermentum nisi, sit amet vulputate massa posuere accumsan.</p>\r\n<p>Nam eget nibh urna. Maecenas sed sem ipsum, ac congue metus. Duis eleifend odio quis leo egestas rhoncus. Pellentesque eget lacus nec tortor posuere interdum sit amet eget dolor. Nullam semper, nibh non facilisis consectetur, velit orci mollis elit, ut rutrum justo ipsum id mauris. Suspendisse dignissim viverra aliquam. Sed molestie arcu quis velit viverra rutrum. Pellentesque ut libero ligula. Nunc ac turpis nec velit facilisis mattis. Nam euismod convallis ipsum rutrum fringilla. Nam condimentum scelerisque varius. Vestibulum placerat bibendum neque, nec luctus elit facilisis vel. Sed varius urna eget turpis scelerisque non mollis purus convallis. Vestibulum nisl est, vulputate a hendrerit ac, eleifend quis nibh.</p>\r\n<p>Praesent pretium malesuada orci, nec lacinia massa semper sed. Suspendisse vel sapien nisl. Curabitur adipiscing suscipit sem vel suscipit. Praesent porttitor mi at erat adipiscing tristique adipiscing augue ornare. Ut luctus eleifend tellus id vestibulum. Quisque dui dolor, tempor quis sodales vel, commodo sed dolor. In sodales ante vitae turpis luctus tempus.</p>',0),(4,2,'Просто вторая страница','<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec eros nunc. Vestibulum molestie enim ac tellus tincidunt aliquet. Duis posuere viverra mauris, a egestas est feugiat nec. Praesent ullamcorper quam quis tellus elementum sodales. Ut et neque non elit rutrum tincidunt quis et urna. Cras blandit, libero sed vulputate egestas, massa nibh porttitor nibh, eget ultrices neque velit id sapien. Maecenas vel purus urna. Donec nec libero arcu, sed facilisis tortor. Quisque laoreet dignissim nunc sed scelerisque. Proin ac ultricies purus. Quisque euismod magna sed tellus tincidunt ac tempor velit ultrices. Pellentesque lectus lectus, pharetra et posuere sed, gravida eu lorem. Curabitur eu urna ligula, quis suscipit tortor.</p>',1);
/*!40000 ALTER TABLE `lections_lectionpage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lections_lectionresult`
--

DROP TABLE IF EXISTS `lections_lectionresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lections_lectionresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lection_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_passed` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `lections_lectionresult_cadd5579` (`lection_id`),
  KEY `lections_lectionresult_ff48d8e5` (`course_id`),
  KEY `lections_lectionresult_fbfc09f1` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lections_lectionresult`
--

LOCK TABLES `lections_lectionresult` WRITE;
/*!40000 ALTER TABLE `lections_lectionresult` DISABLE KEYS */;
INSERT INTO `lections_lectionresult` VALUES (1,2,3,1,1);
/*!40000 ALTER TABLE `lections_lectionresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_article`
--

DROP TABLE IF EXISTS `news_article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news_article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` longtext NOT NULL,
  `published` tinyint(1) NOT NULL,
  `author_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_article_cc846901` (`author_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_article`
--

LOCK TABLES `news_article` WRITE;
/*!40000 ALTER TABLE `news_article` DISABLE KEYS */;
INSERT INTO `news_article` VALUES (1,'Новость однако!','<p><b>Очень</b> познавательная новость. Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum Lorem Ipsum</p>',1,2,'2011-10-13 00:35:26'),(2,'Открыта регистрация','<p>Открыта регистрация на сайте.</p>\r\n<p><img src=\"/media/jquery.png\" alt=\"Картинка\" width=\"250\" height=\"61\" /></p>',1,2,'2011-10-13 01:46:59');
/*!40000 ALTER TABLE `news_article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'accounts','0001_initial','2011-10-22 14:57:53'),(2,'news','0001_initial','2011-10-22 14:59:56'),(3,'courses','0001_initial','2011-10-23 14:04:31'),(4,'courses','0002_auto__del_field_course_active__add_field_course_is_active__chg_field_e','2011-10-23 14:37:13'),(5,'courses','0003_auto__add_field_course_date_created','2011-10-23 15:10:53'),(6,'courses','0004_auto__add_unique_enrollment_course_user__add_unique_application_course','2011-10-26 17:46:10'),(7,'courses','0005_auto__chg_field_part_num__chg_field_element_num','2011-10-30 19:03:40'),(8,'lections','0001_initial','2011-10-31 14:45:59'),(9,'courses','0006_auto__add_field_element_max_rating','2011-10-31 14:47:21');
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-11-07 21:27:28
