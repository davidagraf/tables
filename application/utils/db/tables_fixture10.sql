-- --------------------------------------------------------------------------------------
-- Generated SQL script 'tables_fixture10.sql' for TABLES
-- JSON Resources 'resources.json'
-- Created on 2011-06-29T16:04:38+02:00
-- --------------------------------------------------------------------------------------

DROP SCHEMA IF EXISTS `tables`;
CREATE SCHEMA `tables`;
USE `tables`;

-- --------------------------------------------------------------------------------------
-- Tables
-- --------------------------------------------------------------------------------------

-- Table computer

DROP TABLE IF EXISTS `computer`;

CREATE TABLE `computer` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `asset_tag` varchar(140) NOT NULL,
  `type` varchar(140) DEFAULT NULL,
  `brand` varchar(140) DEFAULT NULL,
  `model` varchar(140) DEFAULT NULL,
  `status` varchar(140) DEFAULT NULL,
  `name` varchar(140) DEFAULT NULL,
  `serial1` varchar(140) DEFAULT NULL,
  `serial2` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table peripherie

DROP TABLE IF EXISTS `peripherie`;

CREATE TABLE `peripherie` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `asset_tag` varchar(140) DEFAULT NULL,
  `type` varchar(140) DEFAULT NULL,
  `brand` varchar(140) DEFAULT NULL,
  `model` varchar(140) DEFAULT NULL,
  `status` varchar(140) DEFAULT NULL,
  `name` varchar(140) DEFAULT NULL,
  `serial1` varchar(140) DEFAULT NULL,
  `serial2` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table computerconfig

DROP TABLE IF EXISTS `computerconfig`;

CREATE TABLE `computerconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `os` varchar(140) DEFAULT NULL,
  `cpu` varchar(140) DEFAULT NULL,
  `nrcpus` varchar(140) DEFAULT NULL,
  `memory` varchar(140) DEFAULT NULL,
  `hdd` varchar(140) DEFAULT NULL,
  `extstor` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table peripherieconfig

DROP TABLE IF EXISTS `peripherieconfig`;

CREATE TABLE `peripherieconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table software

DROP TABLE IF EXISTS `software`;

CREATE TABLE `software` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) DEFAULT NULL,
  `version` varchar(140) DEFAULT NULL,
  `distributor` varchar(140) DEFAULT NULL,
  `license` varchar(140) DEFAULT NULL,
  `expiration` date DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table internalcontacts

DROP TABLE IF EXISTS `internalcontacts`;

