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
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_userprofile`
--

LOCK TABLES `accounts_userprofile` WRITE;
/*!40000 ALTER TABLE `accounts_userprofile` DISABLE KEYS */;
INSERT INTO `accounts_userprofile` VALUES (1,2,'Учителевич'),(5,1,'Рутович'),(6,8,'Студентович'),(27,29,'temp');
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
INSERT INTO `auth_group` VALUES (1,'newcomers'),(2,'managers'),(3,'students');
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
) ENGINE=MyISAM AUTO_INCREMENT=198 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
INSERT INTO `auth_group_permissions` VALUES (3,1,40),(197,2,84),(196,2,80),(195,2,79),(194,2,78),(193,2,77),(192,2,76),(191,2,75),(190,2,74),(189,2,73),(188,2,72),(187,2,71),(186,2,70),(185,2,69),(184,2,65),(183,2,64),(182,2,63),(181,2,61),(180,2,59),(179,2,58),(178,2,57),(177,2,56),(176,2,55),(175,2,54),(174,2,53),(173,2,52),(172,2,51),(171,2,50),(170,2,49),(169,2,48),(168,2,47),(167,2,46),(166,2,42),(165,2,41),(164,2,39),(163,2,38),(162,2,37),(161,2,35),(160,2,8);
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
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add message',4,'add_message'),(11,'Can change message',4,'change_message'),(12,'Can delete message',4,'delete_message'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(25,'Can add article',9,'add_article'),(26,'Can change article',9,'change_article'),(27,'Can delete article',9,'delete_article'),(28,'Can add user profile',10,'add_userprofile'),(29,'Can change user profile',10,'change_userprofile'),(30,'Can delete user profile',10,'delete_userprofile'),(31,'Can add migration history',11,'add_migrationhistory'),(32,'Can change migration history',11,'change_migrationhistory'),(33,'Can delete migration history',11,'delete_migrationhistory'),(34,'Can add курс',12,'add_course'),(35,'Can change курс',12,'change_course'),(36,'Can delete курс',12,'delete_course'),(37,'Can add запись на курсы',13,'add_enrollment'),(38,'Can change запись на курсы',13,'change_enrollment'),(39,'Can delete запись на курсы',13,'delete_enrollment'),(40,'Can add заявка на курсы',14,'add_application'),(41,'Can change заявка на курсы',14,'change_application'),(42,'Can delete заявка на курсы',14,'delete_application'),(43,'Can add аттестат',15,'add_certificate'),(44,'Can change аттестат',15,'change_certificate'),(45,'Can delete аттестат',15,'delete_certificate'),(46,'Can add раздел',16,'add_part'),(47,'Can change раздел',16,'change_part'),(48,'Can delete раздел',16,'delete_part'),(49,'Can add элемент',17,'add_element'),(50,'Can change элемент',17,'change_element'),(51,'Can delete элемент',17,'delete_element'),(52,'Право принятия заявок',14,'accept_application'),(53,'Право отклонения заявок',14,'reject_application'),(54,'Can add лекция',18,'add_lecture'),(55,'Can change лекция',18,'change_lecture'),(56,'Can delete лекция',18,'delete_lecture'),(57,'Can add страница',19,'add_lecturepage'),(58,'Can change страница',19,'change_lecturepage'),(59,'Can delete страница',19,'delete_lecturepage'),(60,'Can add результат',20,'add_lectureresult'),(61,'Can change результат',20,'change_lectureresult'),(62,'Can delete результат',20,'delete_lectureresult'),(63,'Can add тестовое задание',21,'add_testframe'),(64,'Can change тестовое задание',21,'change_testframe'),(65,'Can delete тестовое задание',21,'delete_testframe'),(69,'Can add фрейм сессии прохождения теста',23,'add_sessionframe'),(70,'Can change фрейм сессии прохождения теста',23,'change_sessionframe'),(71,'Can delete фрейм сессии прохождения теста',23,'delete_sessionframe'),(72,'Can add сессия прохождения теста',24,'add_session'),(73,'Can change сессия прохождения теста',24,'change_session'),(74,'Can delete сессия прохождения теста',24,'delete_session'),(75,'Can add результат прохождения теста',25,'add_testresult'),(76,'Can change результат прохождения теста',25,'change_testresult'),(77,'Can delete результат прохождения теста',25,'delete_testresult'),(78,'Can add тест',26,'add_test'),(79,'Can change тест',26,'change_test'),(80,'Can delete тест',26,'delete_test'),(81,'Can add отношение Курс - Схема',27,'add_schemecourserelation'),(82,'Can change отношение Курс - Схема',27,'change_schemecourserelation'),(83,'Can delete отношение Курс - Схема',27,'delete_schemecourserelation'),(84,'Право тестировать фреймы',21,'debug_frame');
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
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'root','Рут','Рутовый','root@localhost.local','sha1$add68$cfae9514cb782c6604297496647546df672ce098',1,1,1,'2012-01-10 05:59:33','2011-10-07 16:32:28'),(2,'teacher','Учитель','Учителев','teacher@localhost.local','sha1$f49ac$5050797de79e328e83e6f4c268ed3288e0c83d86',1,1,0,'2011-12-26 18:41:42','2011-10-07 17:11:52'),(8,'student','Студент','Студентов','student@localhost.local','sha1$35521$9e598d8fe2174944bfd6b5ea2e69356fd6950d1c',0,1,0,'2012-01-10 05:36:31','2011-11-17 22:18:26'),(29,'temp','temp','temp','temp@temp.temp','sha1$19d6f$dfb78cfc4d5ad61d253b7b5699c36c79787496fb',0,1,0,'2012-01-10 04:41:42','2012-01-10 04:20:00');
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
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
INSERT INTO `auth_user_groups` VALUES (7,1,2),(6,2,2),(11,8,3),(12,1,3),(35,29,3);
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
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_application`
--

LOCK TABLES `courses_application` WRITE;
/*!40000 ALTER TABLE `courses_application` DISABLE KEYS */;
INSERT INTO `courses_application` VALUES (39,1,29,'2012-01-10'),(30,1,1,'2011-12-26'),(32,1,2,'2011-12-26'),(33,2,1,'2011-12-27'),(34,1,8,'2012-01-09'),(35,2,8,'2012-01-09');
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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_element`
--

LOCK TABLES `courses_element` WRITE;
/*!40000 ALTER TABLE `courses_element` DISABLE KEYS */;
INSERT INTO `courses_element` VALUES (1,0,5,'Вводная лекция','',18,1,'0.00'),(2,1,0,'Вводная лекция','<p>Простое описание в составе курса.</p>',18,1,'2.00'),(3,1,1,'Вторая лекция','',18,2,'5.00'),(4,2,0,'Аттестующий тест','<p>Очень хитрый тест.</p>',26,1,'10.00'),(5,2,1,'Обучающий тест','<p>Хитрый тест, но с режимом \"Обучающий\" и оценивающийся в ноль баллов.</p>',26,2,'0.50');
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
) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_enrollment`
--

