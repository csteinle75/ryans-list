# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.7.21)
# Database: ryans-list
# Generation Time: 2018-04-16 15:02:01 +0000
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
	(4,'for_sale',NULL,'for-sale'),
	(5,'jobs',NULL,'jobs'),
	(6,'activities',1,'activities'),
	(7,'artists',1,'artists'),
	(8,'automotive',2,'automotive'),
	(9,'beauty',2,'beauty'),
	(10,'apts/housing',3,'apts-housing'),
	(11,'housing_swap',3,'housing-swap'),
	(12,'antiques',4,'antiques'),
	(13,'appliances',4,'appliances'),
	(14,'accounting+finance',5,'accounting-finance'),
	(15,'admin/office',5,'admin-office'),
	(16,'parking/storage',3,'parking-storage');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table images
# ------------------------------------------------------------

DROP TABLE IF EXISTS `images`;

CREATE TABLE `images` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `listing_id` int(11) unsigned DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;

INSERT INTO `images` (`id`, `listing_id`, `image_path`)
VALUES
	(1,42,'/uploads/ea71a40599d994def003b92894337715'),
	(2,43,'/uploads/b939f0a9c521e022eac9425f43639451'),
	(3,44,'/uploads/36a304a589ada2ff5816b6e6c3c10237'),
	(4,46,'/uploads/f08bde71cd495b438d6b819341db202a');

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
  PRIMARY KEY (`id`),
  KEY `listing-cat-fk` (`category_id`),
  CONSTRAINT `listing-cat-fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `listings` WRITE;
/*!40000 ALTER TABLE `listings` DISABLE KEYS */;

INSERT INTO `listings` (`id`, `title`, `description`, `category_id`)
VALUES
	(1,'some bs','this is an item, i\'ll sell it to you if you make it worth my while',6),
	(2,'more crap','more crap for sale buy if you want',10),
	(3,'big stupid thing','if you wanna look like a jerk, buy my big stupid thing',8),
	(4,'new activity','ay u wanna buy something?',6),
	(5,'jasdlfkj','09123049123',7),
	(16,'4','1234',6),
	(17,'j','trash',6),
	(18,'czx','zxc',6),
	(23,'test','test',6),
	(24,'test2','test2',15),
	(25,'another test','testing again',11),
	(26,'crap','also crap',11),
	(27,'encoding type test','jn',16),
	(39,'limited offer for a item with a really long name','real good deal',6),
	(40,'cz','ruff',6),
	(41,'fd','fd',7),
	(42,'upload test','this should upload and add to db',6),
	(43,'f','f',6),
	(44,'f','f',6),
	(45,'f','fc',6),
	(46,'demo listing','this listing will be used in testing',6);

/*!40000 ALTER TABLE `listings` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