CREATE TABLE `internalcontacts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) DEFAULT NULL,
  `firstname` varchar(140) DEFAULT NULL,
  `title` varchar(140) DEFAULT NULL,
  `orgunit` varchar(140) DEFAULT NULL,
  `phone1` varchar(140) DEFAULT NULL,
  `phone2` varchar(140) DEFAULT NULL,
  `email` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  `userfield1` varchar(1200) DEFAULT NULL,
  `userfield2` varchar(1200) DEFAULT NULL,
  `userfield3` varchar(1200) DEFAULT NULL,
  `userfield4` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table externalcontacts

DROP TABLE IF EXISTS `externalcontacts`;

CREATE TABLE `externalcontacts` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(140) DEFAULT NULL,
  `type` varchar(140) DEFAULT NULL,
  `address` varchar(140) DEFAULT NULL,
  `phone1` varchar(140) DEFAULT NULL,
  `phone2` varchar(140) DEFAULT NULL,
  `www` varchar(140) DEFAULT NULL,
  `name` varchar(140) DEFAULT NULL,
  `firstname` varchar(140) DEFAULT NULL,
  `title` varchar(140) DEFAULT NULL,
  `orgunit` varchar(140) DEFAULT NULL,
  `email` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  `userfield1` varchar(1200) DEFAULT NULL,
  `userfield2` varchar(1200) DEFAULT NULL,
  `userfield3` varchar(1200) DEFAULT NULL,
  `userfield4` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table ipaddress

DROP TABLE IF EXISTS `ipaddress`;

CREATE TABLE `ipaddress` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `asset_tag` varchar(140) DEFAULT NULL,
  `type` varchar(140) DEFAULT NULL,
  `brand` varchar(140) DEFAULT NULL,
  `model` varchar(140) DEFAULT NULL,
  `status` varchar(140) DEFAULT NULL,
  `name` varchar(140) DEFAULT NULL,
  `serial1` varchar(140) DEFAULT NULL,
  `serial2` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table network

DROP TABLE IF EXISTS `network`;

CREATE TABLE `network` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table domain

DROP TABLE IF EXISTS `domain`;

CREATE TABLE `domain` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------------------------------------
-- Relation Tables
-- --------------------------------------------------------------------------------------

-- Relation Table computer_software

DROP TABLE IF EXISTS `computer_software`;

CREATE TABLE `computer_software` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computer` int(11) unsigned NOT NULL,
  `software` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computer` (`computer`),
  KEY `software` (`software`),
  CONSTRAINT `computer_software_ibfk_2` FOREIGN KEY (`computer`) REFERENCES `computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computer_software_ibfk_3` FOREIGN KEY (`software`) REFERENCES `software` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table computer_computerconfig

DROP TABLE IF EXISTS `computer_computerconfig`;

CREATE TABLE `computer_computerconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computer` int(11) unsigned NOT NULL,
  `computerconfig` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computer` (`computer`),
  KEY `computerconfig` (`computerconfig`),
  CONSTRAINT `computer_computerconfig_ibfk_2` FOREIGN KEY (`computer`) REFERENCES `computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computer_computerconfig_ibfk_3` FOREIGN KEY (`computerconfig`) REFERENCES `computerconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table peripherie_peripherieconfig

DROP TABLE IF EXISTS `peripherie_peripherieconfig`;

CREATE TABLE `peripherie_peripherieconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `peripherie` int(11) unsigned NOT NULL,
  `peripherieconfig` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `peripherie` (`peripherie`),
  KEY `peripherieconfig` (`peripherieconfig`),
  CONSTRAINT `peripherie_peripherieconfig_ibfk_2` FOREIGN KEY (`peripherie`) REFERENCES `peripherie` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `peripherie_peripherieconfig_ibfk_3` FOREIGN KEY (`peripherieconfig`) REFERENCES `peripherieconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table computerconfig_network

DROP TABLE IF EXISTS `computerconfig_network`;

CREATE TABLE `computerconfig_network` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computerconfig` int(11) unsigned NOT NULL,
  `network` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computerconfig` (`computerconfig`),
  KEY `network` (`network`),
  CONSTRAINT `computerconfig_network_ibfk_2` FOREIGN KEY (`computerconfig`) REFERENCES `computerconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computerconfig_network_ibfk_3` FOREIGN KEY (`network`) REFERENCES `network` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table computerconfig_domain

DROP TABLE IF EXISTS `computerconfig_domain`;

CREATE TABLE `computerconfig_domain` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computerconfig` int(11) unsigned NOT NULL,
  `domain` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computerconfig` (`computerconfig`),
  KEY `domain` (`domain`),
  CONSTRAINT `computerconfig_domain_ibfk_2` FOREIGN KEY (`computerconfig`) REFERENCES `computerconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computerconfig_domain_ibfk_3` FOREIGN KEY (`domain`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table computerconfig_ipaddress

DROP TABLE IF EXISTS `computerconfig_ipaddress`;

CREATE TABLE `computerconfig_ipaddress` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computerconfig` int(11) unsigned NOT NULL,
  `ipaddress` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computerconfig` (`computerconfig`),
  KEY `ipaddress` (`ipaddress`),
  CONSTRAINT `computerconfig_ipaddress_ibfk_2` FOREIGN KEY (`computerconfig`) REFERENCES `computerconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computerconfig_ipaddress_ibfk_3` FOREIGN KEY (`ipaddress`) REFERENCES `ipaddress` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table network_peripherieconfig

DROP TABLE IF EXISTS `network_peripherieconfig`;

CREATE TABLE `network_peripherieconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `network` int(11) unsigned NOT NULL,
  `peripherieconfig` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `network` (`network`),
  KEY `peripherieconfig` (`peripherieconfig`),
  CONSTRAINT `network_peripherieconfig_ibfk_2` FOREIGN KEY (`network`) REFERENCES `network` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `network_peripherieconfig_ibfk_3` FOREIGN KEY (`peripherieconfig`) REFERENCES `peripherieconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table domain_peripherieconfig

DROP TABLE IF EXISTS `domain_peripherieconfig`;

CREATE TABLE `domain_peripherieconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain` int(11) unsigned NOT NULL,
  `peripherieconfig` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`),
  KEY `peripherieconfig` (`peripherieconfig`),
  CONSTRAINT `domain_peripherieconfig_ibfk_2` FOREIGN KEY (`domain`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `domain_peripherieconfig_ibfk_3` FOREIGN KEY (`peripherieconfig`) REFERENCES `peripherieconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table ipaddress_peripherieconfig

DROP TABLE IF EXISTS `ipaddress_peripherieconfig`;

CREATE TABLE `ipaddress_peripherieconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ipaddress` int(11) unsigned NOT NULL,
  `peripherieconfig` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ipaddress` (`ipaddress`),
  KEY `peripherieconfig` (`peripherieconfig`),
  CONSTRAINT `ipaddress_peripherieconfig_ibfk_2` FOREIGN KEY (`ipaddress`) REFERENCES `ipaddress` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipaddress_peripherieconfig_ibfk_3` FOREIGN KEY (`peripherieconfig`) REFERENCES `peripherieconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table ipaddress_software

DROP TABLE IF EXISTS `ipaddress_software`;

CREATE TABLE `ipaddress_software` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ipaddress` int(11) unsigned NOT NULL,
  `software` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ipaddress` (`ipaddress`),
  KEY `software` (`software`),
  CONSTRAINT `ipaddress_software_ibfk_2` FOREIGN KEY (`ipaddress`) REFERENCES `ipaddress` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipaddress_software_ibfk_3` FOREIGN KEY (`software`) REFERENCES `software` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table ipaddress_network

DROP TABLE IF EXISTS `ipaddress_network`;

CREATE TABLE `ipaddress_network` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ipaddress` int(11) unsigned NOT NULL,
  `network` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ipaddress` (`ipaddress`),
  KEY `network` (`network`),
  CONSTRAINT `ipaddress_network_ibfk_2` FOREIGN KEY (`ipaddress`) REFERENCES `ipaddress` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipaddress_network_ibfk_3` FOREIGN KEY (`network`) REFERENCES `network` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------------------------------------
-- Table Inserts (test data)
-- --------------------------------------------------------------------------------------

-- Table computer

LOCK TABLES `computer` WRITE;
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (1,'Asset TAG (1)','Typ (1)','Marke (1)','Model (1)','Status (1)','Name (1)','Seriennummer 1 (1)','Seriennummer 2 (1)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (2,'Asset TAG (2)','Typ (2)','Marke (2)','Model (2)','Status (2)','Name (2)','Seriennummer 1 (2)','Seriennummer 2 (2)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (3,'Asset TAG (3)','Typ (3)','Marke (3)','Model (3)','Status (3)','Name (3)','Seriennummer 1 (3)','Seriennummer 2 (3)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (4,'Asset TAG (4)','Typ (4)','Marke (4)','Model (4)','Status (4)','Name (4)','Seriennummer 1 (4)','Seriennummer 2 (4)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (5,'Asset TAG (5)','Typ (5)','Marke (5)','Model (5)','Status (5)','Name (5)','Seriennummer 1 (5)','Seriennummer 2 (5)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (6,'Asset TAG (6)','Typ (6)','Marke (6)','Model (6)','Status (6)','Name (6)','Seriennummer 1 (6)','Seriennummer 2 (6)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (7,'Asset TAG (7)','Typ (7)','Marke (7)','Model (7)','Status (7)','Name (7)','Seriennummer 1 (7)','Seriennummer 2 (7)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (8,'Asset TAG (8)','Typ (8)','Marke (8)','Model (8)','Status (8)','Name (8)','Seriennummer 1 (8)','Seriennummer 2 (8)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (9,'Asset TAG (9)','Typ (9)','Marke (9)','Model (9)','Status (9)','Name (9)','Seriennummer 1 (9)','Seriennummer 2 (9)');
INSERT INTO `computer` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (10,'Asset TAG (10)','Typ (10)','Marke (10)','Model (10)','Status (10)','Name (10)','Seriennummer 1 (10)','Seriennummer 2 (10)');

UNLOCK TABLES;

-- Table peripherie

LOCK TABLES `peripherie` WRITE;
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (1,'Asset TAG (1)','Typ (1)','Marke (1)','Model (1)','Status (1)','Name (1)','Seriennummer 1 (1)','Seriennummer 2 (1)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (2,'Asset TAG (2)','Typ (2)','Marke (2)','Model (2)','Status (2)','Name (2)','Seriennummer 1 (2)','Seriennummer 2 (2)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (3,'Asset TAG (3)','Typ (3)','Marke (3)','Model (3)','Status (3)','Name (3)','Seriennummer 1 (3)','Seriennummer 2 (3)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (4,'Asset TAG (4)','Typ (4)','Marke (4)','Model (4)','Status (4)','Name (4)','Seriennummer 1 (4)','Seriennummer 2 (4)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (5,'Asset TAG (5)','Typ (5)','Marke (5)','Model (5)','Status (5)','Name (5)','Seriennummer 1 (5)','Seriennummer 2 (5)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (6,'Asset TAG (6)','Typ (6)','Marke (6)','Model (6)','Status (6)','Name (6)','Seriennummer 1 (6)','Seriennummer 2 (6)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (7,'Asset TAG (7)','Typ (7)','Marke (7)','Model (7)','Status (7)','Name (7)','Seriennummer 1 (7)','Seriennummer 2 (7)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (8,'Asset TAG (8)','Typ (8)','Marke (8)','Model (8)','Status (8)','Name (8)','Seriennummer 1 (8)','Seriennummer 2 (8)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (9,'Asset TAG (9)','Typ (9)','Marke (9)','Model (9)','Status (9)','Name (9)','Seriennummer 1 (9)','Seriennummer 2 (9)');
INSERT INTO `peripherie` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (10,'Asset TAG (10)','Typ (10)','Marke (10)','Model (10)','Status (10)','Name (10)','Seriennummer 1 (10)','Seriennummer 2 (10)');

UNLOCK TABLES;

-- Table computerconfig

LOCK TABLES `computerconfig` WRITE;
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (1,'Betriebssystem (1)','CPU (1)','Anzahl Kerne (1)','Arbeitsspeicher (1)','Harddisk (1)','Externer Speicher (1)','Bemerkungen (1)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (2,'Betriebssystem (2)','CPU (2)','Anzahl Kerne (2)','Arbeitsspeicher (2)','Harddisk (2)','Externer Speicher (2)','Bemerkungen (2)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (3,'Betriebssystem (3)','CPU (3)','Anzahl Kerne (3)','Arbeitsspeicher (3)','Harddisk (3)','Externer Speicher (3)','Bemerkungen (3)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (4,'Betriebssystem (4)','CPU (4)','Anzahl Kerne (4)','Arbeitsspeicher (4)','Harddisk (4)','Externer Speicher (4)','Bemerkungen (4)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (5,'Betriebssystem (5)','CPU (5)','Anzahl Kerne (5)','Arbeitsspeicher (5)','Harddisk (5)','Externer Speicher (5)','Bemerkungen (5)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (6,'Betriebssystem (6)','CPU (6)','Anzahl Kerne (6)','Arbeitsspeicher (6)','Harddisk (6)','Externer Speicher (6)','Bemerkungen (6)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (7,'Betriebssystem (7)','CPU (7)','Anzahl Kerne (7)','Arbeitsspeicher (7)','Harddisk (7)','Externer Speicher (7)','Bemerkungen (7)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (8,'Betriebssystem (8)','CPU (8)','Anzahl Kerne (8)','Arbeitsspeicher (8)','Harddisk (8)','Externer Speicher (8)','Bemerkungen (8)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (9,'Betriebssystem (9)','CPU (9)','Anzahl Kerne (9)','Arbeitsspeicher (9)','Harddisk (9)','Externer Speicher (9)','Bemerkungen (9)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `comments`) VALUES (10,'Betriebssystem (10)','CPU (10)','Anzahl Kerne (10)','Arbeitsspeicher (10)','Harddisk (10)','Externer Speicher (10)','Bemerkungen (10)');

UNLOCK TABLES;

-- Table peripherieconfig

LOCK TABLES `peripherieconfig` WRITE;
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (1,'Bemerkungen (1)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (2,'Bemerkungen (2)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (3,'Bemerkungen (3)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (4,'Bemerkungen (4)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (5,'Bemerkungen (5)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (6,'Bemerkungen (6)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (7,'Bemerkungen (7)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (8,'Bemerkungen (8)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (9,'Bemerkungen (9)');
INSERT INTO `peripherieconfig` (`id`, `comments`) VALUES (10,'Bemerkungen (10)');

UNLOCK TABLES;

-- Table software

LOCK TABLES `software` WRITE;
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (1,'Name (1)','Version (1)','Lieferant (1)','Lizenzen (1)','2001-11-11','Bemerkungen (1)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (2,'Name (2)','Version (2)','Lieferant (2)','Lizenzen (2)','2003-03-04','Bemerkungen (2)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (3,'Name (3)','Version (3)','Lieferant (3)','Lizenzen (3)','2003-06-06','Bemerkungen (3)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (4,'Name (4)','Version (4)','Lieferant (4)','Lizenzen (4)','2010-09-01','Bemerkungen (4)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (5,'Name (5)','Version (5)','Lieferant (5)','Lizenzen (5)','2010-06-27','Bemerkungen (5)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (6,'Name (6)','Version (6)','Lieferant (6)','Lizenzen (6)','2001-08-19','Bemerkungen (6)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (7,'Name (7)','Version (7)','Lieferant (7)','Lizenzen (7)','2000-06-27','Bemerkungen (7)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (8,'Name (8)','Version (8)','Lieferant (8)','Lizenzen (8)','2011-08-01','Bemerkungen (8)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (9,'Name (9)','Version (9)','Lieferant (9)','Lizenzen (9)','2001-01-11','Bemerkungen (9)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (10,'Name (10)','Version (10)','Lieferant (10)','Lizenzen (10)','2004-01-12','Bemerkungen (10)');

UNLOCK TABLES;

-- Table internalcontacts

LOCK TABLES `internalcontacts` WRITE;
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (1,'Name (1)','Vorname (1)','Titel (1)','Organisationseinheit (1)','Telefon 1 (1)','Telefon 2 (1)','E-Mail (1)','Bemerkungen (1)','Andere Angaben 1 (1)','Andere Angaben 2 (1)','Andere Angaben 3 (1)','Andere Angaben 4 (1)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (2,'Name (2)','Vorname (2)','Titel (2)','Organisationseinheit (2)','Telefon 1 (2)','Telefon 2 (2)','E-Mail (2)','Bemerkungen (2)','Andere Angaben 1 (2)','Andere Angaben 2 (2)','Andere Angaben 3 (2)','Andere Angaben 4 (2)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (3,'Name (3)','Vorname (3)','Titel (3)','Organisationseinheit (3)','Telefon 1 (3)','Telefon 2 (3)','E-Mail (3)','Bemerkungen (3)','Andere Angaben 1 (3)','Andere Angaben 2 (3)','Andere Angaben 3 (3)','Andere Angaben 4 (3)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (4,'Name (4)','Vorname (4)','Titel (4)','Organisationseinheit (4)','Telefon 1 (4)','Telefon 2 (4)','E-Mail (4)','Bemerkungen (4)','Andere Angaben 1 (4)','Andere Angaben 2 (4)','Andere Angaben 3 (4)','Andere Angaben 4 (4)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (5,'Name (5)','Vorname (5)','Titel (5)','Organisationseinheit (5)','Telefon 1 (5)','Telefon 2 (5)','E-Mail (5)','Bemerkungen (5)','Andere Angaben 1 (5)','Andere Angaben 2 (5)','Andere Angaben 3 (5)','Andere Angaben 4 (5)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (6,'Name (6)','Vorname (6)','Titel (6)','Organisationseinheit (6)','Telefon 1 (6)','Telefon 2 (6)','E-Mail (6)','Bemerkungen (6)','Andere Angaben 1 (6)','Andere Angaben 2 (6)','Andere Angaben 3 (6)','Andere Angaben 4 (6)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (7,'Name (7)','Vorname (7)','Titel (7)','Organisationseinheit (7)','Telefon 1 (7)','Telefon 2 (7)','E-Mail (7)','Bemerkungen (7)','Andere Angaben 1 (7)','Andere Angaben 2 (7)','Andere Angaben 3 (7)','Andere Angaben 4 (7)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (8,'Name (8)','Vorname (8)','Titel (8)','Organisationseinheit (8)','Telefon 1 (8)','Telefon 2 (8)','E-Mail (8)','Bemerkungen (8)','Andere Angaben 1 (8)','Andere Angaben 2 (8)','Andere Angaben 3 (8)','Andere Angaben 4 (8)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (9,'Name (9)','Vorname (9)','Titel (9)','Organisationseinheit (9)','Telefon 1 (9)','Telefon 2 (9)','E-Mail (9)','Bemerkungen (9)','Andere Angaben 1 (9)','Andere Angaben 2 (9)','Andere Angaben 3 (9)','Andere Angaben 4 (9)');
INSERT INTO `internalcontacts` (`id`, `name`, `firstname`, `title`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (10,'Name (10)','Vorname (10)','Titel (10)','Organisationseinheit (10)','Telefon 1 (10)','Telefon 2 (10)','E-Mail (10)','Bemerkungen (10)','Andere Angaben 1 (10)','Andere Angaben 2 (10)','Andere Angaben 3 (10)','Andere Angaben 4 (10)');

UNLOCK TABLES;

-- Table externalcontacts

LOCK TABLES `externalcontacts` WRITE;
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (1,'Firma (1)','Kontakttyp (1)','Adresse (1)','Telefon 1 (1)','Telefon 2 (1)','Homepage (1)','Name (1)','Vorname (1)','Titel (1)','Organisationseinheit (1)','E-Mail (1)','Bemerkungen (1)','Andere Angaben 1 (1)','Andere Angaben 2 (1)','Andere Angaben 3 (1)','Andere Angaben 4 (1)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (2,'Firma (2)','Kontakttyp (2)','Adresse (2)','Telefon 1 (2)','Telefon 2 (2)','Homepage (2)','Name (2)','Vorname (2)','Titel (2)','Organisationseinheit (2)','E-Mail (2)','Bemerkungen (2)','Andere Angaben 1 (2)','Andere Angaben 2 (2)','Andere Angaben 3 (2)','Andere Angaben 4 (2)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (3,'Firma (3)','Kontakttyp (3)','Adresse (3)','Telefon 1 (3)','Telefon 2 (3)','Homepage (3)','Name (3)','Vorname (3)','Titel (3)','Organisationseinheit (3)','E-Mail (3)','Bemerkungen (3)','Andere Angaben 1 (3)','Andere Angaben 2 (3)','Andere Angaben 3 (3)','Andere Angaben 4 (3)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (4,'Firma (4)','Kontakttyp (4)','Adresse (4)','Telefon 1 (4)','Telefon 2 (4)','Homepage (4)','Name (4)','Vorname (4)','Titel (4)','Organisationseinheit (4)','E-Mail (4)','Bemerkungen (4)','Andere Angaben 1 (4)','Andere Angaben 2 (4)','Andere Angaben 3 (4)','Andere Angaben 4 (4)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (5,'Firma (5)','Kontakttyp (5)','Adresse (5)','Telefon 1 (5)','Telefon 2 (5)','Homepage (5)','Name (5)','Vorname (5)','Titel (5)','Organisationseinheit (5)','E-Mail (5)','Bemerkungen (5)','Andere Angaben 1 (5)','Andere Angaben 2 (5)','Andere Angaben 3 (5)','Andere Angaben 4 (5)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (6,'Firma (6)','Kontakttyp (6)','Adresse (6)','Telefon 1 (6)','Telefon 2 (6)','Homepage (6)','Name (6)','Vorname (6)','Titel (6)','Organisationseinheit (6)','E-Mail (6)','Bemerkungen (6)','Andere Angaben 1 (6)','Andere Angaben 2 (6)','Andere Angaben 3 (6)','Andere Angaben 4 (6)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (7,'Firma (7)','Kontakttyp (7)','Adresse (7)','Telefon 1 (7)','Telefon 2 (7)','Homepage (7)','Name (7)','Vorname (7)','Titel (7)','Organisationseinheit (7)','E-Mail (7)','Bemerkungen (7)','Andere Angaben 1 (7)','Andere Angaben 2 (7)','Andere Angaben 3 (7)','Andere Angaben 4 (7)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (8,'Firma (8)','Kontakttyp (8)','Adresse (8)','Telefon 1 (8)','Telefon 2 (8)','Homepage (8)','Name (8)','Vorname (8)','Titel (8)','Organisationseinheit (8)','E-Mail (8)','Bemerkungen (8)','Andere Angaben 1 (8)','Andere Angaben 2 (8)','Andere Angaben 3 (8)','Andere Angaben 4 (8)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (9,'Firma (9)','Kontakttyp (9)','Adresse (9)','Telefon 1 (9)','Telefon 2 (9)','Homepage (9)','Name (9)','Vorname (9)','Titel (9)','Organisationseinheit (9)','E-Mail (9)','Bemerkungen (9)','Andere Angaben 1 (9)','Andere Angaben 2 (9)','Andere Angaben 3 (9)','Andere Angaben 4 (9)');
INSERT INTO `externalcontacts` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `title`, `orgunit`, `email`, `comments`, `userfield1`, `userfield2`, `userfield3`, `userfield4`) VALUES (10,'Firma (10)','Kontakttyp (10)','Adresse (10)','Telefon 1 (10)','Telefon 2 (10)','Homepage (10)','Name (10)','Vorname (10)','Titel (10)','Organisationseinheit (10)','E-Mail (10)','Bemerkungen (10)','Andere Angaben 1 (10)','Andere Angaben 2 (10)','Andere Angaben 3 (10)','Andere Angaben 4 (10)');

UNLOCK TABLES;

-- Table ipaddress

LOCK TABLES `ipaddress` WRITE;
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (1,'Asset TAG (1)','Typ (1)','Marke (1)','Model (1)','Status (1)','Name (1)','Seriennummer 1 (1)','Seriennummer 2 (1)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (2,'Asset TAG (2)','Typ (2)','Marke (2)','Model (2)','Status (2)','Name (2)','Seriennummer 1 (2)','Seriennummer 2 (2)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (3,'Asset TAG (3)','Typ (3)','Marke (3)','Model (3)','Status (3)','Name (3)','Seriennummer 1 (3)','Seriennummer 2 (3)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (4,'Asset TAG (4)','Typ (4)','Marke (4)','Model (4)','Status (4)','Name (4)','Seriennummer 1 (4)','Seriennummer 2 (4)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (5,'Asset TAG (5)','Typ (5)','Marke (5)','Model (5)','Status (5)','Name (5)','Seriennummer 1 (5)','Seriennummer 2 (5)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (6,'Asset TAG (6)','Typ (6)','Marke (6)','Model (6)','Status (6)','Name (6)','Seriennummer 1 (6)','Seriennummer 2 (6)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (7,'Asset TAG (7)','Typ (7)','Marke (7)','Model (7)','Status (7)','Name (7)','Seriennummer 1 (7)','Seriennummer 2 (7)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (8,'Asset TAG (8)','Typ (8)','Marke (8)','Model (8)','Status (8)','Name (8)','Seriennummer 1 (8)','Seriennummer 2 (8)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (9,'Asset TAG (9)','Typ (9)','Marke (9)','Model (9)','Status (9)','Name (9)','Seriennummer 1 (9)','Seriennummer 2 (9)');
INSERT INTO `ipaddress` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (10,'Asset TAG (10)','Typ (10)','Marke (10)','Model (10)','Status (10)','Name (10)','Seriennummer 1 (10)','Seriennummer 2 (10)');

UNLOCK TABLES;

-- Table network

LOCK TABLES `network` WRITE;
INSERT INTO `network` (`id`, `name`) VALUES (1,'Name (1)');
INSERT INTO `network` (`id`, `name`) VALUES (2,'Name (2)');
INSERT INTO `network` (`id`, `name`) VALUES (3,'Name (3)');
INSERT INTO `network` (`id`, `name`) VALUES (4,'Name (4)');
INSERT INTO `network` (`id`, `name`) VALUES (5,'Name (5)');
INSERT INTO `network` (`id`, `name`) VALUES (6,'Name (6)');
INSERT INTO `network` (`id`, `name`) VALUES (7,'Name (7)');
INSERT INTO `network` (`id`, `name`) VALUES (8,'Name (8)');
INSERT INTO `network` (`id`, `name`) VALUES (9,'Name (9)');
INSERT INTO `network` (`id`, `name`) VALUES (10,'Name (10)');

UNLOCK TABLES;

-- Table domain

LOCK TABLES `domain` WRITE;
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (1,'Name (1)','Beschreibung (1)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (2,'Name (2)','Beschreibung (2)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (3,'Name (3)','Beschreibung (3)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (4,'Name (4)','Beschreibung (4)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (5,'Name (5)','Beschreibung (5)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (6,'Name (6)','Beschreibung (6)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (7,'Name (7)','Beschreibung (7)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (8,'Name (8)','Beschreibung (8)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (9,'Name (9)','Beschreibung (9)');
INSERT INTO `domain` (`id`, `name`, `comments`) VALUES (10,'Name (10)','Beschreibung (10)');

UNLOCK TABLES;

-- --------------------------------------------------------------------------------------
-- Relation Table Inserts (test data)
-- --------------------------------------------------------------------------------------

-- Relation Table computer_software

LOCK TABLES `computer_software` WRITE;
INSERT INTO `computer_software` VALUES (1,6,1);
INSERT INTO `computer_software` VALUES (2,6,2);
INSERT INTO `computer_software` VALUES (3,9,8);
INSERT INTO `computer_software` VALUES (4,9,9);
INSERT INTO `computer_software` VALUES (5,2,5);
INSERT INTO `computer_software` VALUES (6,3,3);
INSERT INTO `computer_software` VALUES (7,6,2);
INSERT INTO `computer_software` VALUES (8,8,2);
INSERT INTO `computer_software` VALUES (9,10,2);
INSERT INTO `computer_software` VALUES (10,10,6);
INSERT INTO `computer_software` VALUES (11,5,3);
INSERT INTO `computer_software` VALUES (12,6,1);
INSERT INTO `computer_software` VALUES (13,8,8);
INSERT INTO `computer_software` VALUES (14,4,8);
INSERT INTO `computer_software` VALUES (15,3,6);
INSERT INTO `computer_software` VALUES (16,1,2);
INSERT INTO `computer_software` VALUES (17,5,1);
INSERT INTO `computer_software` VALUES (18,3,6);
INSERT INTO `computer_software` VALUES (19,8,1);
INSERT INTO `computer_software` VALUES (20,9,4);
INSERT INTO `computer_software` VALUES (21,7,9);
INSERT INTO `computer_software` VALUES (22,4,8);
INSERT INTO `computer_software` VALUES (23,7,4);
INSERT INTO `computer_software` VALUES (24,8,3);
INSERT INTO `computer_software` VALUES (25,3,9);
INSERT INTO `computer_software` VALUES (26,5,2);
INSERT INTO `computer_software` VALUES (27,8,3);
INSERT INTO `computer_software` VALUES (28,6,8);
INSERT INTO `computer_software` VALUES (29,9,9);
INSERT INTO `computer_software` VALUES (30,4,4);

UNLOCK TABLES;

-- Relation Table computer_computerconfig

LOCK TABLES `computer_computerconfig` WRITE;
INSERT INTO `computer_computerconfig` VALUES (1,8,5);
INSERT INTO `computer_computerconfig` VALUES (2,10,6);
INSERT INTO `computer_computerconfig` VALUES (3,2,6);
INSERT INTO `computer_computerconfig` VALUES (4,8,3);
INSERT INTO `computer_computerconfig` VALUES (5,5,9);
INSERT INTO `computer_computerconfig` VALUES (6,7,3);
INSERT INTO `computer_computerconfig` VALUES (7,2,7);
INSERT INTO `computer_computerconfig` VALUES (8,4,6);
INSERT INTO `computer_computerconfig` VALUES (9,6,10);
INSERT INTO `computer_computerconfig` VALUES (10,6,9);
INSERT INTO `computer_computerconfig` VALUES (11,4,1);
INSERT INTO `computer_computerconfig` VALUES (12,10,1);
INSERT INTO `computer_computerconfig` VALUES (13,9,7);
INSERT INTO `computer_computerconfig` VALUES (14,4,9);
INSERT INTO `computer_computerconfig` VALUES (15,7,4);
INSERT INTO `computer_computerconfig` VALUES (16,3,4);
INSERT INTO `computer_computerconfig` VALUES (17,1,8);
INSERT INTO `computer_computerconfig` VALUES (18,7,3);
INSERT INTO `computer_computerconfig` VALUES (19,9,4);
INSERT INTO `computer_computerconfig` VALUES (20,1,4);
INSERT INTO `computer_computerconfig` VALUES (21,1,10);
INSERT INTO `computer_computerconfig` VALUES (22,5,6);
INSERT INTO `computer_computerconfig` VALUES (23,5,9);
INSERT INTO `computer_computerconfig` VALUES (24,2,8);
INSERT INTO `computer_computerconfig` VALUES (25,4,10);
INSERT INTO `computer_computerconfig` VALUES (26,3,7);
INSERT INTO `computer_computerconfig` VALUES (27,5,6);
INSERT INTO `computer_computerconfig` VALUES (28,3,4);
INSERT INTO `computer_computerconfig` VALUES (29,9,5);
INSERT INTO `computer_computerconfig` VALUES (30,1,4);

UNLOCK TABLES;

-- Relation Table peripherie_peripherieconfig

LOCK TABLES `peripherie_peripherieconfig` WRITE;
INSERT INTO `peripherie_peripherieconfig` VALUES (1,5,2);
INSERT INTO `peripherie_peripherieconfig` VALUES (2,1,8);
INSERT INTO `peripherie_peripherieconfig` VALUES (3,4,5);
INSERT INTO `peripherie_peripherieconfig` VALUES (4,4,3);
INSERT INTO `peripherie_peripherieconfig` VALUES (5,3,6);
INSERT INTO `peripherie_peripherieconfig` VALUES (6,4,9);
INSERT INTO `peripherie_peripherieconfig` VALUES (7,5,5);
INSERT INTO `peripherie_peripherieconfig` VALUES (8,1,3);
INSERT INTO `peripherie_peripherieconfig` VALUES (9,7,4);
INSERT INTO `peripherie_peripherieconfig` VALUES (10,10,4);
INSERT INTO `peripherie_peripherieconfig` VALUES (11,1,3);
INSERT INTO `peripherie_peripherieconfig` VALUES (12,9,10);
INSERT INTO `peripherie_peripherieconfig` VALUES (13,4,4);
INSERT INTO `peripherie_peripherieconfig` VALUES (14,5,1);
INSERT INTO `peripherie_peripherieconfig` VALUES (15,8,7);
INSERT INTO `peripherie_peripherieconfig` VALUES (16,6,3);
INSERT INTO `peripherie_peripherieconfig` VALUES (17,1,4);
INSERT INTO `peripherie_peripherieconfig` VALUES (18,8,6);
INSERT INTO `peripherie_peripherieconfig` VALUES (19,5,5);
INSERT INTO `peripherie_peripherieconfig` VALUES (20,9,8);
INSERT INTO `peripherie_peripherieconfig` VALUES (21,7,2);
INSERT INTO `peripherie_peripherieconfig` VALUES (22,5,8);
INSERT INTO `peripherie_peripherieconfig` VALUES (23,9,3);
INSERT INTO `peripherie_peripherieconfig` VALUES (24,6,3);
INSERT INTO `peripherie_peripherieconfig` VALUES (25,8,3);
INSERT INTO `peripherie_peripherieconfig` VALUES (26,6,4);
INSERT INTO `peripherie_peripherieconfig` VALUES (27,7,10);
INSERT INTO `peripherie_peripherieconfig` VALUES (28,4,6);
INSERT INTO `peripherie_peripherieconfig` VALUES (29,2,7);
INSERT INTO `peripherie_peripherieconfig` VALUES (30,6,1);

UNLOCK TABLES;

-- Relation Table computerconfig_network

LOCK TABLES `computerconfig_network` WRITE;
INSERT INTO `computerconfig_network` VALUES (1,6,3);
INSERT INTO `computerconfig_network` VALUES (2,10,5);
INSERT INTO `computerconfig_network` VALUES (3,7,10);
INSERT INTO `computerconfig_network` VALUES (4,3,8);
INSERT INTO `computerconfig_network` VALUES (5,5,9);
INSERT INTO `computerconfig_network` VALUES (6,3,6);
INSERT INTO `computerconfig_network` VALUES (7,9,1);
INSERT INTO `computerconfig_network` VALUES (8,5,1);
INSERT INTO `computerconfig_network` VALUES (9,1,6);
INSERT INTO `computerconfig_network` VALUES (10,10,7);
INSERT INTO `computerconfig_network` VALUES (11,7,6);
INSERT INTO `computerconfig_network` VALUES (12,10,7);
INSERT INTO `computerconfig_network` VALUES (13,1,1);
INSERT INTO `computerconfig_network` VALUES (14,7,7);
INSERT INTO `computerconfig_network` VALUES (15,9,3);
INSERT INTO `computerconfig_network` VALUES (16,5,6);
INSERT INTO `computerconfig_network` VALUES (17,3,2);
INSERT INTO `computerconfig_network` VALUES (18,3,1);
INSERT INTO `computerconfig_network` VALUES (19,10,10);
INSERT INTO `computerconfig_network` VALUES (20,7,3);
INSERT INTO `computerconfig_network` VALUES (21,4,6);
INSERT INTO `computerconfig_network` VALUES (22,6,8);
INSERT INTO `computerconfig_network` VALUES (23,10,4);
INSERT INTO `computerconfig_network` VALUES (24,4,7);
INSERT INTO `computerconfig_network` VALUES (25,2,2);
INSERT INTO `computerconfig_network` VALUES (26,2,5);
INSERT INTO `computerconfig_network` VALUES (27,6,3);
INSERT INTO `computerconfig_network` VALUES (28,4,5);
INSERT INTO `computerconfig_network` VALUES (29,4,5);
INSERT INTO `computerconfig_network` VALUES (30,9,10);

UNLOCK TABLES;

-- Relation Table computerconfig_domain

LOCK TABLES `computerconfig_domain` WRITE;
INSERT INTO `computerconfig_domain` VALUES (1,4,3);
INSERT INTO `computerconfig_domain` VALUES (2,3,4);
INSERT INTO `computerconfig_domain` VALUES (3,8,5);
INSERT INTO `computerconfig_domain` VALUES (4,5,1);
INSERT INTO `computerconfig_domain` VALUES (5,3,4);
INSERT INTO `computerconfig_domain` VALUES (6,10,2);
INSERT INTO `computerconfig_domain` VALUES (7,1,8);
INSERT INTO `computerconfig_domain` VALUES (8,7,4);
INSERT INTO `computerconfig_domain` VALUES (9,10,1);
INSERT INTO `computerconfig_domain` VALUES (10,2,7);
INSERT INTO `computerconfig_domain` VALUES (11,2,2);
INSERT INTO `computerconfig_domain` VALUES (12,3,7);
INSERT INTO `computerconfig_domain` VALUES (13,3,3);
INSERT INTO `computerconfig_domain` VALUES (14,6,5);
INSERT INTO `computerconfig_domain` VALUES (15,6,4);
INSERT INTO `computerconfig_domain` VALUES (16,10,8);
INSERT INTO `computerconfig_domain` VALUES (17,8,7);
INSERT INTO `computerconfig_domain` VALUES (18,10,6);
INSERT INTO `computerconfig_domain` VALUES (19,2,2);
INSERT INTO `computerconfig_domain` VALUES (20,6,4);
INSERT INTO `computerconfig_domain` VALUES (21,5,1);
INSERT INTO `computerconfig_domain` VALUES (22,2,5);
INSERT INTO `computerconfig_domain` VALUES (23,8,3);
INSERT INTO `computerconfig_domain` VALUES (24,8,3);
INSERT INTO `computerconfig_domain` VALUES (25,9,2);
INSERT INTO `computerconfig_domain` VALUES (26,8,10);
INSERT INTO `computerconfig_domain` VALUES (27,10,5);
INSERT INTO `computerconfig_domain` VALUES (28,3,2);
INSERT INTO `computerconfig_domain` VALUES (29,9,7);
INSERT INTO `computerconfig_domain` VALUES (30,7,10);

UNLOCK TABLES;

-- Relation Table computerconfig_ipaddress

LOCK TABLES `computerconfig_ipaddress` WRITE;
INSERT INTO `computerconfig_ipaddress` VALUES (1,7,6);
INSERT INTO `computerconfig_ipaddress` VALUES (2,10,9);
INSERT INTO `computerconfig_ipaddress` VALUES (3,1,5);
INSERT INTO `computerconfig_ipaddress` VALUES (4,6,1);
INSERT INTO `computerconfig_ipaddress` VALUES (5,5,2);
INSERT INTO `computerconfig_ipaddress` VALUES (6,5,2);
INSERT INTO `computerconfig_ipaddress` VALUES (7,5,2);
INSERT INTO `computerconfig_ipaddress` VALUES (8,2,1);
INSERT INTO `computerconfig_ipaddress` VALUES (9,3,2);
INSERT INTO `computerconfig_ipaddress` VALUES (10,7,6);
INSERT INTO `computerconfig_ipaddress` VALUES (11,6,6);
INSERT INTO `computerconfig_ipaddress` VALUES (12,3,8);
INSERT INTO `computerconfig_ipaddress` VALUES (13,7,3);
INSERT INTO `computerconfig_ipaddress` VALUES (14,2,2);
INSERT INTO `computerconfig_ipaddress` VALUES (15,3,5);
INSERT INTO `computerconfig_ipaddress` VALUES (16,7,8);
INSERT INTO `computerconfig_ipaddress` VALUES (17,6,2);
INSERT INTO `computerconfig_ipaddress` VALUES (18,8,4);
INSERT INTO `computerconfig_ipaddress` VALUES (19,3,6);
INSERT INTO `computerconfig_ipaddress` VALUES (20,10,1);
INSERT INTO `computerconfig_ipaddress` VALUES (21,7,6);
INSERT INTO `computerconfig_ipaddress` VALUES (22,3,3);
INSERT INTO `computerconfig_ipaddress` VALUES (23,4,6);
INSERT INTO `computerconfig_ipaddress` VALUES (24,1,2);
INSERT INTO `computerconfig_ipaddress` VALUES (25,6,5);
INSERT INTO `computerconfig_ipaddress` VALUES (26,4,3);
INSERT INTO `computerconfig_ipaddress` VALUES (27,2,4);
INSERT INTO `computerconfig_ipaddress` VALUES (28,7,9);
INSERT INTO `computerconfig_ipaddress` VALUES (29,3,4);
INSERT INTO `computerconfig_ipaddress` VALUES (30,9,4);

UNLOCK TABLES;

-- Relation Table network_peripherieconfig

LOCK TABLES `network_peripherieconfig` WRITE;
INSERT INTO `network_peripherieconfig` VALUES (1,6,6);
INSERT INTO `network_peripherieconfig` VALUES (2,5,1);
INSERT INTO `network_peripherieconfig` VALUES (3,4,1);
INSERT INTO `network_peripherieconfig` VALUES (4,5,3);
INSERT INTO `network_peripherieconfig` VALUES (5,3,1);
INSERT INTO `network_peripherieconfig` VALUES (6,3,4);
INSERT INTO `network_peripherieconfig` VALUES (7,7,4);
INSERT INTO `network_peripherieconfig` VALUES (8,10,7);
INSERT INTO `network_peripherieconfig` VALUES (9,1,5);
INSERT INTO `network_peripherieconfig` VALUES (10,9,6);
INSERT INTO `network_peripherieconfig` VALUES (11,9,1);
INSERT INTO `network_peripherieconfig` VALUES (12,1,4);
INSERT INTO `network_peripherieconfig` VALUES (13,7,6);
INSERT INTO `network_peripherieconfig` VALUES (14,10,4);
INSERT INTO `network_peripherieconfig` VALUES (15,8,9);
INSERT INTO `network_peripherieconfig` VALUES (16,5,1);
INSERT INTO `network_peripherieconfig` VALUES (17,8,2);
INSERT INTO `network_peripherieconfig` VALUES (18,3,6);
INSERT INTO `network_peripherieconfig` VALUES (19,1,4);
INSERT INTO `network_peripherieconfig` VALUES (20,1,6);
INSERT INTO `network_peripherieconfig` VALUES (21,3,10);
INSERT INTO `network_peripherieconfig` VALUES (22,5,10);
INSERT INTO `network_peripherieconfig` VALUES (23,6,6);
INSERT INTO `network_peripherieconfig` VALUES (24,5,6);
INSERT INTO `network_peripherieconfig` VALUES (25,8,7);
INSERT INTO `network_peripherieconfig` VALUES (26,6,3);
INSERT INTO `network_peripherieconfig` VALUES (27,10,1);
INSERT INTO `network_peripherieconfig` VALUES (28,6,9);
INSERT INTO `network_peripherieconfig` VALUES (29,1,2);
INSERT INTO `network_peripherieconfig` VALUES (30,1,3);

UNLOCK TABLES;

-- Relation Table domain_peripherieconfig

LOCK TABLES `domain_peripherieconfig` WRITE;
INSERT INTO `domain_peripherieconfig` VALUES (1,1,7);
INSERT INTO `domain_peripherieconfig` VALUES (2,10,2);
INSERT INTO `domain_peripherieconfig` VALUES (3,9,1);
INSERT INTO `domain_peripherieconfig` VALUES (4,9,6);
INSERT INTO `domain_peripherieconfig` VALUES (5,7,1);
INSERT INTO `domain_peripherieconfig` VALUES (6,6,2);
INSERT INTO `domain_peripherieconfig` VALUES (7,1,2);
INSERT INTO `domain_peripherieconfig` VALUES (8,6,1);
INSERT INTO `domain_peripherieconfig` VALUES (9,4,2);
INSERT INTO `domain_peripherieconfig` VALUES (10,10,8);
INSERT INTO `domain_peripherieconfig` VALUES (11,3,3);
INSERT INTO `domain_peripherieconfig` VALUES (12,1,5);
INSERT INTO `domain_peripherieconfig` VALUES (13,10,5);
INSERT INTO `domain_peripherieconfig` VALUES (14,10,7);
INSERT INTO `domain_peripherieconfig` VALUES (15,3,1);
INSERT INTO `domain_peripherieconfig` VALUES (16,1,5);
INSERT INTO `domain_peripherieconfig` VALUES (17,3,10);
INSERT INTO `domain_peripherieconfig` VALUES (18,4,6);
INSERT INTO `domain_peripherieconfig` VALUES (19,9,4);
INSERT INTO `domain_peripherieconfig` VALUES (20,3,9);
INSERT INTO `domain_peripherieconfig` VALUES (21,1,2);
INSERT INTO `domain_peripherieconfig` VALUES (22,9,2);
INSERT INTO `domain_peripherieconfig` VALUES (23,7,8);
INSERT INTO `domain_peripherieconfig` VALUES (24,6,5);
INSERT INTO `domain_peripherieconfig` VALUES (25,10,1);
INSERT INTO `domain_peripherieconfig` VALUES (26,3,4);
INSERT INTO `domain_peripherieconfig` VALUES (27,7,3);
INSERT INTO `domain_peripherieconfig` VALUES (28,5,10);
INSERT INTO `domain_peripherieconfig` VALUES (29,9,3);
INSERT INTO `domain_peripherieconfig` VALUES (30,3,9);

UNLOCK TABLES;

-- Relation Table ipaddress_peripherieconfig

LOCK TABLES `ipaddress_peripherieconfig` WRITE;
INSERT INTO `ipaddress_peripherieconfig` VALUES (1,4,4);
INSERT INTO `ipaddress_peripherieconfig` VALUES (2,10,1);
INSERT INTO `ipaddress_peripherieconfig` VALUES (3,4,6);
INSERT INTO `ipaddress_peripherieconfig` VALUES (4,6,4);
INSERT INTO `ipaddress_peripherieconfig` VALUES (5,7,10);
INSERT INTO `ipaddress_peripherieconfig` VALUES (6,7,7);
INSERT INTO `ipaddress_peripherieconfig` VALUES (7,4,7);
INSERT INTO `ipaddress_peripherieconfig` VALUES (8,1,6);
INSERT INTO `ipaddress_peripherieconfig` VALUES (9,3,9);
INSERT INTO `ipaddress_peripherieconfig` VALUES (10,4,3);
INSERT INTO `ipaddress_peripherieconfig` VALUES (11,6,4);
INSERT INTO `ipaddress_peripherieconfig` VALUES (12,5,4);
INSERT INTO `ipaddress_peripherieconfig` VALUES (13,9,6);
INSERT INTO `ipaddress_peripherieconfig` VALUES (14,8,9);
INSERT INTO `ipaddress_peripherieconfig` VALUES (15,6,4);
INSERT INTO `ipaddress_peripherieconfig` VALUES (16,4,5);
INSERT INTO `ipaddress_peripherieconfig` VALUES (17,4,1);
INSERT INTO `ipaddress_peripherieconfig` VALUES (18,7,1);
INSERT INTO `ipaddress_peripherieconfig` VALUES (19,4,6);
INSERT INTO `ipaddress_peripherieconfig` VALUES (20,7,5);
INSERT INTO `ipaddress_peripherieconfig` VALUES (21,4,1);
INSERT INTO `ipaddress_peripherieconfig` VALUES (22,9,8);
INSERT INTO `ipaddress_peripherieconfig` VALUES (23,6,5);
INSERT INTO `ipaddress_peripherieconfig` VALUES (24,2,4);
INSERT INTO `ipaddress_peripherieconfig` VALUES (25,7,2);
INSERT INTO `ipaddress_peripherieconfig` VALUES (26,1,5);
INSERT INTO `ipaddress_peripherieconfig` VALUES (27,10,1);
INSERT INTO `ipaddress_peripherieconfig` VALUES (28,5,8);
INSERT INTO `ipaddress_peripherieconfig` VALUES (29,1,4);
INSERT INTO `ipaddress_peripherieconfig` VALUES (30,10,2);

UNLOCK TABLES;

-- Relation Table ipaddress_software

LOCK TABLES `ipaddress_software` WRITE;
INSERT INTO `ipaddress_software` VALUES (1,10,8);
INSERT INTO `ipaddress_software` VALUES (2,8,8);
INSERT INTO `ipaddress_software` VALUES (3,3,7);
INSERT INTO `ipaddress_software` VALUES (4,10,6);
INSERT INTO `ipaddress_software` VALUES (5,9,2);
INSERT INTO `ipaddress_software` VALUES (6,10,7);
INSERT INTO `ipaddress_software` VALUES (7,6,10);
INSERT INTO `ipaddress_software` VALUES (8,4,3);
INSERT INTO `ipaddress_software` VALUES (9,10,1);
INSERT INTO `ipaddress_software` VALUES (10,6,3);
INSERT INTO `ipaddress_software` VALUES (11,10,10);
INSERT INTO `ipaddress_software` VALUES (12,2,1);
INSERT INTO `ipaddress_software` VALUES (13,1,10);
INSERT INTO `ipaddress_software` VALUES (14,4,5);
INSERT INTO `ipaddress_software` VALUES (15,2,6);
INSERT INTO `ipaddress_software` VALUES (16,10,9);
INSERT INTO `ipaddress_software` VALUES (17,9,9);
INSERT INTO `ipaddress_software` VALUES (18,1,1);
INSERT INTO `ipaddress_software` VALUES (19,1,4);
INSERT INTO `ipaddress_software` VALUES (20,6,4);
INSERT INTO `ipaddress_software` VALUES (21,3,4);
INSERT INTO `ipaddress_software` VALUES (22,6,8);
INSERT INTO `ipaddress_software` VALUES (23,3,3);
INSERT INTO `ipaddress_software` VALUES (24,7,4);
INSERT INTO `ipaddress_software` VALUES (25,8,3);
INSERT INTO `ipaddress_software` VALUES (26,4,3);
INSERT INTO `ipaddress_software` VALUES (27,7,9);
INSERT INTO `ipaddress_software` VALUES (28,2,6);
INSERT INTO `ipaddress_software` VALUES (29,4,3);
INSERT INTO `ipaddress_software` VALUES (30,4,3);

UNLOCK TABLES;

-- Relation Table ipaddress_network

LOCK TABLES `ipaddress_network` WRITE;
INSERT INTO `ipaddress_network` VALUES (1,9,1);
INSERT INTO `ipaddress_network` VALUES (2,7,8);
INSERT INTO `ipaddress_network` VALUES (3,7,3);
INSERT INTO `ipaddress_network` VALUES (4,4,8);
INSERT INTO `ipaddress_network` VALUES (5,8,5);
INSERT INTO `ipaddress_network` VALUES (6,1,6);
INSERT INTO `ipaddress_network` VALUES (7,5,9);
INSERT INTO `ipaddress_network` VALUES (8,10,3);
INSERT INTO `ipaddress_network` VALUES (9,10,10);
INSERT INTO `ipaddress_network` VALUES (10,10,10);
INSERT INTO `ipaddress_network` VALUES (11,6,9);
INSERT INTO `ipaddress_network` VALUES (12,1,6);
INSERT INTO `ipaddress_network` VALUES (13,3,2);
INSERT INTO `ipaddress_network` VALUES (14,1,5);
INSERT INTO `ipaddress_network` VALUES (15,6,10);
INSERT INTO `ipaddress_network` VALUES (16,3,5);
INSERT INTO `ipaddress_network` VALUES (17,5,9);
INSERT INTO `ipaddress_network` VALUES (18,4,10);
INSERT INTO `ipaddress_network` VALUES (19,4,10);
INSERT INTO `ipaddress_network` VALUES (20,5,8);
INSERT INTO `ipaddress_network` VALUES (21,3,9);
INSERT INTO `ipaddress_network` VALUES (22,4,2);
INSERT INTO `ipaddress_network` VALUES (23,6,7);
INSERT INTO `ipaddress_network` VALUES (24,4,1);
INSERT INTO `ipaddress_network` VALUES (25,5,10);
INSERT INTO `ipaddress_network` VALUES (26,10,9);
INSERT INTO `ipaddress_network` VALUES (27,2,8);
INSERT INTO `ipaddress_network` VALUES (28,6,3);
INSERT INTO `ipaddress_network` VALUES (29,7,8);
INSERT INTO `ipaddress_network` VALUES (30,9,7);

UNLOCK TABLES;