LOCK TABLES `courses_enrollment` WRITE;
/*!40000 ALTER TABLE `courses_enrollment` DISABLE KEYS */;
INSERT INTO `courses_enrollment` VALUES (13,3,8,'2011-11-17'),(29,3,1,'2011-11-21'),(31,3,29,'2012-01-10'),(32,2,29,'2012-01-10');
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses_managers`
--

LOCK TABLES `courses_managers` WRITE;
/*!40000 ALTER TABLE `courses_managers` DISABLE KEYS */;
INSERT INTO `courses_managers` VALUES (6,1,2),(5,3,2);
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
) ENGINE=MyISAM AUTO_INCREMENT=224 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2011-10-07 17:11:52',1,3,'2','lex',1,''),(2,'2011-10-07 17:13:21',1,3,'2','lex',2,'Changed first_name and last_name.'),(3,'2011-10-07 17:13:43',1,3,'2','lex',2,'Changed is_staff.'),(4,'2011-10-13 00:35:29',1,9,'1','Article object',1,''),(5,'2011-10-13 01:47:09',1,9,'2','Открыта регистрация',1,''),(6,'2011-10-13 03:42:52',1,9,'2','Открыта регистрация',2,'Изменен published.'),(7,'2011-10-13 03:43:05',1,9,'2','Открыта регистрация',2,'Изменен published.'),(8,'2011-10-14 23:46:53',1,9,'2','Открыта регистрация',2,'Изменен content.'),(9,'2011-10-14 23:54:14',1,9,'2','Открыта регистрация',2,'Изменен content.'),(10,'2011-10-14 23:58:23',1,9,'2','Открыта регистрация',2,'Изменен content.'),(11,'2011-10-15 01:34:41',1,3,'2','lex',2,'Изменен email.'),(12,'2011-10-15 01:38:23',1,3,'2','lex',2,'Добавлен профиль \"UserProfile object\".'),(13,'2011-10-23 13:11:39',1,3,'3','qwe',3,''),(14,'2011-10-23 17:30:41',1,3,'6','lexqt',3,''),(15,'2011-10-23 17:30:41',1,3,'5','lol',3,''),(16,'2011-10-23 17:30:41',1,3,'4','qwe',3,''),(17,'2011-10-23 17:30:41',1,3,'7','re',3,''),(18,'2011-10-23 18:08:37',1,12,'1','Пробный курс',1,''),(19,'2011-10-23 19:18:10',1,12,'2','Test 2',1,''),(20,'2011-10-23 19:22:32',1,12,'2','Еще один пробный курс',2,'Изменен title и description.'),(21,'2011-10-23 19:23:17',1,12,'3','Основы jQuery',1,''),(22,'2011-10-23 19:23:53',1,12,'1','Пробный курс',2,'Изменен is_active.'),(23,'2011-10-23 21:50:37',1,12,'1','Пробный курс',2,'Изменен description.'),(24,'2011-10-24 00:47:14',1,14,'3','Application object',3,''),(25,'2011-10-24 00:47:14',1,14,'2','Application object',3,''),(26,'2011-10-24 00:47:14',1,14,'1','Application object',3,''),(27,'2011-10-24 00:47:59',1,13,'1','Enrollment object',1,''),(28,'2011-10-24 00:53:59',1,14,'5','Application object',3,''),(29,'2011-10-26 19:25:44',1,2,'1','student',1,''),(30,'2011-10-26 19:34:13',1,2,'1','registered',2,'Изменен name.'),(31,'2011-10-26 20:02:55',1,2,'1','newcomers',2,'Изменен name.'),(32,'2011-10-26 21:53:37',1,2,'2','managers',1,''),(33,'2011-10-26 21:54:09',1,3,'1','root',2,'Изменен groups.'),(34,'2011-10-26 23:59:22',1,3,'1','root',2,'Добавлен профиль \"  Рутович\".'),(35,'2011-10-27 00:38:58',1,3,'1','root',2,'Изменен first_name и last_name.'),(36,'2011-10-27 16:37:31',1,13,'2','Enrollment object',3,''),(37,'2011-10-27 16:37:31',1,13,'1','Enrollment object',3,''),(38,'2011-10-27 16:50:23',1,13,'3','Enrollment object',3,''),(39,'2011-10-27 16:52:40',1,13,'4','Enrollment object',3,''),(40,'2011-10-27 16:53:59',1,13,'5','Enrollment object',3,''),(41,'2011-10-27 16:55:57',1,13,'6','Enrollment object',3,''),(42,'2011-10-27 19:31:17',1,3,'2','lex',2,'Изменен groups.'),(43,'2011-10-27 19:32:08',1,2,'2','managers',2,'Изменен permissions.'),(44,'2011-10-27 20:40:32',1,2,'2','managers',2,'Изменен permissions.'),(45,'2011-10-27 20:43:31',1,13,'7','Enrollment object',1,''),(46,'2011-10-27 20:52:20',1,13,'7','Enrollment object',2,'Ни одно поле не изменено.'),(47,'2011-10-27 21:40:00',1,13,'8','Enrollment object',1,''),(48,'2011-10-27 21:40:33',1,13,'8','Enrollment object',3,''),(49,'2011-10-27 21:40:51',1,13,'9','Enrollment object',1,''),(50,'2011-10-27 21:41:10',1,13,'9','Enrollment object',3,''),(51,'2011-10-27 21:46:41',1,13,'10','Enrollment object',1,''),(52,'2011-10-27 21:55:52',1,13,'10','Enrollment object',3,''),(53,'2011-10-27 21:58:38',1,13,'11','Enrollment object',1,''),(54,'2011-10-27 22:42:26',1,13,'11','Enrollment object',3,''),(55,'2011-10-30 19:28:31',1,3,'2','lex',2,'Изменен groups.'),(56,'2011-10-30 21:08:00',1,2,'2','managers',2,'Изменен permissions.'),(57,'2011-10-30 21:08:19',1,3,'2','lex',2,'Изменен groups.'),(58,'2011-10-30 21:10:02',1,12,'2','Еще один пробный курс',2,'Изменен managers.'),(59,'2011-10-30 21:26:06',1,16,'1','Вводная часть',1,''),(60,'2011-10-30 22:25:14',1,12,'3','Основы jQuery',2,'Изменен managers. Добавлен раздел \"Базовая часть\".'),(61,'2011-10-31 15:40:49',1,17,'1','1. Вводная лекция',1,''),(62,'2011-10-31 19:49:25',1,18,'1','Вводная лекция',1,''),(63,'2011-10-31 20:20:47',1,18,'1','Вводная лекция',2,'Добавлен страница \"Вводная лекция - \"Глава 1\"\".'),(64,'2011-10-31 20:23:38',1,16,'1','Вводная часть',2,'Изменены num,element_type и object_id для элемент \"0. Вводная лекция\".'),(65,'2011-11-02 18:22:13',1,18,'2','Еще одна лекция',1,''),(66,'2011-11-02 20:05:28',1,18,'2','Еще одна лекция',2,'Добавлен страница \"Еще одна лекция - \"Просто страница\"\". Добавлен страница \"Еще одна лекция - \"Просто вторая страница\"\".'),(67,'2011-11-03 20:42:28',1,16,'1','Вводная часть',2,'Добавлен элемент \"0. Вводная лекция\".'),(68,'2011-11-03 20:43:08',1,16,'1','Вводная часть',2,'Добавлен элемент \"1. Вторая лекция\".'),(69,'2011-11-03 20:43:22',1,16,'1','Вводная часть',2,'Изменен num.'),(70,'2011-11-03 20:43:22',1,16,'2','Базовая часть',2,'Изменен num.'),(71,'2011-11-03 20:43:51',1,13,'12','root - Основы jQuery',1,''),(72,'2011-11-07 22:27:59',1,19,'4','Еще одна лекция - \"Просто вторая страница\"',2,'Изменен content.'),(73,'2011-11-07 22:42:22',1,19,'4','Еще одна лекция - \"Просто вторая страница\"',2,'Изменен content.'),(74,'2011-11-07 22:50:42',1,19,'4','Еще одна лекция - \"Просто вторая страница\"',2,'Изменен content.'),(75,'2011-11-07 22:55:02',1,19,'4','Еще одна лекция - \"Просто вторая страница\"',2,'Изменен content.'),(76,'2011-11-07 23:12:38',1,19,'4','Еще одна лекция - \"Просто вторая страница\"',2,'Изменен content.'),(77,'2011-11-07 23:13:11',1,18,'2','Еще одна лекция',2,'Изменены num и title для страница \"Еще одна лекция - \"Просто еще страница\"\". Изменены num и title для страница \"Еще одна лекция - \"Просто первая страница\"\".'),(78,'2011-11-07 23:13:47',1,18,'2','Еще одна лекция',2,'Ни одно поле не изменено.'),(79,'2011-11-07 23:14:24',1,18,'2','Еще одна лекция',2,'Изменены content для страница \"Еще одна лекция - \"Просто еще страница\"\".'),(80,'2011-11-07 23:15:28',1,18,'2','Еще одна лекция',2,'Ни одно поле не изменено.'),(81,'2011-11-14 20:17:03',1,21,'1','Dummy вопрос - выбрать один ответ',1,''),(82,'2011-11-14 22:01:52',1,21,'1','Dummy вопрос - выбрать один ответ',2,'Ни одно поле не изменено.'),(83,'2011-11-14 22:02:46',1,21,'1','Dummy вопрос - выбрать один ответ',2,'Ни одно поле не изменено.'),(84,'2011-11-14 22:06:42',1,21,'1','Dummy вопрос - выбрать один ответ',2,'Изменен frame_data.'),(85,'2011-11-14 22:08:40',1,21,'1','Dummy вопрос - выбрать один ответ',2,'Изменен frame_data.'),(86,'2011-11-14 23:13:23',1,21,'2','Dummy вопрос - выбрать несколько ответов',1,''),(87,'2011-11-15 14:31:37',1,21,'3','Dummy вопрос - написать слово',1,''),(88,'2011-11-17 22:16:50',1,3,'2','teacher',2,'Изменен username,first_name,last_name и email. Изменены middle_name для профиль \"Учителев Учитель Учителевич\".'),(89,'2011-11-17 22:18:26',1,3,'8','student',1,''),(90,'2011-11-17 22:18:57',1,3,'8','student',2,'Изменен first_name,last_name и email.'),(91,'2011-11-17 22:19:15',1,3,'1','root',2,'Изменен email.'),(92,'2011-11-17 22:41:59',1,13,'12','root - Основы jQuery',3,''),(93,'2011-11-17 22:42:18',1,12,'3','Основы jQuery',2,'Ни одно поле не изменено.'),(94,'2011-11-17 22:42:45',1,12,'1','Пробный курс',2,'Изменен managers.'),(95,'2011-11-17 22:44:15',2,13,'7','teacher - Основы jQuery',3,''),(96,'2011-11-17 22:45:11',1,13,'13','student - Основы jQuery',1,''),(97,'2011-11-18 14:31:00',1,26,'1','Тестовый тест',1,''),(98,'2011-11-18 19:07:27',1,16,'2','Базовая часть',2,'Добавлен элемент \"0. Пробный тест\".'),(99,'2011-11-18 21:32:23',1,24,'1','Session object',3,''),(100,'2011-11-18 21:32:37',1,23,'3','SessionFrame object',3,''),(101,'2011-11-18 21:32:37',1,23,'2','SessionFrame object',3,''),(102,'2011-11-18 21:32:37',1,23,'1','SessionFrame object',3,''),(103,'2011-11-18 21:57:45',1,24,'2','Session object',3,''),(104,'2011-11-18 21:59:43',1,24,'3','Session object',2,'Изменен cur_session_frame.'),(105,'2011-11-18 22:00:54',1,23,'9','SessionFrame object',2,'Изменен next_sframe.'),(106,'2011-11-18 22:01:00',1,23,'8','SessionFrame object',2,'Изменен next_sframe.'),(107,'2011-11-18 22:01:18',1,24,'3','Session object',3,''),(108,'2011-11-18 23:43:56',1,24,'4','Session object',3,''),(109,'2011-11-19 00:55:32',1,24,'10','Session object',3,''),(110,'2011-11-19 00:55:32',1,24,'9','Session object',3,''),(111,'2011-11-19 00:55:32',1,24,'8','Session object',3,''),(112,'2011-11-19 00:55:32',1,24,'7','Session object',3,''),(113,'2011-11-19 00:55:32',1,24,'6','Session object',3,''),(114,'2011-11-19 00:55:32',1,24,'5','Session object',3,''),(115,'2011-11-19 02:38:47',1,24,'15','Session object',3,''),(116,'2011-11-19 02:38:47',1,24,'14','Session object',3,''),(117,'2011-11-19 02:38:47',1,24,'13','Session object',3,''),(118,'2011-11-19 02:38:47',1,24,'12','Session object',3,''),(119,'2011-11-19 02:38:47',1,24,'11','Session object',3,''),(120,'2011-11-19 02:45:45',1,24,'16','Session object',3,''),(121,'2011-11-19 02:51:08',1,24,'17','Session object',3,''),(122,'2011-11-19 03:08:46',1,24,'23','Session object',3,''),(123,'2011-11-19 03:08:46',1,24,'22','Session object',3,''),(124,'2011-11-19 03:08:46',1,24,'21','Session object',3,''),(125,'2011-11-19 03:08:46',1,24,'20','Session object',3,''),(126,'2011-11-19 03:08:46',1,24,'19','Session object',3,''),(127,'2011-11-19 03:08:46',1,24,'18','Session object',3,''),(128,'2011-11-19 03:10:18',1,26,'2','Тестовый тест обучающий',1,''),(129,'2011-11-19 03:12:27',1,16,'2','Базовая часть',2,'Добавлен элемент \"1. Обучающий тест\". Изменены title для элемент \"0. Аттестующий тест\".'),(130,'2011-11-19 03:28:29',1,24,'29','Session object',3,''),(131,'2011-11-19 03:28:29',1,24,'28','Session object',3,''),(132,'2011-11-19 03:28:29',1,24,'27','Session object',3,''),(133,'2011-11-19 03:28:29',1,24,'26','Session object',3,''),(134,'2011-11-19 03:28:29',1,24,'25','Session object',3,''),(135,'2011-11-19 03:28:29',1,24,'24','Session object',3,''),(136,'2011-11-19 14:48:12',1,2,'3','students',1,''),(137,'2011-11-19 15:12:30',1,3,'8','student',2,'Изменен groups.'),(138,'2011-11-19 15:12:59',1,13,'14','student - Пробный курс',3,''),(139,'2011-11-19 15:14:13',1,13,'15','student - Пробный курс',3,''),(140,'2011-11-19 15:14:13',1,13,'16','student - Еще один пробный курс',3,''),(141,'2011-11-19 15:26:02',1,2,'2','managers',2,'Изменен permissions.'),(142,'2011-11-19 16:18:46',2,13,'17','root - Основы jQuery',1,''),(143,'2011-11-19 16:18:53',2,13,'17','root - Основы jQuery',3,''),(144,'2011-11-19 16:28:22',1,2,'2','managers',2,'Изменен permissions.'),(145,'2011-11-19 17:26:27',1,18,'1','Вводная лекция',2,'Изменен authors и courses_allowed.'),(146,'2011-11-19 17:28:42',2,18,'1','Вводная лекция',2,'Изменен courses_allowed.'),(147,'2011-11-19 17:28:57',1,18,'2','Еще одна лекция',2,'Изменен authors и courses_allowed.'),(148,'2011-11-19 17:31:20',1,18,'2','Еще одна лекция',2,'Изменен authors.'),(149,'2011-11-19 17:33:40',1,18,'2','Еще одна лекция',2,'Ни одно поле не изменено.'),(150,'2011-11-19 17:36:04',1,18,'2','Еще одна лекция',2,'Изменен authors.'),(151,'2011-11-19 17:36:20',1,18,'2','Еще одна лекция',2,'Изменен authors.'),(152,'2011-11-19 17:38:18',1,18,'2','Еще одна лекция',2,'Ни одно поле не изменено.'),(153,'2011-11-19 17:39:20',2,18,'3','fsfs',1,''),(154,'2011-11-19 17:40:25',1,18,'3','fsfs',2,'Изменен authors.'),(155,'2011-11-19 17:41:46',1,18,'3','fsfs',2,'Ни одно поле не изменено.'),(156,'2011-11-19 17:42:10',1,18,'3','fsfs',2,'Ни одно поле не изменено.'),(157,'2011-11-19 17:42:49',1,18,'3','fsfs',2,'Ни одно поле не изменено.'),(158,'2011-11-19 17:43:47',1,18,'3','fsfs',2,'Ни одно поле не изменено.'),(159,'2011-11-19 17:44:44',1,18,'3','fsfs',2,'Ни одно поле не изменено.'),(160,'2011-11-19 17:49:32',1,18,'3','fsfs',2,'Ни одно поле не изменено.'),(161,'2011-11-19 17:55:28',1,18,'3','fsfs',2,'Ни одно поле не изменено.'),(162,'2011-11-19 18:01:16',1,18,'3','fsfs',2,'Ни одно поле не изменено.'),(163,'2011-11-19 18:02:34',1,3,'8','student',2,'Ни одно поле не изменено.'),(164,'2011-11-19 18:21:08',1,18,'2','Еще одна лекция',2,'Изменен authors.'),(165,'2011-11-19 18:53:25',1,27,'1','Основы jQuery - 100',1,''),(166,'2011-11-19 20:58:41',1,2,'2','managers',2,'Изменен permissions.'),(167,'2011-11-19 21:06:23',1,27,'2','Еще один пробный курс - 500',1,''),(168,'2011-11-19 21:09:52',1,26,'3','Тест[500][102] \"Тестовый тест обучающий (копия)\"',1,''),(169,'2011-11-19 21:10:28',1,12,'2','Еще один пробный курс',2,'Изменен managers.'),(170,'2011-11-19 21:16:13',1,2,'2','managers',2,'Изменен permissions.'),(171,'2011-11-19 22:04:41',1,12,'1','Пробный курс',2,'Изменен managers.'),(172,'2011-11-19 22:06:25',1,18,'3','fsfs',2,'Изменен authors и courses_allowed.'),(173,'2011-11-19 22:18:27',2,18,'3','fsfs',2,'Ни одно поле не изменено.'),(174,'2011-11-19 22:18:38',2,18,'3','fsfs',2,'Ни одно поле не изменено.'),(175,'2011-11-19 22:19:15',2,18,'2','Еще одна лекция',2,'Ни одно поле не изменено.'),(176,'2011-11-19 22:19:27',2,18,'2','Еще одна лекция',2,'Ни одно поле не изменено.'),(177,'2011-11-19 22:19:48',2,18,'2','Еще одна лекция',2,'Удален страница \"Еще одна лекция - \"Просто еще страница\"\".'),(178,'2011-11-19 22:20:37',1,18,'2','Еще одна лекция',2,'Добавлен страница \"Еще одна лекция - \"Просто еще одна страница\"\".'),(179,'2011-11-19 22:33:51',2,19,'6','fsfs - \"fsfs page\"',1,''),(180,'2011-11-19 22:36:36',2,19,'2','Вводная лекция - \"Глава 1\"',2,'Ни одно поле не изменено.'),(181,'2011-11-19 22:39:45',2,19,'7','fsfs - \"fsfs page 2\"',1,''),(182,'2011-11-19 22:56:26',1,2,'2','managers',2,'Изменен permissions.'),(183,'2011-11-19 23:35:52',1,2,'2','managers',2,'Изменен permissions.'),(184,'2011-11-20 00:21:10',1,13,'18','root - Пробный курс',3,''),(185,'2011-11-20 00:21:10',1,13,'19','root - Еще один пробный курс',3,''),(186,'2011-11-20 00:27:58',1,13,'20','root - Пробный курс',3,''),(187,'2011-11-20 00:27:58',1,13,'21','root - Еще один пробный курс',3,''),(188,'2011-11-20 00:27:58',1,13,'22','root - Основы jQuery',3,''),(189,'2011-11-20 00:38:46',1,13,'25','root - Пробный курс',3,''),(190,'2011-11-20 00:38:46',1,13,'24','root - Еще один пробный курс',3,''),(191,'2011-11-20 00:38:46',1,13,'23','root - Основы jQuery',3,''),(192,'2011-11-20 00:40:15',2,13,'26','root - Пробный курс',3,''),(193,'2011-11-20 00:40:15',2,13,'27','root - Основы jQuery',3,''),(194,'2011-11-20 00:40:54',1,13,'28','root - Еще один пробный курс',3,''),(195,'2011-11-21 13:39:36',1,17,'2','0. Вводная лекция',2,'Изменен max_rating.'),(196,'2011-11-21 13:39:45',1,17,'3','1. Вторая лекция',2,'Изменен max_rating.'),(197,'2011-11-21 13:51:39',1,17,'5','1. Обучающий тест',2,'Изменен max_rating.'),(198,'2011-11-21 15:45:08',1,13,'29','root - Основы jQuery',1,''),(199,'2011-12-25 08:31:10',1,3,'15','qaw',3,''),(200,'2011-12-25 08:31:10',1,3,'14','t',3,''),(201,'2011-12-25 08:31:10',1,3,'13','ttttt',3,''),(202,'2011-12-25 08:31:10',1,3,'12','tttt',3,''),(203,'2011-12-25 08:31:10',1,3,'11','tt',3,''),(204,'2011-12-25 08:31:10',1,3,'10','test',3,''),(205,'2011-12-25 09:04:17',1,3,'16','sasf',3,''),(206,'2012-01-06 08:33:19',1,26,'2','Тест[100][102] \"Тестовый тест обучающий\"',2,'Изменен script_data.'),(207,'2012-01-06 08:33:39',1,26,'3','Тест[500][102] \"Тестовый тест обучающий (копия)\"',2,'Изменен script_data.'),(208,'2012-01-06 11:36:16',1,3,'17','tt',3,''),(209,'2012-01-06 11:55:42',1,3,'19','t',3,''),(210,'2012-01-06 11:55:42',1,3,'18','tt',3,''),(211,'2012-01-06 17:03:12',1,3,'24','ee',3,''),(212,'2012-01-06 17:03:12',1,3,'23','rr',3,''),(213,'2012-01-06 17:03:12',1,3,'22','r',3,''),(214,'2012-01-06 17:03:12',1,3,'21','ttt',3,''),(215,'2012-01-06 17:03:12',1,3,'20','tt',3,''),(216,'2012-01-08 23:20:47',1,3,'26','rrr',3,''),(217,'2012-01-08 23:20:47',1,3,'25','rr',3,''),(218,'2012-01-09 00:47:50',1,26,'2','Тест[100][102] \"Тестовый тест обучающий\"',2,'Изменен script_data.'),(219,'2012-01-09 00:49:16',1,26,'2','Тест[100][102] \"Тестовый тест обучающий\"',2,'Изменен script_data.'),(220,'2012-01-09 16:48:11',1,3,'27','ass',3,''),(221,'2012-01-10 01:16:12',1,3,'28','cativity',3,''),(222,'2012-01-10 04:19:19',1,3,'9','temp',3,''),(223,'2012-01-10 04:35:17',1,3,'30','t',3,'');
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
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'message','auth','message'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'log entry','admin','logentry'),(9,'article','news','article'),(10,'user profile','accounts','userprofile'),(11,'migration history','south','migrationhistory'),(12,'курс','courses','course'),(13,'запись на курсы','courses','enrollment'),(14,'заявка на курсы','courses','application'),(15,'аттестат','courses','certificate'),(16,'раздел','courses','part'),(17,'элемент','courses','element'),(18,'лекция','lectures','lecture'),(19,'страница','lectures','lecturepage'),(20,'результат','lectures','lectureresult'),(21,'тестовое задание','tests','testframe'),(23,'фрейм сессии прохождения теста','tests','sessionframe'),(24,'сессия прохождения теста','tests','session'),(25,'результат прохождения теста','tests','testresult'),(26,'тест','tests','test'),(27,'отношение Курс - Схема','tests','schemecourserelation');
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
INSERT INTO `django_session` VALUES ('9453e25b2928923a7d4250d572e6a330','MTQ3ODZhZjJjYzZmNWJkODY4NmJlMmUyMGE5NDZiNGJjNzZjM2NmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2011-10-21 17:10:33'),('f82d3dcad284c143e64d341e96f691d8','MTQ3ODZhZjJjYzZmNWJkODY4NmJlMmUyMGE5NDZiNGJjNzZjM2NmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2011-11-10 20:41:33'),('f5c2c2ee87794745ce8d8a7ed8439ed2','MTQ3ODZhZjJjYzZmNWJkODY4NmJlMmUyMGE5NDZiNGJjNzZjM2NmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2011-11-25 01:11:38'),('b3fca3476334585bc1dc9b44d72f9d08','ZmFkYTQ0OTdiZTBmMTI1ZjFhMjgyNzY5NzI5YzM1MmVjM2QyYjk0OTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQJ1Lg==\n','2011-11-13 19:28:56'),('449235d26b2a0031e5a7e5509c51d20a','MTQ3ODZhZjJjYzZmNWJkODY4NmJlMmUyMGE5NDZiNGJjNzZjM2NmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2011-12-01 23:34:36'),('17e753e25ed190ba219f23a9256208a8','ZmFkYTQ0OTdiZTBmMTI1ZjFhMjgyNzY5NzI5YzM1MmVjM2QyYjk0OTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQJ1Lg==\n','2011-12-03 15:25:15'),('8a4b0572eb2578ca837097d623197cf4','MTQ3ODZhZjJjYzZmNWJkODY4NmJlMmUyMGE5NDZiNGJjNzZjM2NmMTqAAn1xAShVEl9hdXRoX3Vz\nZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHED\nVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==\n','2012-01-24 05:59:33');
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
INSERT INTO `lections_lectionpage` VALUES (1,1,'Вступление','<p>Вступление, такое вступление!</p>',0),(2,1,'Глава 1','<p>Тут что-то пишем-пишем...</p>',1),(3,2,'Просто еще страница','<p><strong>Lorem</strong> ipsum dolor sit amet, consectetur adipiscing elit. Ut tincidunt purus leo, et pharetra turpis. Curabitur venenatis ultricies mauris sed rhoncus. Donec eu ipsum lectus. Integer vitae purus turpis, nec consectetur erat. Vestibulum sodales adipiscing mauris, a gravida justo lobortis sed. Pellentesque ipsum massa, varius vel elementum convallis, hendrerit id purus. Vestibulum ac dui at mi scelerisque sodales et at orci. Phasellus est urna, feugiat pellentesque fringilla a, tristique nec tortor.</p>\r\n<p>Integer nulla magna, ultrices eget vehicula ac, dignissim sed eros. Curabitur at felis ac sem placerat rutrum eu eget quam. Nunc gravida ipsum ante. Pellentesque aliquam eleifend leo sed condimentum. Cras congue pretium sem a eleifend. Suspendisse ut orci at nisl ullamcorper placerat. Cras sit amet mi et orci suscipit cursus. Suspendisse sit amet ipsum risus, sed aliquam lorem. Quisque aliquet velit eget velit dapibus vulputate. Nulla tincidunt orci id augue molestie pellentesque molestie nulla fringilla. Ut ante sapien, blandit in faucibus ac, porttitor bibendum odio.</p>\r\n<p>Donec id leo metus, non elementum justo. Aenean interdum vehicula vehicula. Nunc ultricies euismod justo, tincidunt adipiscing arcu pretium ac. Morbi molestie, tortor vitae dictum blandit, sem ligula suscipit lorem, vitae facilisis mi elit ut felis. Praesent vehicula, libero nec congue ultrices, lectus odio posuere metus, at laoreet mauris neque id mi. Fusce quis magna mauris, vel fringilla mi. Donec sem lacus, egestas vitae scelerisque quis, pellentesque sed nisl. In vel ultricies ligula. Cras elementum, ante sed viverra sodales, diam augue fermentum tortor, ut egestas urna est sodales enim. Nunc laoreet fermentum nisi, sit amet vulputate massa posuere accumsan.</p>\r\n<p>Nam eget nibh urna. Maecenas sed sem ipsum, ac congue metus. Duis eleifend odio quis leo egestas rhoncus. Pellentesque eget lacus nec tortor posuere interdum sit amet eget dolor. Nullam semper, nibh non facilisis consectetur, velit orci mollis elit, ut rutrum justo ipsum id mauris. Suspendisse dignissim viverra aliquam. Sed molestie arcu quis velit viverra rutrum. Pellentesque ut libero ligula. Nunc ac turpis nec velit facilisis mattis. Nam euismod convallis ipsum rutrum fringilla. Nam condimentum scelerisque varius. Vestibulum placerat bibendum neque, nec luctus elit facilisis vel. Sed varius urna eget turpis scelerisque non mollis purus convallis. Vestibulum nisl est, vulputate a hendrerit ac, eleifend quis nibh.</p>\r\n<p>Praesent pretium malesuada orci, nec lacinia massa semper sed. Suspendisse vel sapien nisl. Curabitur adipiscing suscipit sem vel suscipit. Praesent porttitor mi at erat adipiscing tristique adipiscing augue ornare. Ut luctus eleifend tellus id vestibulum. Quisque dui dolor, tempor quis sodales vel, commodo sed dolor. In sodales ante vitae turpis luctus tempus.</p>',1),(4,2,'Просто первая страница','<p><img style=\"border: 1px solid black; float: right;\" src=\"/media/jquery.png\" alt=\"Картинка\" width=\"250\" height=\"61\" /></p>\r\n<p>Lorem ipsum dolor sit amet,&nbsp;consectetur adipiscing elit. Integer nec eros nunc.</p>\r\n<p>07.11.2011. Vestibulum molestie enim ac tellus tincidunt aliquet. Duis posuere viverra mauris, a egestas est feugiat nec. Praesent ullamcorper quam quis tellus elementum sodales.</p>\r\n<p><iframe style=\"margin: 10px; float: left;\" src=\"http://www.youtube.com/embed/1B3Lcj9hRL0\" frameborder=\"1\" width=\"400\" height=\"233\"></iframe>Ut et neque non elit rutrum tincidunt quis et urna. Cras blandit, libero sed vulputate egestas, massa nibh porttitor nibh, eget ultrices neque velit id sapien. Maecenas vel purus urna. Donec nec libero arcu, sed facilisis tortor. Quisque laoreet dignissim nunc sed scelerisque.</p>\r\n<hr style=\"color: #ffffff; width: 100%; height: 2px; clear: both; border-style: solid; border-width: 1px; border-color: #cccccc;\" noshade=\"noshade\" size=\"2\" width=\"100%\" />\r\n<p>Proin ac ultricies purus. Quisque euismod magna sed tellus tincidunt ac tempor velit ultrices. Pellentesque lectus lectus, pharetra et posuere sed, gravida eu lorem. Curabitur eu urna ligula, quis suscipit tortor.</p>',0);
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
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lections_lectionresult`
--

