# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.7.21)
# Database: ryans-list
# Generation Time: 2018-04-17 07:20:39 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `parent_id` int(11) unsigned DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subcat-cat-fk` (`parent_id`),
  CONSTRAINT `subcat-cat-fk` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `title`, `parent_id`, `slug`)
VALUES
	(1,'community',NULL,'community'),
	(2,'services',NULL,'services'),
	(3,'housing',NULL,'housing'),
	(4,'for sale',NULL,'for-sale'),
	(5,'jobs',NULL,'jobs'),
	(6,'activities',1,'activities'),
	(7,'artists',1,'artists'),
	(8,'automotive',2,'automotive'),
	(9,'beauty',2,'beauty'),
	(10,'apts/housing',3,'apts-housing'),
	(11,'housing swap',3,'housing-swap'),
	(12,'antiques',4,'antiques'),
	(13,'appliances',4,'appliances'),
	(14,'accounting+finance',5,'accounting-finance'),
	(15,'admin/office',5,'admin-office'),
	(16,'parking/storage',3,'parking-storage'),
	(17,'childcare',1,'childcare'),
	(18,'classes',1,'classes'),
	(19,'events',1,'events'),
	(20,'general',1,'general'),
	(21,'groups',1,'groups'),
	(22,'local news',1,'local-news'),
	(23,'lost+found',1,'lost-found'),
	(24,'missed connections',1,'missed-connections'),
	(25,'cell/mobile',2,'cell-mobile'),
	(26,'computer',2,'computer'),
	(27,'creative',2,'creative'),
	(28,'cycle',2,'cycle'),
	(29,'event',2,'event'),
	(30,'farm+garden',2,'farm-garden'),
	(31,'financial',2,'financial'),
	(32,'housing wanted',3,'housing-wanted'),
	(33,'office/commercial',3,'office-commercial'),
	(34,'parking/storage',3,'parking-storage'),
	(35,'real estate for sale',3,'real-estate-for-sale'),
	(36,'rooms/shared',3,'rooms-shared');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `images`;

CREATE TABLE `images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) unsigned DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `img-listing-fk` (`listing_id`),
  CONSTRAINT `img-listing-fk` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;

INSERT INTO `images` (`id`, `listing_id`, `image_path`)
VALUES
	(1,1,'http://placehold.it/300/300'),
	(2,2,'http://placehold.it/300/300'),
	(3,3,'http://placehold.it/300/300'),
	(4,4,'http://placehold.it/300/300'),
	(5,5,'http://placehold.it/300/300'),
	(6,6,'http://placehold.it/300/300'),
	(7,7,'http://placehold.it/300/300'),
	(8,8,'/uploads/d6b5de4bc4381897e14072a02559679d'),
	(9,9,'http://placehold.it/300/300'),
	(10,10,'/uploads/c9b9cf71f1135b207b0529cf333a588f');

/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table listings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `listings`;

CREATE TABLE `listings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` text,
  `description` text,
  `category_id` int(11) unsigned DEFAULT NULL,
  `date_created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `price` float(13,2) DEFAULT NULL,
  `zipcode` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listing-cat-fk` (`category_id`),
  CONSTRAINT `listing-cat-fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `listings` WRITE;
/*!40000 ALTER TABLE `listings` DISABLE KEYS */;

INSERT INTO `listings` (`id`, `title`, `description`, `category_id`, `date_created`, `price`, `zipcode`)
VALUES
	(1,'all artists welcome','come do an art',7,'2018-04-16 16:45:44',0.00,NULL),
	(2,'fun activity','cool thing',6,'2018-04-16 16:47:48',20.00,NULL),
	(3,'asdf','asdf',6,'2018-04-16 23:50:34',200.00,NULL),
	(4,'fdsa','fda',6,'2018-04-16 23:50:55',2.00,NULL),
	(5,'upload test','testing upload features',6,'2018-04-16 23:59:17',4000.00,12345),
	(6,'f','f',6,'2018-04-17 00:02:55',0.00,11234),
	(7,'f','f',6,'2018-04-17 00:12:56',0.00,1),
	(8,'f','f',6,'2018-04-17 00:14:06',0.00,1),
	(9,'f','f',6,'2018-04-17 00:17:41',0.00,0),
	(10,'new','new',6,'2018-04-17 00:18:19',0.00,0);

/*!40000 ALTER TABLE `listings` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