LOCK TABLES `lections_lectionresult` WRITE;
/*!40000 ALTER TABLE `lections_lectionresult` DISABLE KEYS */;
INSERT INTO `lections_lectionresult` VALUES (1,2,3,1,1),(2,1,3,1,1);
/*!40000 ALTER TABLE `lections_lectionresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lectures_lecture`
--

DROP TABLE IF EXISTS `lectures_lecture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures_lecture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `description` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lectures_lecture`
--

LOCK TABLES `lectures_lecture` WRITE;
/*!40000 ALTER TABLE `lectures_lecture` DISABLE KEYS */;
INSERT INTO `lectures_lecture` VALUES (1,'Вводная лекция','<p>Лекция, такая лекция!</p>'),(2,'Еще одна лекция','<p>Lorem Ipsum.</p>'),(3,'fsfs','<p>fsfs</p>');
/*!40000 ALTER TABLE `lectures_lecture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lectures_lecture_authors`
--

DROP TABLE IF EXISTS `lectures_lecture_authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures_lecture_authors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lecture_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lectures_lecture_authors_lecture_id_287718b944566f51_uniq` (`lecture_id`,`user_id`),
  KEY `lectures_lecture_authors_94f9a4f9` (`lecture_id`),
  KEY `lectures_lecture_authors_fbfc09f1` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lectures_lecture_authors`
--

LOCK TABLES `lectures_lecture_authors` WRITE;
/*!40000 ALTER TABLE `lectures_lecture_authors` DISABLE KEYS */;
INSERT INTO `lectures_lecture_authors` VALUES (2,1,2),(34,2,1),(33,3,1);
/*!40000 ALTER TABLE `lectures_lecture_authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lectures_lecture_courses_allowed`
--

DROP TABLE IF EXISTS `lectures_lecture_courses_allowed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures_lecture_courses_allowed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lecture_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `lectures_lecture_courses_allow_lecture_id_7831eb4cf140b6de_uniq` (`lecture_id`,`course_id`),
  KEY `lectures_lecture_courses_allowed_94f9a4f9` (`lecture_id`),
  KEY `lectures_lecture_courses_allowed_ff48d8e5` (`course_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lectures_lecture_courses_allowed`
--

LOCK TABLES `lectures_lecture_courses_allowed` WRITE;
/*!40000 ALTER TABLE `lectures_lecture_courses_allowed` DISABLE KEYS */;
INSERT INTO `lectures_lecture_courses_allowed` VALUES (2,1,1),(3,1,3),(12,2,3),(11,3,3);
/*!40000 ALTER TABLE `lectures_lecture_courses_allowed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lectures_lecturepage`
--

DROP TABLE IF EXISTS `lectures_lecturepage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures_lecturepage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lecture_id` int(11) NOT NULL,
  `title` varchar(150) NOT NULL,
  `content` longtext NOT NULL,
  `num` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `lectures_lecturepage_cadd5579` (`lecture_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lectures_lecturepage`
--

LOCK TABLES `lectures_lecturepage` WRITE;
/*!40000 ALTER TABLE `lectures_lecturepage` DISABLE KEYS */;
INSERT INTO `lectures_lecturepage` VALUES (1,1,'Вступление','<p>Вступление, такое вступление!</p>',0),(2,1,'Глава 1','<p>Тут что-то пишем-пишем...</p>',1),(5,2,'Просто еще одна страница','<p><strong>Lorem</strong> ipsum dolor sit amet, consectetur adipiscing elit. Ut tincidunt purus leo, et pharetra turpis. Curabitur venenatis ultricies mauris sed rhoncus. Donec eu ipsum lectus. Integer vitae purus turpis, nec consectetur erat. Vestibulum sodales adipiscing mauris, a gravida justo lobortis sed. Pellentesque ipsum massa, varius vel elementum convallis, hendrerit id purus. Vestibulum ac dui at mi scelerisque sodales et at orci. Phasellus est urna, feugiat pellentesque fringilla a, tristique nec tortor.</p>\r\n<p>Integer nulla magna, ultrices eget vehicula ac, dignissim sed eros. Curabitur at felis ac sem placerat rutrum eu eget quam. Nunc gravida ipsum ante. Pellentesque aliquam eleifend leo sed condimentum. Cras congue pretium sem a eleifend. Suspendisse ut orci at nisl ullamcorper placerat. Cras sit amet mi et orci suscipit cursus. Suspendisse sit amet ipsum risus, sed aliquam lorem. Quisque aliquet velit eget velit dapibus vulputate. Nulla tincidunt orci id augue molestie pellentesque molestie nulla fringilla. Ut ante sapien, blandit in faucibus ac, porttitor bibendum odio.</p>\r\n<p>Donec id leo metus, non elementum justo. Aenean interdum vehicula vehicula. Nunc ultricies euismod justo, tincidunt adipiscing arcu pretium ac. Morbi molestie, tortor vitae dictum blandit, sem ligula suscipit lorem, vitae facilisis mi elit ut felis. Praesent vehicula, libero nec congue ultrices, lectus odio posuere metus, at laoreet mauris neque id mi. Fusce quis magna mauris, vel fringilla mi. Donec sem lacus, egestas vitae scelerisque quis, pellentesque sed nisl. In vel ultricies ligula. Cras elementum, ante sed viverra sodales, diam augue fermentum tortor, ut egestas urna est sodales enim. Nunc laoreet fermentum nisi, sit amet vulputate massa posuere accumsan.</p>\r\n<p>Nam eget nibh urna. Maecenas sed sem ipsum, ac congue metus. Duis eleifend odio quis leo egestas rhoncus. Pellentesque eget lacus nec tortor posuere interdum sit amet eget dolor. Nullam semper, nibh non facilisis consectetur, velit orci mollis elit, ut rutrum justo ipsum id mauris. Suspendisse dignissim viverra aliquam. Sed molestie arcu quis velit viverra rutrum. Pellentesque ut libero ligula. Nunc ac turpis nec velit facilisis mattis. Nam euismod convallis ipsum rutrum fringilla. Nam condimentum scelerisque varius. Vestibulum placerat bibendum neque, nec luctus elit facilisis vel. Sed varius urna eget turpis scelerisque non mollis purus convallis. Vestibulum nisl est, vulputate a hendrerit ac, eleifend quis nibh.</p>\r\n<p>Praesent pretium malesuada orci, nec lacinia massa semper sed. Suspendisse vel sapien nisl. Curabitur adipiscing suscipit sem vel suscipit. Praesent porttitor mi at erat adipiscing tristique adipiscing augue ornare. Ut luctus eleifend tellus id vestibulum. Quisque dui dolor, tempor quis sodales vel, commodo sed dolor. In sodales ante vitae turpis luctus tempus.</p>',1),(4,2,'Просто первая страница','<p><img style=\"border: 1px solid black; float: right;\" src=\"/media/jquery.png\" alt=\"Картинка\" width=\"250\" height=\"61\" /></p>\r\n<p>Lorem ipsum dolor sit amet,&nbsp;consectetur adipiscing elit. Integer nec eros nunc.</p>\r\n<p>07.11.2011. Vestibulum molestie enim ac tellus tincidunt aliquet. Duis posuere viverra mauris, a egestas est feugiat nec. Praesent ullamcorper quam quis tellus elementum sodales.</p>\r\n<p><iframe style=\"margin: 10px; float: left;\" src=\"http://www.youtube.com/embed/1B3Lcj9hRL0\" frameborder=\"1\" width=\"400\" height=\"233\"></iframe>Ut et neque non elit rutrum tincidunt quis et urna. Cras blandit, libero sed vulputate egestas, massa nibh porttitor nibh, eget ultrices neque velit id sapien. Maecenas vel purus urna. Donec nec libero arcu, sed facilisis tortor. Quisque laoreet dignissim nunc sed scelerisque.</p>\r\n<hr style=\"color: #ffffff; width: 100%; height: 2px; clear: both; border-style: solid; border-width: 1px; border-color: #cccccc;\" noshade=\"noshade\" size=\"2\" width=\"100%\" />\r\n<p>Proin ac ultricies purus. Quisque euismod magna sed tellus tincidunt ac tempor velit ultrices. Pellentesque lectus lectus, pharetra et posuere sed, gravida eu lorem. Curabitur eu urna ligula, quis suscipit tortor.</p>',0),(6,3,'fsfs page','<p>TODO</p>',0),(7,3,'fsfs page 2','<p>1d3 f23f ww</p>',1);
/*!40000 ALTER TABLE `lectures_lecturepage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lectures_lectureresult`
--

DROP TABLE IF EXISTS `lectures_lectureresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lectures_lectureresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lecture_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `is_passed` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `lectures_lectureresult_cadd5579` (`lecture_id`),
  KEY `lectures_lectureresult_ff48d8e5` (`course_id`),
  KEY `lectures_lectureresult_fbfc09f1` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lectures_lectureresult`
--

LOCK TABLES `lectures_lectureresult` WRITE;
/*!40000 ALTER TABLE `lectures_lectureresult` DISABLE KEYS */;
INSERT INTO `lectures_lectureresult` VALUES (1,2,3,1,1),(2,1,3,1,1);
/*!40000 ALTER TABLE `lectures_lectureresult` ENABLE KEYS */;
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
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
INSERT INTO `south_migrationhistory` VALUES (1,'accounts','0001_initial','2011-10-22 14:57:53'),(2,'news','0001_initial','2011-10-22 14:59:56'),(3,'courses','0001_initial','2011-10-23 14:04:31'),(4,'courses','0002_auto__del_field_course_active__add_field_course_is_active__chg_field_e','2011-10-23 14:37:13'),(5,'courses','0003_auto__add_field_course_date_created','2011-10-23 15:10:53'),(6,'courses','0004_auto__add_unique_enrollment_course_user__add_unique_application_course','2011-10-26 17:46:10'),(7,'courses','0005_auto__chg_field_part_num__chg_field_element_num','2011-10-30 19:03:40'),(8,'lectures','0001_initial','2011-10-31 14:45:59'),(9,'courses','0006_auto__add_field_element_max_rating','2011-10-31 14:47:21'),(10,'tests','0001_initial','2011-11-14 16:12:46'),(11,'tests','0002_auto__add_field_testframe_frame_type','2011-11-14 19:09:31'),(12,'tests','0003_auto__add_testresult__add_testscript__add_unique_testscript_scheme_scr','2011-11-17 18:04:58'),(13,'tests','0004_auto__del_testscript__del_unique_testscript_scheme_script_id__add_test','2011-11-18 10:19:09'),(14,'tests','0005_auto__del_field_session_script__add_field_session_test','2011-11-18 14:26:17'),(15,'tests','0006_auto__del_field_session_test__add_field_session_scheme__add_field_sess','2011-11-18 15:05:49'),(16,'tests','0007_auto__add_field_sessionframe_session','2011-11-18 15:24:05'),(17,'tests','0008_auto__add_field_testresult_is_passed','2011-11-18 16:32:10'),(18,'tests','0009_auto__add_field_testresult_scheme__add_field_testresult_script_id','2011-11-18 16:34:51'),(19,'tests','0010_auto__add_field_testresult_course__add_field_testresult_user__add_uniq','2011-11-18 17:30:02'),(20,'tests','0011_auto__chg_field_sessionframe_session','2011-11-18 17:35:44'),(21,'tests','0012_auto__del_field_sessionframe_frame__add_field_sessionframe_scheme__add','2011-11-18 17:45:52'),(22,'tests','0013_auto__add_field_session_rating_threshold','2011-11-18 19:28:22'),(23,'tests','0014_auto__del_unique_testresult_user','2011-11-18 20:54:56'),(24,'tests','0015_auto__add_field_session_is_exam','2011-11-18 22:25:58'),(25,'tests','0016_auto__chg_field_sessionframe_next_sframe__add_unique_sessionframe_next','2011-11-18 23:17:08'),(26,'lectures','0002_auto__chg_field_lecturepage_lecture__chg_field_lectureresult_lecture','2011-11-19 13:25:09'),(27,'tests','0017_auto__add_schemecourserelation__add_unique_schemecourserelation_course','2011-11-19 14:53:07');
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests_schemecourserelation`
--

DROP TABLE IF EXISTS `tests_schemecourserelation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests_schemecourserelation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `scheme` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tests_schemecourserelation_course_id_6c7177456efa67e7_uniq` (`course_id`,`scheme`),
  KEY `tests_schemecourserelation_ff48d8e5` (`course_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests_schemecourserelation`
--

LOCK TABLES `tests_schemecourserelation` WRITE;
/*!40000 ALTER TABLE `tests_schemecourserelation` DISABLE KEYS */;
INSERT INTO `tests_schemecourserelation` VALUES (1,3,100),(2,2,500);
/*!40000 ALTER TABLE `tests_schemecourserelation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests_session`
--

DROP TABLE IF EXISTS `tests_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests_session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `cur_session_frame_id` int(11) DEFAULT NULL,
  `num_passed` int(11) NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `is_finished` tinyint(1) NOT NULL DEFAULT '0',
  `date_started` datetime DEFAULT NULL,
  `date_ended` datetime DEFAULT NULL,
  `date_limit` datetime DEFAULT NULL,
  `scheme` int(10) unsigned NOT NULL,
  `script_id` int(10) unsigned NOT NULL,
  `rating_threshold` decimal(5,2) NOT NULL,
  `is_exam` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cur_session_frame_id` (`cur_session_frame_id`),
  KEY `tests_session_ff48d8e5` (`course_id`),
  KEY `user_id_refs_id_34f3175bc9ec8eab` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=209 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests_session`
--

LOCK TABLES `tests_session` WRITE;
/*!40000 ALTER TABLE `tests_session` DISABLE KEYS */;
INSERT INTO `tests_session` VALUES (33,1,3,NULL,3,0,1,'2011-11-21 13:50:39','2011-11-21 13:50:52','2011-11-21 13:50:54',100,102,'60.00',0),(32,1,3,NULL,3,0,1,'2011-11-21 13:45:27','2011-11-21 13:45:37','2011-11-21 13:55:27',100,101,'60.00',1),(31,1,3,NULL,1,0,1,'2011-11-19 14:40:39','2011-11-19 14:40:55','2011-11-19 14:40:54',100,102,'60.00',0),(30,1,3,NULL,3,0,1,'2011-11-19 14:24:34','2011-11-19 14:24:48','2011-11-19 14:24:49',100,102,'60.00',0),(34,1,3,NULL,1,0,1,'2011-12-19 13:37:19','2011-12-19 13:37:41','2011-12-19 13:37:34',100,102,'60.00',0),(38,1,3,NULL,0,0,1,'2011-12-30 06:10:56','2012-01-06 07:07:54','2011-12-30 06:11:11',100,102,'60.00',0),(39,1,3,NULL,0,0,1,'2012-01-06 07:08:49','2012-01-06 08:34:09','2012-01-06 07:09:04',100,102,'60.00',0),(208,1,3,NULL,1,0,1,'2012-01-10 06:19:57','2012-01-10 06:20:27','2012-01-10 06:20:12',100,102,'60.00',0),(207,1,3,NULL,1,0,1,'2012-01-10 06:19:28','2012-01-10 06:19:47','2012-01-10 06:19:43',100,102,'60.00',0),(206,1,3,NULL,0,0,1,'2012-01-10 06:08:48','2012-01-10 06:19:20','2012-01-10 06:09:03',100,102,'60.00',0),(205,1,3,NULL,0,0,1,'2012-01-10 06:03:34','2012-01-10 06:08:35','2012-01-10 06:03:49',100,102,'60.00',0),(204,1,3,NULL,0,0,1,'2012-01-10 05:45:43','2012-01-10 06:03:32','2012-01-10 05:45:58',100,102,'60.00',0),(203,1,3,NULL,0,0,1,'2012-01-10 05:42:29','2012-01-10 05:45:35','2012-01-10 05:42:44',100,102,'60.00',0),(202,1,3,NULL,0,0,1,'2012-01-10 05:34:26','2012-01-10 05:42:23','2012-01-10 05:34:41',100,102,'60.00',0),(201,1,3,NULL,0,0,1,'2012-01-10 05:30:52','2012-01-10 05:34:20','2012-01-10 05:31:07',100,102,'60.00',0),(200,1,3,NULL,0,0,1,'2012-01-10 05:24:29','2012-01-10 05:30:47','2012-01-10 05:24:44',100,102,'60.00',0),(199,1,3,NULL,0,0,1,'2012-01-10 05:22:34','2012-01-10 05:24:19','2012-01-10 05:22:49',100,102,'60.00',0),(198,1,3,NULL,0,0,1,'2012-01-10 05:21:37','2012-01-10 05:22:29','2012-01-10 05:21:52',100,102,'60.00',0),(197,1,3,NULL,0,0,1,'2012-01-10 04:50:10','2012-01-10 05:21:27','2012-01-10 04:50:25',100,102,'60.00',0),(54,1,3,NULL,0,0,1,'2012-01-06 08:34:11','2012-01-06 08:34:37','2012-01-06 08:34:26',100,102,'60.00',0),(55,1,3,NULL,0,0,1,'2012-01-06 08:34:38','2012-01-06 08:34:48','2012-01-06 08:34:53',100,102,'60.00',0),(56,1,3,NULL,0,0,1,'2012-01-06 08:34:52','2012-01-06 08:35:36','2012-01-06 08:35:07',100,102,'60.00',0),(57,1,3,NULL,0,0,1,'2012-01-06 08:35:38','2012-01-06 08:36:02','2012-01-06 08:35:53',100,102,'60.00',0),(58,1,3,NULL,0,0,1,'2012-01-06 08:36:03','2012-01-06 08:40:55','2012-01-06 08:36:18',100,102,'60.00',0),(59,1,3,NULL,0,0,1,'2012-01-06 08:40:57','2012-01-06 08:45:19','2012-01-06 08:41:12',100,102,'60.00',0),(60,1,3,NULL,0,0,1,'2012-01-06 08:45:20','2012-01-06 08:45:36','2012-01-06 08:45:35',100,102,'60.00',0),(61,1,3,NULL,0,0,1,'2012-01-06 08:45:37','2012-01-06 08:49:07','2012-01-06 08:45:52',100,102,'60.00',0),(62,1,3,NULL,0,0,1,'2012-01-06 08:49:08','2012-01-06 08:49:11','2012-01-06 08:49:23',100,102,'60.00',0),(63,1,3,NULL,0,0,1,'2012-01-06 08:49:12','2012-01-06 08:51:25','2012-01-06 08:49:27',100,102,'60.00',0),(64,1,3,NULL,0,0,1,'2012-01-06 08:51:27','2012-01-06 08:52:38','2012-01-06 08:51:42',100,102,'60.00',0),(65,1,3,NULL,0,0,1,'2012-01-06 08:52:39','2012-01-06 08:53:48','2012-01-06 08:52:54',100,102,'60.00',0),(66,1,3,NULL,0,0,1,'2012-01-06 08:53:49','2012-01-06 08:54:16','2012-01-06 08:54:04',100,102,'60.00',0),(67,1,3,NULL,0,0,1,'2012-01-06 08:54:18','2012-01-06 08:54:49','2012-01-06 08:54:33',100,102,'60.00',0),(68,1,3,NULL,0,0,1,'2012-01-06 08:54:51','2012-01-06 08:55:24','2012-01-06 08:55:06',100,102,'60.00',0),(69,1,3,NULL,0,0,1,'2012-01-06 08:55:25','2012-01-06 08:55:42','2012-01-06 08:55:40',100,102,'60.00',0),(70,1,3,NULL,0,0,1,'2012-01-06 08:56:11','2012-01-06 08:57:27','2012-01-06 08:56:26',100,102,'60.00',0),(71,1,3,NULL,0,0,1,'2012-01-06 08:57:28','2012-01-06 08:58:27','2012-01-06 08:57:43',100,102,'60.00',0),(72,1,3,NULL,0,0,1,'2012-01-06 08:58:29','2012-01-06 08:59:35','2012-01-06 08:58:44',100,102,'60.00',0),(73,1,3,NULL,0,0,1,'2012-01-06 08:59:37','2012-01-06 09:00:23','2012-01-06 08:59:52',100,102,'60.00',0),(74,1,3,NULL,0,0,1,'2012-01-06 09:00:25','2012-01-06 09:01:52','2012-01-06 09:00:40',100,102,'60.00',0),(75,1,3,NULL,0,0,1,'2012-01-06 09:01:53','2012-01-06 10:00:35','2012-01-06 09:02:08',100,102,'60.00',0),(76,1,3,NULL,0,0,1,'2012-01-06 10:00:44','2012-01-06 10:01:07','2012-01-06 10:00:59',100,102,'60.00',0),(77,1,3,NULL,0,0,1,'2012-01-06 10:01:13','2012-01-06 10:01:22','2012-01-06 10:01:28',100,102,'60.00',0),(78,1,3,NULL,0,0,1,'2012-01-06 10:01:25','2012-01-06 10:02:18','2012-01-06 10:01:40',100,102,'60.00',0),(79,1,3,NULL,0,0,1,'2012-01-06 10:02:22','2012-01-06 10:02:30','2012-01-06 10:02:37',100,102,'60.00',0),(80,1,3,NULL,0,0,1,'2012-01-06 10:02:41','2012-01-06 11:17:24','2012-01-06 10:02:56',100,102,'60.00',0),(81,1,3,NULL,0,0,1,'2012-01-06 11:19:50','2012-01-06 11:19:58','2012-01-06 11:20:05',100,102,'60.00',0),(82,1,3,NULL,0,0,1,'2012-01-06 11:20:25','2012-01-06 11:21:14','2012-01-06 11:20:40',100,102,'60.00',0),(83,1,3,NULL,0,0,1,'2012-01-06 11:25:23','2012-01-06 11:25:26','2012-01-06 11:25:38',100,102,'60.00',0),(84,1,3,NULL,0,0,1,'2012-01-06 11:25:47','2012-01-06 11:26:43','2012-01-06 11:26:02',100,102,'60.00',0),(85,1,3,NULL,0,0,1,'2012-01-06 11:27:58','2012-01-06 11:28:00','2012-01-06 11:28:13',100,102,'60.00',0),(86,1,3,NULL,0,0,1,'2012-01-06 11:29:43','2012-01-06 11:29:49','2012-01-06 11:29:58',100,102,'60.00',0),(87,1,3,NULL,0,0,1,'2012-01-06 11:29:58','2012-01-06 11:30:11','2012-01-06 11:30:13',100,102,'60.00',0),(88,1,3,NULL,0,0,1,'2012-01-06 11:31:07','2012-01-06 17:07:59','2012-01-06 11:31:22',100,102,'60.00',0),(89,1,3,NULL,0,0,1,'2012-01-06 17:08:53','2012-01-06 17:10:11','2012-01-06 17:09:08',100,102,'60.00',0),(90,1,3,NULL,0,0,1,'2012-01-06 17:22:08','2012-01-06 17:31:53','2012-01-06 17:22:23',100,102,'60.00',0),(91,1,3,NULL,0,0,1,'2012-01-06 17:44:35','2012-01-06 17:44:39','2012-01-06 17:44:50',100,102,'60.00',0),(92,1,3,NULL,0,0,1,'2012-01-06 17:45:24','2012-01-06 17:45:27','2012-01-06 17:45:39',100,102,'60.00',0),(93,1,3,NULL,0,0,1,'2012-01-06 17:46:00','2012-01-06 17:46:02','2012-01-06 17:46:15',100,102,'60.00',0),(94,1,3,NULL,0,0,1,'2012-01-06 17:46:30','2012-01-06 17:46:33','2012-01-06 17:46:45',100,102,'60.00',0),(95,1,3,NULL,0,0,1,'2012-01-06 17:47:57','2012-01-06 17:47:59','2012-01-06 17:48:12',100,102,'60.00',0),(96,1,3,NULL,0,0,1,'2012-01-06 17:51:59','2012-01-06 17:55:15','2012-01-06 17:52:14',100,102,'60.00',0),(97,1,3,NULL,0,0,1,'2012-01-06 17:57:31','2012-01-06 17:57:33','2012-01-06 17:57:46',100,102,'60.00',0),(98,1,3,NULL,0,0,1,'2012-01-06 17:58:37','2012-01-06 17:59:07','2012-01-06 17:58:52',100,102,'60.00',0),(99,1,3,NULL,0,0,1,'2012-01-06 17:59:32','2012-01-06 17:59:35','2012-01-06 17:59:47',100,102,'60.00',0),(100,1,3,NULL,0,0,1,'2012-01-06 18:00:21','2012-01-06 18:00:24','2012-01-06 18:00:36',100,102,'60.00',0),(101,1,3,NULL,0,0,1,'2012-01-06 18:00:51','2012-01-06 18:00:54','2012-01-06 18:01:06',100,102,'60.00',0),(102,1,3,NULL,0,0,1,'2012-01-06 18:03:20','2012-01-06 18:03:22','2012-01-06 18:03:35',100,102,'60.00',0),(103,1,3,NULL,0,0,1,'2012-01-06 18:03:54','2012-01-06 18:04:10','2012-01-06 18:04:09',100,102,'60.00',0),(104,1,3,NULL,0,0,1,'2012-01-08 16:22:56','2012-01-08 16:23:50','2012-01-08 16:23:11',100,102,'60.00',0),(105,1,3,NULL,0,0,1,'2012-01-08 16:39:12','2012-01-08 16:39:17','2012-01-08 16:39:27',100,102,'60.00',0),(106,1,3,NULL,0,0,1,'2012-01-08 16:42:04','2012-01-08 16:54:47','2012-01-08 16:42:19',100,102,'60.00',0),(107,1,3,NULL,0,0,1,'2012-01-08 17:01:16','2012-01-08 19:03:34','2012-01-08 17:01:31',100,102,'60.00',0),(108,1,3,NULL,0,0,1,'2012-01-08 19:03:53','2012-01-08 19:25:33','2012-01-08 19:04:08',100,102,'60.00',0),(109,1,3,NULL,0,0,1,'2012-01-08 19:25:44','2012-01-08 19:26:10','2012-01-08 19:25:59',100,102,'60.00',0),(110,1,3,NULL,0,0,1,'2012-01-08 19:27:37','2012-01-08 21:39:10','2012-01-08 19:27:52',100,102,'60.00',0),(111,1,3,NULL,0,0,1,'2012-01-08 21:47:59','2012-01-08 21:48:22','2012-01-08 21:48:14',100,102,'60.00',0),(112,1,3,NULL,0,0,1,'2012-01-08 21:48:45','2012-01-08 21:49:04','2012-01-08 21:49:00',100,102,'60.00',0),(113,1,3,NULL,0,0,1,'2012-01-08 21:49:08','2012-01-08 21:49:10','2012-01-08 21:49:23',100,102,'60.00',0),(114,1,3,NULL,0,0,1,'2012-01-08 22:08:08','2012-01-08 22:09:10','2012-01-08 22:08:23',100,102,'60.00',0),(115,1,3,NULL,0,0,1,'2012-01-08 22:11:02','2012-01-08 22:11:06','2012-01-08 22:11:17',100,102,'60.00',0),(116,1,3,NULL,0,0,1,'2012-01-08 22:11:21','2012-01-08 22:11:25','2012-01-08 22:11:36',100,102,'60.00',0),(117,1,3,NULL,0,0,1,'2012-01-08 22:34:58','2012-01-08 22:35:01','2012-01-08 22:35:13',100,102,'60.00',0),(118,1,3,NULL,0,0,1,'2012-01-08 22:48:46','2012-01-08 22:48:48','2012-01-08 22:49:01',100,102,'60.00',0),(119,1,3,NULL,0,0,1,'2012-01-08 22:50:22','2012-01-08 22:50:26','2012-01-08 22:50:37',100,102,'60.00',0),(120,1,3,NULL,0,0,1,'2012-01-08 22:51:08','2012-01-08 22:51:12','2012-01-08 22:51:23',100,102,'60.00',0),(121,1,3,NULL,0,0,1,'2012-01-08 22:58:33','2012-01-08 22:58:36','2012-01-08 22:58:48',100,102,'60.00',0),(122,1,3,NULL,0,0,1,'2012-01-08 22:58:58','2012-01-08 22:59:04','2012-01-08 22:59:13',100,102,'60.00',0),(123,1,3,NULL,0,0,1,'2012-01-08 23:00:45','2012-01-08 23:00:49','2012-01-08 23:01:00',100,102,'60.00',0),(124,1,3,NULL,0,0,1,'2012-01-08 23:04:39','2012-01-08 23:04:44','2012-01-08 23:04:54',100,102,'60.00',0),(125,1,3,NULL,0,0,1,'2012-01-08 23:07:50','2012-01-08 23:07:56','2012-01-08 23:08:05',100,102,'60.00',0),(126,1,3,NULL,0,0,1,'2012-01-08 23:09:06','2012-01-08 23:09:09','2012-01-08 23:09:21',100,102,'60.00',0),(127,1,3,NULL,0,0,1,'2012-01-08 23:09:57','2012-01-08 23:10:00','2012-01-08 23:10:12',100,102,'60.00',0),(128,1,3,NULL,0,0,1,'2012-01-08 23:11:05','2012-01-08 23:11:08','2012-01-08 23:11:20',100,102,'60.00',0),(129,1,3,NULL,0,0,1,'2012-01-08 23:55:50','2012-01-08 23:55:55','2012-01-08 23:56:05',100,102,'60.00',0),(130,1,3,NULL,0,0,1,'2012-01-08 23:56:01','2012-01-08 23:56:51','2012-01-08 23:56:16',100,102,'60.00',0),(131,1,3,NULL,0,0,1,'2012-01-09 00:00:58','2012-01-09 00:01:01','2012-01-09 00:01:13',100,102,'60.00',0),(132,1,3,NULL,0,0,1,'2012-01-09 00:11:07','2012-01-09 00:11:11','2012-01-09 00:11:22',100,102,'60.00',0),(133,1,3,NULL,0,0,1,'2012-01-09 00:12:40','2012-01-09 00:12:43','2012-01-09 00:12:55',100,102,'60.00',0),(134,1,3,NULL,0,0,1,'2012-01-09 00:16:12','2012-01-09 00:16:19','2012-01-09 00:16:27',100,102,'60.00',0),(135,1,3,NULL,0,0,1,'2012-01-09 00:18:42','2012-01-09 00:18:45','2012-01-09 00:18:57',100,102,'60.00',0),(136,1,3,NULL,0,0,1,'2012-01-09 00:25:58','2012-01-09 00:26:00','2012-01-09 00:26:13',100,102,'60.00',0),(137,1,3,NULL,0,0,1,'2012-01-09 00:27:24','2012-01-09 00:27:27','2012-01-09 00:27:39',100,102,'60.00',0),(138,1,3,NULL,0,0,1,'2012-01-09 00:32:30','2012-01-09 00:32:33','2012-01-09 00:32:45',100,102,'60.00',0),(139,1,3,NULL,0,0,1,'2012-01-09 00:33:49','2012-01-09 00:33:52','2012-01-09 00:34:04',100,102,'60.00',0),(140,1,3,NULL,0,0,1,'2012-01-09 00:36:33','2012-01-09 00:37:04','2012-01-09 00:36:48',100,102,'60.00',0),(141,1,3,NULL,0,0,1,'2012-01-09 00:37:12','2012-01-09 00:41:27','2012-01-09 00:37:27',100,102,'60.00',0),(142,1,3,NULL,0,0,1,'2012-01-09 00:45:31','2012-01-09 00:45:56','2012-01-09 00:45:46',100,102,'60.00',0),(143,1,3,NULL,1,0,1,'2012-01-09 00:46:05','2012-01-09 00:46:21','2012-01-09 00:46:20',100,102,'60.00',0),(144,1,3,NULL,2,0,1,'2012-01-09 00:46:25','2012-01-09 00:46:44','2012-01-09 00:46:40',100,102,'60.00',0),(145,1,3,NULL,2,0,1,'2012-01-09 00:46:55','2012-01-09 00:47:14','2012-01-09 00:47:10',100,102,'60.00',0),(146,1,3,NULL,3,0,1,'2012-01-09 00:47:59','2012-01-09 00:48:17','2012-01-09 00:48:24',100,102,'60.00',0),(196,29,3,NULL,3,0,1,'2012-01-10 04:42:13','2012-01-10 04:49:36','2012-01-10 04:52:13',100,101,'60.00',1),(148,1,3,NULL,0,0,1,'2012-01-09 01:00:43','2012-01-09 14:54:23','2012-01-09 01:00:58',100,102,'60.00',0),(149,1,3,NULL,0,0,1,'2012-01-09 14:54:31','2012-01-09 14:54:40','2012-01-09 14:54:46',100,102,'60.00',0),(150,1,3,NULL,0,0,1,'2012-01-09 14:54:53','2012-01-09 14:57:26','2012-01-09 14:55:08',100,102,'60.00',0),(151,1,3,NULL,0,0,1,'2012-01-09 14:57:30','2012-01-09 15:04:03','2012-01-09 14:57:45',100,102,'60.00',0),(152,1,3,NULL,1,0,1,'2012-01-09 15:04:10','2012-01-09 15:34:33','2012-01-09 15:04:25',100,102,'60.00',0),(153,1,3,NULL,2,0,1,'2012-01-09 15:34:44','2012-01-09 15:35:33','2012-01-09 15:34:59',100,102,'60.00',0),(154,1,3,NULL,0,0,1,'2012-01-09 15:35:40','2012-01-09 15:36:56','2012-01-09 15:35:55',100,102,'60.00',0),(155,1,3,NULL,0,0,1,'2012-01-09 15:37:01','2012-01-09 15:53:56','2012-01-09 15:37:16',100,102,'60.00',0),(156,1,3,NULL,0,0,1,'2012-01-09 15:54:59','2012-01-09 15:55:02','2012-01-09 15:55:14',100,102,'60.00',0),(157,1,3,NULL,0,0,1,'2012-01-09 15:55:26','2012-01-09 15:55:31','2012-01-09 15:55:41',100,102,'60.00',0),(158,1,3,NULL,0,0,1,'2012-01-09 15:55:58','2012-01-09 15:56:01','2012-01-09 15:56:13',100,102,'60.00',0),(159,1,3,NULL,0,0,1,'2012-01-09 15:56:35','2012-01-09 15:56:38','2012-01-09 15:56:50',100,102,'60.00',0),(160,1,3,NULL,0,0,1,'2012-01-09 15:56:49','2012-01-09 15:56:52','2012-01-09 15:57:04',100,102,'60.00',0),(161,1,3,NULL,0,0,1,'2012-01-09 15:56:57','2012-01-09 15:57:00','2012-01-09 15:57:12',100,102,'60.00',0),(162,1,3,NULL,0,0,1,'2012-01-09 15:57:25','2012-01-09 15:57:28','2012-01-09 15:57:40',100,102,'60.00',0),(163,1,3,NULL,0,0,1,'2012-01-09 15:59:00','2012-01-09 15:59:03','2012-01-09 15:59:15',100,102,'60.00',0),(164,1,3,NULL,0,0,1,'2012-01-09 16:00:50','2012-01-09 16:00:55','2012-01-09 16:01:05',100,102,'60.00',0),(165,1,3,NULL,0,0,1,'2012-01-09 16:01:19','2012-01-09 16:01:21','2012-01-09 16:01:34',100,102,'60.00',0),(166,1,3,NULL,0,0,1,'2012-01-09 16:01:48','2012-01-09 16:01:51','2012-01-09 16:02:03',100,102,'60.00',0),(167,1,3,NULL,0,0,1,'2012-01-09 16:03:42','2012-01-09 16:03:44','2012-01-09 16:03:57',100,102,'60.00',0),(168,1,3,NULL,0,0,1,'2012-01-09 16:04:07','2012-01-09 16:04:08','2012-01-09 16:04:22',100,102,'60.00',0),(169,1,3,NULL,0,0,1,'2012-01-09 16:04:24','2012-01-09 16:04:26','2012-01-09 16:04:39',100,102,'60.00',0),(170,1,3,NULL,0,0,1,'2012-01-09 16:06:06','2012-01-09 16:06:07','2012-01-09 16:06:21',100,102,'60.00',0),(171,1,3,NULL,0,0,1,'2012-01-09 16:13:29','2012-01-09 16:13:31','2012-01-09 16:13:44',100,102,'60.00',0),(172,1,3,NULL,0,0,1,'2012-01-09 16:14:03','2012-01-09 16:14:06','2012-01-09 16:14:18',100,102,'60.00',0),(173,1,3,NULL,0,0,1,'2012-01-09 16:15:04','2012-01-09 16:15:07','2012-01-09 16:15:19',100,102,'60.00',0),(174,1,3,NULL,0,0,1,'2012-01-09 16:16:59','2012-01-09 16:17:59','2012-01-09 16:17:14',100,102,'60.00',0),(175,1,3,NULL,0,0,1,'2012-01-09 16:56:30','2012-01-09 17:19:31','2012-01-09 16:56:45',100,102,'60.00',0),(176,1,3,NULL,0,0,1,'2012-01-09 17:20:03','2012-01-09 17:28:10','2012-01-09 17:20:18',100,102,'60.00',0),(177,1,3,NULL,0,0,1,'2012-01-09 17:28:30','2012-01-09 17:31:50','2012-01-09 17:28:45',100,102,'60.00',0),(178,1,3,NULL,1,0,1,'2012-01-09 17:31:56','2012-01-09 21:17:40','2012-01-09 17:32:11',100,102,'60.00',0),(179,1,3,NULL,1,0,1,'2012-01-09 21:17:48','2012-01-09 21:18:05','2012-01-09 21:18:03',100,102,'60.00',0),(180,1,3,NULL,1,0,1,'2012-01-09 21:18:14','2012-01-09 21:18:30','2012-01-09 21:18:29',100,102,'60.00',0),(181,1,3,NULL,2,0,1,'2012-01-09 21:19:02','2012-01-09 21:19:20','2012-01-09 21:19:17',100,102,'60.00',0),(182,1,3,NULL,0,0,1,'2012-01-09 21:19:47','2012-01-09 23:38:29','2012-01-09 21:20:02',100,102,'60.00',0),(183,1,3,NULL,2,0,1,'2012-01-09 23:38:35','2012-01-10 00:30:00','2012-01-09 23:38:50',100,102,'60.00',0),(184,1,3,NULL,0,0,1,'2012-01-10 00:34:43','2012-01-10 00:35:02','2012-01-10 00:34:58',100,102,'60.00',0),(185,1,3,NULL,0,0,1,'2012-01-10 00:35:46','2012-01-10 00:58:03','2012-01-10 00:36:01',100,102,'60.00',0),(186,1,3,NULL,0,0,1,'2012-01-10 00:59:22','2012-01-10 01:05:29','2012-01-10 00:59:37',100,102,'60.00',0),(187,1,3,NULL,0,0,1,'2012-01-10 01:05:42','2012-01-10 01:06:03','2012-01-10 01:05:57',100,102,'60.00',0),(188,1,3,NULL,2,0,1,'2012-01-10 01:06:11','2012-01-10 01:06:33','2012-01-10 01:06:26',100,102,'60.00',0),(189,1,3,NULL,0,0,1,'2012-01-10 01:19:27','2012-01-10 01:21:07','2012-01-10 01:19:42',100,102,'60.00',0),(190,1,3,NULL,0,0,1,'2012-01-10 01:22:10','2012-01-10 01:22:58','2012-01-10 01:22:25',100,102,'60.00',0),(191,1,3,NULL,0,0,1,'2012-01-10 01:24:31','2012-01-10 01:24:49','2012-01-10 01:24:46',100,102,'60.00',0),(192,1,3,NULL,0,0,1,'2012-01-10 01:24:51','2012-01-10 01:25:49','2012-01-10 01:25:06',100,102,'60.00',0),(193,1,3,NULL,0,0,1,'2012-01-10 01:26:01','2012-01-10 02:26:23','2012-01-10 01:26:16',100,102,'60.00',0),(194,1,3,NULL,2,0,1,'2012-01-10 02:26:32','2012-01-10 04:14:52','2012-01-10 02:26:47',100,102,'60.00',0),(195,1,3,NULL,0,0,1,'2012-01-10 04:14:59','2012-01-10 04:15:18','2012-01-10 04:15:14',100,102,'60.00',0);
/*!40000 ALTER TABLE `tests_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests_sessionframe`
--

DROP TABLE IF EXISTS `tests_sessionframe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests_sessionframe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_passed` tinyint(1) NOT NULL DEFAULT '0',
  `answer` longtext NOT NULL,
  `weight` int(11) NOT NULL DEFAULT '1',
  `rating` double NOT NULL DEFAULT '0',
  `next_sframe_id` int(11) DEFAULT NULL,
  `session_id` int(11) NOT NULL DEFAULT '0',
  `scheme` int(10) unsigned NOT NULL,
  `frame_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tests_sessionframe_next_sframe_id_uniq` (`next_sframe_id`),
  KEY `tests_sessionframe_4a441015` (`next_sframe_id`),
  KEY `tests_sessionframe_6b4dc4c3` (`session_id`)
) ENGINE=MyISAM AUTO_INCREMENT=625 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests_sessionframe`
--

LOCK TABLES `tests_sessionframe` WRITE;
/*!40000 ALTER TABLE `tests_sessionframe` DISABLE KEYS */;
INSERT INTO `tests_sessionframe` VALUES (99,1,'VariantID=1: \"первый\"',2,1,98,33,100,101),(97,1,'каша',3,1,NULL,33,100,111),(98,1,'VariantID=46: \"<i>третий</i>\"\nVariantID=75: \"первый\"',1,1,97,33,100,102),(94,1,'каша',3,1,NULL,32,100,111),(95,1,'VariantID=46: \"<i>третий</i>\"',1,0.5,94,32,100,102),(96,1,'VariantID=1: \"первый\"',2,1,95,32,100,101),(93,1,'VariantID=2: \"второй\"',2,0,92,31,100,101),(91,0,'',3,0,NULL,31,100,111),(92,0,'',1,0,91,31,100,102),(88,1,'каша',3,1,NULL,30,100,111),(89,1,'VariantID=75: \"первый\"\nVariantID=46: \"<i>третий</i>\"',1,1,88,30,100,102),(90,1,'VariantID=1: \"первый\"',2,1,89,30,100,101),(100,0,'',3,0,NULL,34,100,111),(101,0,'',1,0,100,34,100,102),(102,1,'VariantID=1: \"первый\"',2,1,101,34,100,101),(112,0,'',3,0,NULL,38,100,111),(113,0,'',1,0,112,38,100,102),(114,0,'',2,0,113,38,100,101),(115,0,'',3,0,NULL,39,100,111),(116,0,'',1,0,115,39,100,102),(117,0,'',2,0,116,39,100,101),(624,1,'VariantID=2: \"второй\"',2,0,623,208,100,101),(623,0,'',1,0,622,208,100,102),(622,0,'',3,0,NULL,208,100,111),(621,1,'VariantID=1: \"первый\"',2,1,620,207,100,101),(620,0,'',1,0,619,207,100,102),(619,0,'',3,0,NULL,207,100,111),(618,0,'',2,0,617,206,100,101),(617,0,'',1,0,616,206,100,102),(616,0,'',3,0,NULL,206,100,111),(615,0,'',2,0,614,205,100,101),(614,0,'',1,0,613,205,100,102),(613,0,'',3,0,NULL,205,100,111),(612,0,'',2,0,611,204,100,101),(611,0,'',1,0,610,204,100,102),(610,0,'',3,0,NULL,204,100,111),(609,0,'',2,0,608,203,100,101),(608,0,'',1,0,607,203,100,102),(607,0,'',3,0,NULL,203,100,111),(606,0,'',2,0,605,202,100,101),(605,0,'',1,0,604,202,100,102),(604,0,'',3,0,NULL,202,100,111),(603,0,'',2,0,602,201,100,101),(602,0,'',1,0,601,201,100,102),(601,0,'',3,0,NULL,201,100,111),(600,0,'',2,0,599,200,100,101),(599,0,'',1,0,598,200,100,102),(598,0,'',3,0,NULL,200,100,111),(597,0,'',2,0,596,199,100,101),(596,0,'',1,0,595,199,100,102),(595,0,'',3,0,NULL,199,100,111),(594,0,'',2,0,593,198,100,101),(593,0,'',1,0,592,198,100,102),(592,0,'',3,0,NULL,198,100,111),(591,0,'',2,0,590,197,100,101),(590,0,'',1,0,589,197,100,102),(589,0,'',3,0,NULL,197,100,111),(160,0,'',3,0,NULL,54,100,111),(161,0,'',1,0,160,54,100,102),(162,0,'',2,0,161,54,100,101),(163,0,'',3,0,NULL,55,100,111),(164,0,'',1,0,163,55,100,102),(165,0,'',2,0,164,55,100,101),(166,0,'',3,0,NULL,56,100,111),(167,0,'',1,0,166,56,100,102),(168,0,'',2,0,167,56,100,101),(169,0,'',3,0,NULL,57,100,111),(170,0,'',1,0,169,57,100,102),(171,0,'',2,0,170,57,100,101),(172,0,'',3,0,NULL,58,100,111),(173,0,'',1,0,172,58,100,102),(174,0,'',2,0,173,58,100,101),(175,0,'',3,0,NULL,59,100,111),(176,0,'',1,0,175,59,100,102),(177,0,'',2,0,176,59,100,101),(178,0,'',3,0,NULL,60,100,111),(179,0,'',1,0,178,60,100,102),(180,0,'',2,0,179,60,100,101),(181,0,'',3,0,NULL,61,100,111),(182,0,'',1,0,181,61,100,102),(183,0,'',2,0,182,61,100,101),(184,0,'',3,0,NULL,62,100,111),(185,0,'',1,0,184,62,100,102),(186,0,'',2,0,185,62,100,101),(187,0,'',3,0,NULL,63,100,111),(188,0,'',1,0,187,63,100,102),(189,0,'',2,0,188,63,100,101),(190,0,'',3,0,NULL,64,100,111),(191,0,'',1,0,190,64,100,102),(192,0,'',2,0,191,64,100,101),(193,0,'',3,0,NULL,65,100,111),(194,0,'',1,0,193,65,100,102),(195,0,'',2,0,194,65,100,101),(196,0,'',3,0,NULL,66,100,111),(197,0,'',1,0,196,66,100,102),(198,0,'',2,0,197,66,100,101),(199,0,'',3,0,NULL,67,100,111),(200,0,'',1,0,199,67,100,102),(201,0,'',2,0,200,67,100,101),(202,0,'',3,0,NULL,68,100,111),(203,0,'',1,0,202,68,100,102),(204,0,'',2,0,203,68,100,101),(205,0,'',3,0,NULL,69,100,111),(206,0,'',1,0,205,69,100,102),(207,0,'',2,0,206,69,100,101),(208,0,'',3,0,NULL,70,100,111),(209,0,'',1,0,208,70,100,102),(210,0,'',2,0,209,70,100,101),(211,0,'',3,0,NULL,71,100,111),(212,0,'',1,0,211,71,100,102),(213,0,'',2,0,212,71,100,101),(214,0,'',3,0,NULL,72,100,111),(215,0,'',1,0,214,72,100,102),(216,0,'',2,0,215,72,100,101),(217,0,'',3,0,NULL,73,100,111),(218,0,'',1,0,217,73,100,102),(219,0,'',2,0,218,73,100,101),(220,0,'',3,0,NULL,74,100,111),(221,0,'',1,0,220,74,100,102),(222,0,'',2,0,221,74,100,101),(223,0,'',3,0,NULL,75,100,111),(224,0,'',1,0,223,75,100,102),(225,0,'',2,0,224,75,100,101),(226,0,'',3,0,NULL,76,100,111),(227,0,'',1,0,226,76,100,102),(228,0,'',2,0,227,76,100,101),(229,0,'',3,0,NULL,77,100,111),(230,0,'',1,0,229,77,100,102),(231,0,'',2,0,230,77,100,101),(232,0,'',3,0,NULL,78,100,111),(233,0,'',1,0,232,78,100,102),(234,0,'',2,0,233,78,100,101),(235,0,'',3,0,NULL,79,100,111),(236,0,'',1,0,235,79,100,102),(237,0,'',2,0,236,79,100,101),(238,0,'',3,0,NULL,80,100,111),(239,0,'',1,0,238,80,100,102),(240,0,'',2,0,239,80,100,101),(241,0,'',3,0,NULL,81,100,111),(242,0,'',1,0,241,81,100,102),(243,0,'',2,0,242,81,100,101),(244,0,'',3,0,NULL,82,100,111),(245,0,'',1,0,244,82,100,102),(246,0,'',2,0,245,82,100,101),(247,0,'',3,0,NULL,83,100,111),(248,0,'',1,0,247,83,100,102),(249,0,'',2,0,248,83,100,101),(250,0,'',3,0,NULL,84,100,111),(251,0,'',1,0,250,84,100,102),(252,0,'',2,0,251,84,100,101),(253,0,'',3,0,NULL,85,100,111),(254,0,'',1,0,253,85,100,102),(255,0,'',2,0,254,85,100,101),(256,0,'',3,0,NULL,86,100,111),(257,0,'',1,0,256,86,100,102),(258,0,'',2,0,257,86,100,101),(259,0,'',3,0,NULL,87,100,111),(260,0,'',1,0,259,87,100,102),(261,0,'',2,0,260,87,100,101),(262,0,'',3,0,NULL,88,100,111),(263,0,'',1,0,262,88,100,102),(264,0,'',2,0,263,88,100,101),(265,0,'',3,0,NULL,89,100,111),(266,0,'',1,0,265,89,100,102),(267,0,'',2,0,266,89,100,101),(268,0,'',3,0,NULL,90,100,111),(269,0,'',1,0,268,90,100,102),(270,0,'',2,0,269,90,100,101),(271,0,'',3,0,NULL,91,100,111),(272,0,'',1,0,271,91,100,102),(273,0,'',2,0,272,91,100,101),(274,0,'',3,0,NULL,92,100,111),(275,0,'',1,0,274,92,100,102),(276,0,'',2,0,275,92,100,101),(277,0,'',3,0,NULL,93,100,111),(278,0,'',1,0,277,93,100,102),(279,0,'',2,0,278,93,100,101),(280,0,'',3,0,NULL,94,100,111),(281,0,'',1,0,280,94,100,102),(282,0,'',2,0,281,94,100,101),(283,0,'',3,0,NULL,95,100,111),(284,0,'',1,0,283,95,100,102),(285,0,'',2,0,284,95,100,101),(286,0,'',3,0,NULL,96,100,111),(287,0,'',1,0,286,96,100,102),(288,0,'',2,0,287,96,100,101),(289,0,'',3,0,NULL,97,100,111),(290,0,'',1,0,289,97,100,102),(291,0,'',2,0,290,97,100,101),(292,0,'',3,0,NULL,98,100,111),(293,0,'',1,0,292,98,100,102),(294,0,'',2,0,293,98,100,101),(295,0,'',3,0,NULL,99,100,111),(296,0,'',1,0,295,99,100,102),(297,0,'',2,0,296,99,100,101),(298,0,'',3,0,NULL,100,100,111),(299,0,'',1,0,298,100,100,102),(300,0,'',2,0,299,100,100,101),(301,0,'',3,0,NULL,101,100,111),(302,0,'',1,0,301,101,100,102),(303,0,'',2,0,302,101,100,101),(304,0,'',3,0,NULL,102,100,111),(305,0,'',1,0,304,102,100,102),(306,0,'',2,0,305,102,100,101),(307,0,'',3,0,NULL,103,100,111),(308,0,'',1,0,307,103,100,102),(309,0,'',2,0,308,103,100,101),(310,0,'',3,0,NULL,104,100,111),(311,0,'',1,0,310,104,100,102),(312,0,'',2,0,311,104,100,101),(313,0,'',3,0,NULL,105,100,111),(314,0,'',1,0,313,105,100,102),(315,0,'',2,0,314,105,100,101),(316,0,'',3,0,NULL,106,100,111),(317,0,'',1,0,316,106,100,102),(318,0,'',2,0,317,106,100,101),(319,0,'',3,0,NULL,107,100,111),(320,0,'',1,0,319,107,100,102),(321,0,'',2,0,320,107,100,101),(322,0,'',3,0,NULL,108,100,111),(323,0,'',1,0,322,108,100,102),(324,0,'',2,0,323,108,100,101),(325,0,'',3,0,NULL,109,100,111),(326,0,'',1,0,325,109,100,102),(327,0,'',2,0,326,109,100,101),(328,0,'',3,0,NULL,110,100,111),(329,0,'',1,0,328,110,100,102),(330,0,'',2,0,329,110,100,101),(331,0,'',3,0,NULL,111,100,111),(332,0,'',1,0,331,111,100,102),(333,0,'',2,0,332,111,100,101),(334,0,'',3,0,NULL,112,100,111),(335,0,'',1,0,334,112,100,102),(336,0,'',2,0,335,112,100,101),(337,0,'',3,0,NULL,113,100,111),(338,0,'',1,0,337,113,100,102),(339,0,'',2,0,338,113,100,101),(340,0,'',3,0,NULL,114,100,111),(341,0,'',1,0,340,114,100,102),(342,0,'',2,0,341,114,100,101),(343,0,'',3,0,NULL,115,100,111),(344,0,'',1,0,343,115,100,102),(345,0,'',2,0,344,115,100,101),(346,0,'',3,0,NULL,116,100,111),(347,0,'',1,0,346,116,100,102),(348,0,'',2,0,347,116,100,101),(349,0,'',3,0,NULL,117,100,111),(350,0,'',1,0,349,117,100,102),(351,0,'',2,0,350,117,100,101),(352,0,'',3,0,NULL,118,100,111),(353,0,'',1,0,352,118,100,102),(354,0,'',2,0,353,118,100,101),(355,0,'',3,0,NULL,119,100,111),(356,0,'',1,0,355,119,100,102),(357,0,'',2,0,356,119,100,101),(358,0,'',3,0,NULL,120,100,111),(359,0,'',1,0,358,120,100,102),(360,0,'',2,0,359,120,100,101),(361,0,'',3,0,NULL,121,100,111),(362,0,'',1,0,361,121,100,102),(363,0,'',2,0,362,121,100,101),(364,0,'',3,0,NULL,122,100,111),(365,0,'',1,0,364,122,100,102),(366,0,'',2,0,365,122,100,101),(367,0,'',3,0,NULL,123,100,111),(368,0,'',1,0,367,123,100,102),(369,0,'',2,0,368,123,100,101),(370,0,'',3,0,NULL,124,100,111),(371,0,'',1,0,370,124,100,102),(372,0,'',2,0,371,124,100,101),(373,0,'',3,0,NULL,125,100,111),(374,0,'',1,0,373,125,100,102),(375,0,'',2,0,374,125,100,101),(376,0,'',3,0,NULL,126,100,111),(377,0,'',1,0,376,126,100,102),(378,0,'',2,0,377,126,100,101),(379,0,'',3,0,NULL,127,100,111),(380,0,'',1,0,379,127,100,102),(381,0,'',2,0,380,127,100,101),(382,0,'',3,0,NULL,128,100,111),(383,0,'',1,0,382,128,100,102),(384,0,'',2,0,383,128,100,101),(385,0,'',3,0,NULL,129,100,111),(386,0,'',1,0,385,129,100,102),(387,0,'',2,0,386,129,100,101),(388,0,'',3,0,NULL,130,100,111),(389,0,'',1,0,388,130,100,102),(390,0,'',2,0,389,130,100,101),(391,0,'',3,0,NULL,131,100,111),(392,0,'',1,0,391,131,100,102),(393,0,'',2,0,392,131,100,101),(394,0,'',3,0,NULL,132,100,111),(395,0,'',1,0,394,132,100,102),(396,0,'',2,0,395,132,100,101),(397,0,'',3,0,NULL,133,100,111),(398,0,'',1,0,397,133,100,102),(399,0,'',2,0,398,133,100,101),(400,0,'',3,0,NULL,134,100,111),(401,0,'',1,0,400,134,100,102),(402,0,'',2,0,401,134,100,101),(403,0,'',3,0,NULL,135,100,111),(404,0,'',1,0,403,135,100,102),(405,0,'',2,0,404,135,100,101),(406,0,'',3,0,NULL,136,100,111),(407,0,'',1,0,406,136,100,102),(408,0,'',2,0,407,136,100,101),(409,0,'',3,0,NULL,137,100,111),(410,0,'',1,0,409,137,100,102),(411,0,'',2,0,410,137,100,101),(412,0,'',3,0,NULL,138,100,111),(413,0,'',1,0,412,138,100,102),(414,0,'',2,0,413,138,100,101),(415,0,'',3,0,NULL,139,100,111),(416,0,'',1,0,415,139,100,102),(417,0,'',2,0,416,139,100,101),(418,0,'',3,0,NULL,140,100,111),(419,0,'',1,0,418,140,100,102),(420,0,'',2,0,419,140,100,101),(421,0,'',3,0,NULL,141,100,111),(422,0,'',1,0,421,141,100,102),(423,0,'',2,0,422,141,100,101),(424,0,'',3,0,NULL,142,100,111),(425,0,'',1,0,424,142,100,102),(426,0,'',2,0,425,142,100,101),(427,0,'',3,0,NULL,143,100,111),(428,0,'',1,0,427,143,100,102),(429,1,'VariantID=1: \"первый\"',2,1,428,143,100,101),(430,0,'',3,0,NULL,144,100,111),(431,1,'VariantID=46: \"<i>третий</i>\"\nVariantID=75: \"первый\"',1,1,430,144,100,102),(432,1,'VariantID=1: \"первый\"',2,1,431,144,100,101),(433,0,'',3,0,NULL,145,100,111),(434,1,'VariantID=46: \"<i>третий</i>\"\nVariantID=75: \"первый\"',1,1,433,145,100,102),(435,1,'VariantID=1: \"первый\"',2,1,434,145,100,101),(436,1,'каша',3,1,NULL,146,100,111),(437,1,'VariantID=46: \"<i>третий</i>\"\nVariantID=75: \"первый\"',1,1,436,146,100,102),(438,1,'VariantID=1: \"первый\"',2,1,437,146,100,101),(586,1,'каша',3,1,NULL,196,100,111),(587,1,'VariantID=12: \"еще какой-то <b>вариант</b>\"',1,0,586,196,100,102),(588,1,'VariantID=1: \"первый\"',2,1,587,196,100,101),(442,0,'',3,0,NULL,148,100,111),(443,0,'',1,0,442,148,100,102),(444,0,'',2,0,443,148,100,101),(445,0,'',3,0,NULL,149,100,111),(446,0,'',1,0,445,149,100,102),(447,0,'',2,0,446,149,100,101),(448,0,'',3,0,NULL,150,100,111),(449,0,'',1,0,448,150,100,102),(450,0,'',2,0,449,150,100,101),(451,0,'',3,0,NULL,151,100,111),(452,0,'',1,0,451,151,100,102),(453,0,'',2,0,452,151,100,101),(454,0,'',3,0,NULL,152,100,111),(455,0,'',1,0,454,152,100,102),(456,1,'VariantID=2: \"второй\"',2,0,455,152,100,101),(457,0,'',3,0,NULL,153,100,111),(458,1,'VariantID=75: \"первый\"\nVariantID=46: \"<i>третий</i>\"',1,1,457,153,100,102),(459,1,'VariantID=2: \"второй\"',2,0,458,153,100,101),(460,0,'',3,0,NULL,154,100,111),(461,0,'',1,0,460,154,100,102),(462,0,'',2,0,461,154,100,101),(463,0,'',3,0,NULL,155,100,111),(464,0,'',1,0,463,155,100,102),(465,0,'',2,0,464,155,100,101),(466,0,'',3,0,NULL,156,100,111),(467,0,'',1,0,466,156,100,102),(468,0,'',2,0,467,156,100,101),(469,0,'',3,0,NULL,157,100,111),(470,0,'',1,0,469,157,100,102),(471,0,'',2,0,470,157,100,101),(472,0,'',3,0,NULL,158,100,111),(473,0,'',1,0,472,158,100,102),(474,0,'',2,0,473,158,100,101),(475,0,'',3,0,NULL,159,100,111),(476,0,'',1,0,475,159,100,102),(477,0,'',2,0,476,159,100,101),(478,0,'',3,0,NULL,160,100,111),(479,0,'',1,0,478,160,100,102),(480,0,'',2,0,479,160,100,101),(481,0,'',3,0,NULL,161,100,111),(482,0,'',1,0,481,161,100,102),(483,0,'',2,0,482,161,100,101),(484,0,'',3,0,NULL,162,100,111),(485,0,'',1,0,484,162,100,102),(486,0,'',2,0,485,162,100,101),(487,0,'',3,0,NULL,163,100,111),(488,0,'',1,0,487,163,100,102),(489,0,'',2,0,488,163,100,101),(490,0,'',3,0,NULL,164,100,111),(491,0,'',1,0,490,164,100,102),(492,0,'',2,0,491,164,100,101),(493,0,'',3,0,NULL,165,100,111),(494,0,'',1,0,493,165,100,102),(495,0,'',2,0,494,165,100,101),(496,0,'',3,0,NULL,166,100,111),(497,0,'',1,0,496,166,100,102),(498,0,'',2,0,497,166,100,101),(499,0,'',3,0,NULL,167,100,111),(500,0,'',1,0,499,167,100,102),(501,0,'',2,0,500,167,100,101),(502,0,'',3,0,NULL,168,100,111),(503,0,'',1,0,502,168,100,102),(504,0,'',2,0,503,168,100,101),(505,0,'',3,0,NULL,169,100,111),(506,0,'',1,0,505,169,100,102),(507,0,'',2,0,506,169,100,101),(508,0,'',3,0,NULL,170,100,111),(509,0,'',1,0,508,170,100,102),(510,0,'',2,0,509,170,100,101),(511,0,'',3,0,NULL,171,100,111),(512,0,'',1,0,511,171,100,102),(513,0,'',2,0,512,171,100,101),(514,0,'',3,0,NULL,172,100,111),(515,0,'',1,0,514,172,100,102),(516,0,'',2,0,515,172,100,101),(517,0,'',3,0,NULL,173,100,111),(518,0,'',1,0,517,173,100,102),(519,0,'',2,0,518,173,100,101),(520,0,'',3,0,NULL,174,100,111),(521,0,'',1,0,520,174,100,102),(522,0,'',2,0,521,174,100,101),(523,0,'',3,0,NULL,175,100,111),(524,0,'',1,0,523,175,100,102),(525,0,'',2,0,524,175,100,101),(526,0,'',3,0,NULL,176,100,111),(527,0,'',1,0,526,176,100,102),(528,0,'',2,0,527,176,100,101),(529,0,'',3,0,NULL,177,100,111),(530,0,'',1,0,529,177,100,102),(531,0,'',2,0,530,177,100,101),(532,0,'',3,0,NULL,178,100,111),(533,0,'',1,0,532,178,100,102),(534,1,'VariantID=1: \"первый\"',2,1,533,178,100,101),(535,0,'',3,0,NULL,179,100,111),(536,0,'',1,0,535,179,100,102),(537,1,'VariantID=2: \"второй\"',2,0,536,179,100,101),(538,0,'',3,0,NULL,180,100,111),(539,0,'',1,0,538,180,100,102),(540,1,'VariantID=2: \"второй\"',2,0,539,180,100,101),(541,0,'',3,0,NULL,181,100,111),(542,1,'VariantID=75: \"первый\"',1,0.5,541,181,100,102),(543,1,'VariantID=1: \"первый\"',2,1,542,181,100,101),(544,0,'',3,0,NULL,182,100,111),(545,0,'',1,0,544,182,100,102),(546,0,'',2,0,545,182,100,101),(547,0,'',3,0,NULL,183,100,111),(548,1,'VariantID=75: \"первый\"',1,0.5,547,183,100,102),(549,1,'VariantID=2: \"второй\"',2,0,548,183,100,101),(550,0,'',3,0,NULL,184,100,111),(551,0,'',1,0,550,184,100,102),(552,0,'',2,0,551,184,100,101),(553,0,'',3,0,NULL,185,100,111),(554,0,'',1,0,553,185,100,102),(555,0,'',2,0,554,185,100,101),(556,0,'',3,0,NULL,186,100,111),(557,0,'',1,0,556,186,100,102),(558,0,'',2,0,557,186,100,101),(559,0,'',3,0,NULL,187,100,111),(560,0,'',1,0,559,187,100,102),(561,0,'',2,0,560,187,100,101),(562,0,'',3,0,NULL,188,100,111),(563,1,'VariantID=88: \"второй\"',1,0,562,188,100,102),(564,1,'VariantID=1: \"первый\"',2,1,563,188,100,101),(565,0,'',3,0,NULL,189,100,111),(566,0,'',1,0,565,189,100,102),(567,0,'',2,0,566,189,100,101),(568,0,'',3,0,NULL,190,100,111),(569,0,'',1,0,568,190,100,102),(570,0,'',2,0,569,190,100,101),(571,0,'',3,0,NULL,191,100,111),(572,0,'',1,0,571,191,100,102),(573,0,'',2,0,572,191,100,101),(574,0,'',3,0,NULL,192,100,111),(575,0,'',1,0,574,192,100,102),(576,0,'',2,0,575,192,100,101),(577,0,'',3,0,NULL,193,100,111),(578,0,'',1,0,577,193,100,102),(579,0,'',2,0,578,193,100,101),(580,0,'',3,0,NULL,194,100,111),(581,1,'VariantID=12: \"еще какой-то <b>вариант</b>\"',1,0,580,194,100,102),(582,1,'VariantID=2: \"второй\"',2,0,581,194,100,101),(583,0,'',3,0,NULL,195,100,111),(584,0,'',1,0,583,195,100,102),(585,0,'',2,0,584,195,100,101);
/*!40000 ALTER TABLE `tests_sessionframe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests_test`
--

DROP TABLE IF EXISTS `tests_test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests_test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scheme` int(10) unsigned NOT NULL,
  `script_id` int(10) unsigned NOT NULL,
  `title` varchar(200) NOT NULL,
  `script_data` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tests_test_scheme_78289b72158bc1c3_uniq` (`scheme`,`script_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests_test`
--

LOCK TABLES `tests_test` WRITE;
/*!40000 ALTER TABLE `tests_test` DISABLE KEYS */;
INSERT INTO `tests_test` VALUES (1,100,101,'Тестовый тест','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<ScriptIndex Scheme=\"100\" ScriptID=\"101\">\r\n	<Test Name=\"Тестовый тест\" Mode=\"Exam\"\r\n		LimitOnScript=\"10\" TimeScale=\"Minute\">\r\n		<Description>\r\n			Аттествующий тест по ... Вам предстоит ответить на три вопроса.\r\n		</Description>\r\n		<TestGroup GroupID=\"1\">\r\n			<FrameIndex Scheme=\"100\" FrameID=\"101\">\r\n				<TestGroupItem GroupItemID=\"1\" Weight=\"2\" />\r\n			</FrameIndex>\r\n			<FrameIndex Scheme=\"100\" FrameID=\"102\">\r\n				<TestGroupItem GroupItemID=\"2\" Weight=\"1\" />\r\n			</FrameIndex>\r\n			<FrameIndex Scheme=\"100\" FrameID=\"111\">\r\n				<TestGroupItem GroupItemID=\"3\" Weight=\"3\" />\r\n			</FrameIndex>\r\n		</TestGroup>\r\n		<TestRules>\r\n			<TestRule Percent=\"60\" />\r\n		</TestRules>\r\n	</Test>\r\n</ScriptIndex>\r\n'),(2,100,102,'Тестовый тест обучающий','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<ScriptIndex Scheme=\"100\" ScriptID=\"102\">\r\n	<Test Name=\"Тестовый тест обучающий\" Mode=\"Learning\"\r\n		LimitOnScript=\"15\" TimeScale=\"Second\">\r\n		<Description>\r\n			<p>Обучающий тест по ... Вам предстоит ответить на три вопроса.</p>\r\n		</Description>\r\n		<TestGroup GroupID=\"1\">\r\n			<FrameIndex Scheme=\"100\" FrameID=\"101\">\r\n				<TestGroupItem GroupItemID=\"1\" Weight=\"2\" />\r\n			</FrameIndex>\r\n			<FrameIndex Scheme=\"100\" FrameID=\"102\">\r\n				<TestGroupItem GroupItemID=\"2\" Weight=\"1\" />\r\n			</FrameIndex>\r\n			<FrameIndex Scheme=\"100\" FrameID=\"111\">\r\n				<TestGroupItem GroupItemID=\"3\" Weight=\"3\" />\r\n			</FrameIndex>\r\n		</TestGroup>\r\n		<TestRules>\r\n			<TestRule Percent=\"60\" />\r\n		</TestRules>\r\n	</Test>\r\n</ScriptIndex>\r\n'),(3,500,102,'Тестовый тест обучающий (копия)','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<ScriptIndex Scheme=\"500\" ScriptID=\"102\">\r\n	<Test Name=\"Тестовый тест обучающий (копия)\" Mode=\"Learning\"\r\n		LimitOnScript=\"15\" TimeScale=\"Second\">\r\n		<Description>\r\n			<p>Обучающий тест по ... Вам предстоит ответить на три вопроса.</p>\r\n		</Description>\r\n		<TestGroup GroupID=\"1\">\r\n			<FrameIndex Scheme=\"100\" FrameID=\"101\">\r\n				<TestGroupItem GroupItemID=\"1\" Weight=\"2\" />\r\n			</FrameIndex>\r\n			<FrameIndex Scheme=\"100\" FrameID=\"102\">\r\n				<TestGroupItem GroupItemID=\"2\" Weight=\"1\" />\r\n			</FrameIndex>\r\n			<FrameIndex Scheme=\"100\" FrameID=\"111\">\r\n				<TestGroupItem GroupItemID=\"3\" Weight=\"3\" />\r\n			</FrameIndex>\r\n		</TestGroup>\r\n		<TestRules>\r\n			<TestRule Percent=\"60\" />\r\n		</TestRules>\r\n	</Test>\r\n</ScriptIndex>\r\n');
/*!40000 ALTER TABLE `tests_test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests_testframe`
--

DROP TABLE IF EXISTS `tests_testframe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests_testframe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scheme` int(10) unsigned NOT NULL,
  `frame_id` int(10) unsigned NOT NULL,
  `title` varchar(200) NOT NULL,
  `frame_data` longtext NOT NULL,
  `frame_type` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tests_testframe_scheme_7a7c34e90052ca72_uniq` (`scheme`,`frame_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests_testframe`
--

LOCK TABLES `tests_testframe` WRITE;
/*!40000 ALTER TABLE `tests_testframe` DISABLE KEYS */;
INSERT INTO `tests_testframe` VALUES (1,100,101,'Dummy вопрос - выбрать один ответ','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<FrameIndex Scheme=\"100\" FrameID=\"101\">\r\n	<TestFrame Name=\"Dummy вопрос - выбрать один ответ\">\r\n		<Data>\r\n			Выберите <b>первый</b> вариант.\r\n		</Data>\r\n		<Close>\r\n			<Variant Value=\"Right\" VariantID=\"1\">\r\n				<Data>\r\n					первый\r\n				</Data>\r\n			</Variant>\r\n			<Variant Value=\"Wrong\" VariantID=\"2\">\r\n				<Data>\r\n					второй\r\n				</Data>\r\n			</Variant>\r\n		</Close>\r\n	</TestFrame>\r\n</FrameIndex>','close'),(2,100,102,'Dummy вопрос - выбрать несколько ответов','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<FrameIndex Scheme=\"100\" FrameID=\"102\">\r\n	<TestFrame Name=\"Dummy вопрос - выбрать несколько ответов\">\r\n		<Data>\r\n			<p>Выберите <b>первый</b> и <b>третий</b> вариант.</p>\r\n		</Data>\r\n		<Close>\r\n			<Variant Value=\"Right\" VariantID=\"75\">\r\n				<Data>\r\n					первый\r\n				</Data>\r\n			</Variant>\r\n			<Variant Value=\"Wrong\" VariantID=\"88\">\r\n				<Data>\r\n					второй\r\n				</Data>\r\n			</Variant>\r\n			<Variant Value=\"Right\" VariantID=\"46\">\r\n				<Data>\r\n					<i>третий</i>\r\n				</Data>\r\n			</Variant>\r\n			<Variant Value=\"Wrong\" VariantID=\"12\">\r\n				<Data>\r\n					еще какой-то <b>вариант</b>\r\n				</Data>\r\n			</Variant>\r\n		</Close>\r\n	</TestFrame>\r\n</FrameIndex>\r\n','close'),(3,100,111,'Dummy вопрос - написать слово','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n<FrameIndex Scheme=\"100\" FrameID=\"111\">\r\n	<TestFrame Name=\"Dummy вопрос - написать слово\">\r\n		<Data>\r\n			Введите слово: <b>каша</b>.\r\n		</Data>\r\n		<Open>\r\n			<String Value=\"каша\" />\r\n		</Open>\r\n	</TestFrame>\r\n</FrameIndex>\r\n','open');
/*!40000 ALTER TABLE `tests_testframe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests_testresult`
--

DROP TABLE IF EXISTS `tests_testresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests_testresult` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `rating` decimal(5,2) NOT NULL DEFAULT '0.00',
  `try_number` smallint(6) NOT NULL DEFAULT '1',
  `is_passed` tinyint(1) NOT NULL,
  `scheme` int(10) unsigned NOT NULL,
  `script_id` int(10) unsigned NOT NULL,
  `course_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `session_id` (`session_id`),
  UNIQUE KEY `tests_testresult_course_id_3a3d217216119576_uniq` (`course_id`,`script_id`,`scheme`,`user_id`,`try_number`),
  KEY `tests_testresult_ff48d8e5` (`course_id`)
) ENGINE=MyISAM AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests_testresult`
--

LOCK TABLES `tests_testresult` WRITE;
/*!40000 ALTER TABLE `tests_testresult` DISABLE KEYS */;
INSERT INTO `tests_testresult` VALUES (23,33,'100.00',3,1,100,102,3,1),(22,32,'91.67',1,1,100,101,3,1),(21,31,'0.00',2,0,100,102,3,1),(20,30,'100.00',1,1,100,102,3,1),(24,34,'33.33',4,0,100,102,3,1),(28,38,'0.00',5,0,100,102,3,1),(198,208,'0.00',159,0,100,102,3,1),(197,207,'33.33',158,0,100,102,3,1),(196,206,'0.00',157,0,100,102,3,1),(195,205,'0.00',156,0,100,102,3,1),(194,204,'0.00',155,0,100,102,3,1),(193,203,'0.00',154,0,100,102,3,1),(192,202,'0.00',153,0,100,102,3,1),(191,201,'0.00',152,0,100,102,3,1),(190,200,'0.00',151,0,100,102,3,1),(189,199,'0.00',150,0,100,102,3,1),(188,198,'0.00',149,0,100,102,3,1),(42,39,'0.00',6,0,100,102,3,1),(43,54,'0.00',7,0,100,102,3,1),(44,55,'0.00',8,0,100,102,3,1),(45,56,'0.00',9,0,100,102,3,1),(46,57,'0.00',10,0,100,102,3,1),(47,58,'0.00',11,0,100,102,3,1),(48,59,'0.00',12,0,100,102,3,1),(49,60,'0.00',13,0,100,102,3,1),(50,61,'0.00',14,0,100,102,3,1),(51,62,'0.00',15,0,100,102,3,1),(52,63,'0.00',16,0,100,102,3,1),(53,64,'0.00',17,0,100,102,3,1),(54,65,'0.00',18,0,100,102,3,1),(55,66,'0.00',19,0,100,102,3,1),(56,67,'0.00',20,0,100,102,3,1),(57,68,'0.00',21,0,100,102,3,1),(58,69,'0.00',22,0,100,102,3,1),(59,70,'0.00',23,0,100,102,3,1),(60,71,'0.00',24,0,100,102,3,1),(61,72,'0.00',25,0,100,102,3,1),(62,73,'0.00',26,0,100,102,3,1),(63,74,'0.00',27,0,100,102,3,1),(64,75,'0.00',28,0,100,102,3,1),(65,76,'0.00',29,0,100,102,3,1),(66,77,'0.00',30,0,100,102,3,1),(67,78,'0.00',31,0,100,102,3,1),(68,79,'0.00',32,0,100,102,3,1),(69,80,'0.00',33,0,100,102,3,1),(70,81,'0.00',34,0,100,102,3,1),(71,82,'0.00',35,0,100,102,3,1),(72,83,'0.00',36,0,100,102,3,1),(73,84,'0.00',37,0,100,102,3,1),(74,85,'0.00',38,0,100,102,3,1),(75,86,'0.00',39,0,100,102,3,1),(76,87,'0.00',40,0,100,102,3,1),(77,88,'0.00',41,0,100,102,3,1),(78,89,'0.00',42,0,100,102,3,1),(79,90,'0.00',43,0,100,102,3,1),(80,91,'0.00',44,0,100,102,3,1),(81,92,'0.00',45,0,100,102,3,1),(82,93,'0.00',46,0,100,102,3,1),(83,94,'0.00',47,0,100,102,3,1),(84,95,'0.00',48,0,100,102,3,1),(85,96,'0.00',49,0,100,102,3,1),(86,97,'0.00',50,0,100,102,3,1),(87,98,'0.00',51,0,100,102,3,1),(88,99,'0.00',52,0,100,102,3,1),(89,100,'0.00',53,0,100,102,3,1),(90,101,'0.00',54,0,100,102,3,1),(91,102,'0.00',55,0,100,102,3,1),(92,103,'0.00',56,0,100,102,3,1),(93,104,'0.00',57,0,100,102,3,1),(94,105,'0.00',58,0,100,102,3,1),(95,106,'0.00',59,0,100,102,3,1),(96,107,'0.00',60,0,100,102,3,1),(97,108,'0.00',61,0,100,102,3,1),(98,109,'0.00',62,0,100,102,3,1),(99,110,'0.00',63,0,100,102,3,1),(100,111,'0.00',64,0,100,102,3,1),(101,112,'0.00',65,0,100,102,3,1),(102,113,'0.00',66,0,100,102,3,1),(103,114,'0.00',67,0,100,102,3,1),(104,115,'0.00',68,0,100,102,3,1),(105,116,'0.00',69,0,100,102,3,1),(106,117,'0.00',70,0,100,102,3,1),(107,118,'0.00',71,0,100,102,3,1),(108,119,'0.00',72,0,100,102,3,1),(109,120,'0.00',73,0,100,102,3,1),(110,121,'0.00',74,0,100,102,3,1),(111,122,'0.00',75,0,100,102,3,1),(112,123,'0.00',76,0,100,102,3,1),(113,124,'0.00',77,0,100,102,3,1),(114,125,'0.00',78,0,100,102,3,1),(115,126,'0.00',79,0,100,102,3,1),(116,127,'0.00',80,0,100,102,3,1),(117,128,'0.00',81,0,100,102,3,1),(118,129,'0.00',82,0,100,102,3,1),(119,130,'0.00',83,0,100,102,3,1),(120,131,'0.00',84,0,100,102,3,1),(121,132,'0.00',85,0,100,102,3,1),(122,133,'0.00',86,0,100,102,3,1),(123,134,'0.00',87,0,100,102,3,1),(124,135,'0.00',88,0,100,102,3,1),(125,136,'0.00',89,0,100,102,3,1),(126,137,'0.00',90,0,100,102,3,1),(127,138,'0.00',91,0,100,102,3,1),(128,139,'0.00',92,0,100,102,3,1),(129,140,'0.00',93,0,100,102,3,1),(130,141,'0.00',94,0,100,102,3,1),(131,142,'0.00',95,0,100,102,3,1),(132,143,'33.33',96,0,100,102,3,1),(133,144,'50.00',97,0,100,102,3,1),(134,145,'50.00',98,0,100,102,3,1),(135,146,'100.00',99,1,100,102,3,1),(187,197,'0.00',148,0,100,102,3,1),(186,196,'83.33',1,1,100,101,3,29),(138,148,'0.00',100,0,100,102,3,1),(139,149,'0.00',101,0,100,102,3,1),(140,150,'0.00',102,0,100,102,3,1),(141,151,'0.00',103,0,100,102,3,1),(142,152,'0.00',104,0,100,102,3,1),(143,153,'16.67',105,0,100,102,3,1),(144,154,'0.00',106,0,100,102,3,1),(145,155,'0.00',107,0,100,102,3,1),(146,156,'0.00',108,0,100,102,3,1),(147,157,'0.00',109,0,100,102,3,1),(148,158,'0.00',110,0,100,102,3,1),(149,159,'0.00',111,0,100,102,3,1),(150,160,'0.00',112,0,100,102,3,1),(151,161,'0.00',113,0,100,102,3,1),(152,162,'0.00',114,0,100,102,3,1),(153,163,'0.00',115,0,100,102,3,1),(154,164,'0.00',116,0,100,102,3,1),(155,165,'0.00',117,0,100,102,3,1),(156,166,'0.00',118,0,100,102,3,1),(157,167,'0.00',119,0,100,102,3,1),(158,168,'0.00',120,0,100,102,3,1),(159,169,'0.00',121,0,100,102,3,1),(160,170,'0.00',122,0,100,102,3,1),(161,171,'0.00',123,0,100,102,3,1),(162,172,'0.00',124,0,100,102,3,1),(163,173,'0.00',125,0,100,102,3,1),(164,174,'0.00',126,0,100,102,3,1),(165,175,'0.00',127,0,100,102,3,1),(166,176,'0.00',128,0,100,102,3,1),(167,177,'0.00',129,0,100,102,3,1),(168,178,'33.33',130,0,100,102,3,1),(169,179,'0.00',131,0,100,102,3,1),(170,180,'0.00',132,0,100,102,3,1),(171,181,'41.67',133,0,100,102,3,1),(172,182,'0.00',134,0,100,102,3,1),(173,183,'8.33',135,0,100,102,3,1),(174,184,'0.00',136,0,100,102,3,1),(175,185,'0.00',137,0,100,102,3,1),(176,186,'0.00',138,0,100,102,3,1),(177,187,'0.00',139,0,100,102,3,1),(178,188,'33.33',140,0,100,102,3,1),(179,189,'0.00',141,0,100,102,3,1),(180,190,'0.00',142,0,100,102,3,1),(181,191,'0.00',143,0,100,102,3,1),(182,192,'0.00',144,0,100,102,3,1),(183,193,'0.00',145,0,100,102,3,1),(184,194,'0.00',146,0,100,102,3,1),(185,195,'0.00',147,0,100,102,3,1);
/*!40000 ALTER TABLE `tests_testresult` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests_testscript`
--

DROP TABLE IF EXISTS `tests_testscript`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tests_testscript` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `scheme` int(10) unsigned NOT NULL,
  `script_id` int(10) unsigned NOT NULL,
  `title` varchar(200) NOT NULL,
  `script_data` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tests_testscript_scheme_26a61b096bcecc86_uniq` (`scheme`,`script_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests_testscript`
--

LOCK TABLES `tests_testscript` WRITE;
/*!40000 ALTER TABLE `tests_testscript` DISABLE KEYS */;
/*!40000 ALTER TABLE `tests_testscript` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-01-10  6:26:14
