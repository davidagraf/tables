-- --------------------------------------------------------------------------------------
-- Generated SQL script 'tables_fixture10.sql' for TABLES
-- JSON Resources 'resources.json'
-- Created on 2011-07-01T12:25:24+02:00
-- --------------------------------------------------------------------------------------

DROP SCHEMA IF EXISTS `tables`;
CREATE SCHEMA `tables`;
USE `tables`;

-- --------------------------------------------------------------------------------------
-- Tables
-- --------------------------------------------------------------------------------------

-- Table internalcontact

DROP TABLE IF EXISTS `internalcontact`;

CREATE TABLE `internalcontact` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) NOT NULL,
  `firstname` varchar(140) DEFAULT NULL,
  `salutation` varchar(140) DEFAULT NULL,
  `orgunit` varchar(140) DEFAULT NULL,
  `phone1` varchar(140) DEFAULT NULL,
  `phone2` varchar(140) DEFAULT NULL,
  `email` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  `user1` varchar(1200) DEFAULT NULL,
  `user2` varchar(1200) DEFAULT NULL,
  `user3` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table externalcontact

DROP TABLE IF EXISTS `externalcontact`;

CREATE TABLE `externalcontact` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `company` varchar(140) NOT NULL,
  `type` varchar(140) NOT NULL,
  `address` varchar(140) DEFAULT NULL,
  `phone1` varchar(140) DEFAULT NULL,
  `phone2` varchar(140) DEFAULT NULL,
  `www` varchar(140) DEFAULT NULL,
  `name` varchar(140) DEFAULT NULL,
  `firstname` varchar(140) DEFAULT NULL,
  `salutation` varchar(140) DEFAULT NULL,
  `orgunit` varchar(140) DEFAULT NULL,
  `email` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  `user1` varchar(1200) DEFAULT NULL,
  `user2` varchar(1200) DEFAULT NULL,
  `user3` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


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


-- Table peripheral

DROP TABLE IF EXISTS `peripheral`;

CREATE TABLE `peripheral` (
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
  `infourl` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table peripheralconfig

DROP TABLE IF EXISTS `peripheralconfig`;

CREATE TABLE `peripheralconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `infourl` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table software

DROP TABLE IF EXISTS `software`;

CREATE TABLE `software` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) NOT NULL,
  `version` varchar(140) DEFAULT NULL,
  `distributor` varchar(140) DEFAULT NULL,
  `license` varchar(140) DEFAULT NULL,
  `expiration` date DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table ipaddress

DROP TABLE IF EXISTS `ipaddress`;

CREATE TABLE `ipaddress` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(140) NOT NULL,
  `type` varchar(140) DEFAULT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table network

DROP TABLE IF EXISTS `network`;

CREATE TABLE `network` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) NOT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  `user1` varchar(1200) DEFAULT NULL,
  `user2` varchar(1200) DEFAULT NULL,
  `user3` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Table domain

DROP TABLE IF EXISTS `domain`;

CREATE TABLE `domain` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(140) NOT NULL,
  `comments` varchar(1200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------------------------------------
-- Relation Tables
-- --------------------------------------------------------------------------------------

-- Relation Table computer_externalcontact

DROP TABLE IF EXISTS `computer_externalcontact`;

CREATE TABLE `computer_externalcontact` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computer` int(11) unsigned NOT NULL,
  `externalcontact` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computer` (`computer`),
  KEY `externalcontact` (`externalcontact`),
  CONSTRAINT `computer_externalcontact_ibfk_2` FOREIGN KEY (`computer`) REFERENCES `computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computer_externalcontact_ibfk_3` FOREIGN KEY (`externalcontact`) REFERENCES `externalcontact` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table externalcontact_peripheral

DROP TABLE IF EXISTS `externalcontact_peripheral`;

CREATE TABLE `externalcontact_peripheral` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `externalcontact` int(11) unsigned NOT NULL,
  `peripheral` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `externalcontact` (`externalcontact`),
  KEY `peripheral` (`peripheral`),
  CONSTRAINT `externalcontact_peripheral_ibfk_2` FOREIGN KEY (`externalcontact`) REFERENCES `externalcontact` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `externalcontact_peripheral_ibfk_3` FOREIGN KEY (`peripheral`) REFERENCES `peripheral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


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


-- Relation Table computer_network

DROP TABLE IF EXISTS `computer_network`;

CREATE TABLE `computer_network` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computer` int(11) unsigned NOT NULL,
  `network` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computer` (`computer`),
  KEY `network` (`network`),
  CONSTRAINT `computer_network_ibfk_2` FOREIGN KEY (`computer`) REFERENCES `computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computer_network_ibfk_3` FOREIGN KEY (`network`) REFERENCES `network` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table computer_domain

DROP TABLE IF EXISTS `computer_domain`;

CREATE TABLE `computer_domain` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computer` int(11) unsigned NOT NULL,
  `domain` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computer` (`computer`),
  KEY `domain` (`domain`),
  CONSTRAINT `computer_domain_ibfk_2` FOREIGN KEY (`computer`) REFERENCES `computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computer_domain_ibfk_3` FOREIGN KEY (`domain`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table computer_ipaddress

DROP TABLE IF EXISTS `computer_ipaddress`;

CREATE TABLE `computer_ipaddress` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `computer` int(11) unsigned NOT NULL,
  `ipaddress` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `computer` (`computer`),
  KEY `ipaddress` (`ipaddress`),
  CONSTRAINT `computer_ipaddress_ibfk_2` FOREIGN KEY (`computer`) REFERENCES `computer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `computer_ipaddress_ibfk_3` FOREIGN KEY (`ipaddress`) REFERENCES `ipaddress` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table peripheral_peripheralconfig

DROP TABLE IF EXISTS `peripheral_peripheralconfig`;

CREATE TABLE `peripheral_peripheralconfig` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `peripheral` int(11) unsigned NOT NULL,
  `peripheralconfig` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `peripheral` (`peripheral`),
  KEY `peripheralconfig` (`peripheralconfig`),
  CONSTRAINT `peripheral_peripheralconfig_ibfk_2` FOREIGN KEY (`peripheral`) REFERENCES `peripheral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `peripheral_peripheralconfig_ibfk_3` FOREIGN KEY (`peripheralconfig`) REFERENCES `peripheralconfig` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table network_peripheral

DROP TABLE IF EXISTS `network_peripheral`;

CREATE TABLE `network_peripheral` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `network` int(11) unsigned NOT NULL,
  `peripheral` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `network` (`network`),
  KEY `peripheral` (`peripheral`),
  CONSTRAINT `network_peripheral_ibfk_2` FOREIGN KEY (`network`) REFERENCES `network` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `network_peripheral_ibfk_3` FOREIGN KEY (`peripheral`) REFERENCES `peripheral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table domain_peripheral

DROP TABLE IF EXISTS `domain_peripheral`;

CREATE TABLE `domain_peripheral` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain` int(11) unsigned NOT NULL,
  `peripheral` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`),
  KEY `peripheral` (`peripheral`),
  CONSTRAINT `domain_peripheral_ibfk_2` FOREIGN KEY (`domain`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `domain_peripheral_ibfk_3` FOREIGN KEY (`peripheral`) REFERENCES `peripheral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Relation Table ipaddress_peripheral

DROP TABLE IF EXISTS `ipaddress_peripheral`;

CREATE TABLE `ipaddress_peripheral` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ipaddress` int(11) unsigned NOT NULL,
  `peripheral` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ipaddress` (`ipaddress`),
  KEY `peripheral` (`peripheral`),
  CONSTRAINT `ipaddress_peripheral_ibfk_2` FOREIGN KEY (`ipaddress`) REFERENCES `ipaddress` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipaddress_peripheral_ibfk_3` FOREIGN KEY (`peripheral`) REFERENCES `peripheral` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
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


-- Relation Table domain_network

DROP TABLE IF EXISTS `domain_network`;

CREATE TABLE `domain_network` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `domain` int(11) unsigned NOT NULL,
  `network` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `domain` (`domain`),
  KEY `network` (`network`),
  CONSTRAINT `domain_network_ibfk_2` FOREIGN KEY (`domain`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `domain_network_ibfk_3` FOREIGN KEY (`network`) REFERENCES `network` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------------------------------------
-- Table Inserts (test data)
-- --------------------------------------------------------------------------------------

-- Table internalcontact

LOCK TABLES `internalcontact` WRITE;

INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (1,'Name (1)','Vorname (1)','Anrede (1)','Organisationseinheit (1)','Telefon 1 (1)','Telefon 2 (1)','hansmuster1@gmail.com','Bemerkungen (1)','Andere 1 (1)','Andere 2 (1)','Andere 3 (1)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (2,'Name (2)','Vorname (2)','Anrede (2)','Organisationseinheit (2)','Telefon 1 (2)','Telefon 2 (2)','hansmuster2@gmail.com','Bemerkungen (2)','Andere 1 (2)','Andere 2 (2)','Andere 3 (2)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (3,'Name (3)','Vorname (3)','Anrede (3)','Organisationseinheit (3)','Telefon 1 (3)','Telefon 2 (3)','hansmuster3@gmail.com','Bemerkungen (3)','Andere 1 (3)','Andere 2 (3)','Andere 3 (3)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (4,'Name (4)','Vorname (4)','Anrede (4)','Organisationseinheit (4)','Telefon 1 (4)','Telefon 2 (4)','hansmuster4@gmail.com','Bemerkungen (4)','Andere 1 (4)','Andere 2 (4)','Andere 3 (4)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (5,'Name (5)','Vorname (5)','Anrede (5)','Organisationseinheit (5)','Telefon 1 (5)','Telefon 2 (5)','hansmuster5@gmail.com','Bemerkungen (5)','Andere 1 (5)','Andere 2 (5)','Andere 3 (5)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (6,'Name (6)','Vorname (6)','Anrede (6)','Organisationseinheit (6)','Telefon 1 (6)','Telefon 2 (6)','hansmuster6@gmail.com','Bemerkungen (6)','Andere 1 (6)','Andere 2 (6)','Andere 3 (6)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (7,'Name (7)','Vorname (7)','Anrede (7)','Organisationseinheit (7)','Telefon 1 (7)','Telefon 2 (7)','hansmuster7@gmail.com','Bemerkungen (7)','Andere 1 (7)','Andere 2 (7)','Andere 3 (7)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (8,'Name (8)','Vorname (8)','Anrede (8)','Organisationseinheit (8)','Telefon 1 (8)','Telefon 2 (8)','hansmuster8@gmail.com','Bemerkungen (8)','Andere 1 (8)','Andere 2 (8)','Andere 3 (8)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (9,'Name (9)','Vorname (9)','Anrede (9)','Organisationseinheit (9)','Telefon 1 (9)','Telefon 2 (9)','hansmuster9@gmail.com','Bemerkungen (9)','Andere 1 (9)','Andere 2 (9)','Andere 3 (9)');
INSERT INTO `internalcontact` (`id`, `name`, `firstname`, `salutation`, `orgunit`, `phone1`, `phone2`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (10,'Name (10)','Vorname (10)','Anrede (10)','Organisationseinheit (10)','Telefon 1 (10)','Telefon 2 (10)','hansmuster10@gmail.com','Bemerkungen (10)','Andere 1 (10)','Andere 2 (10)','Andere 3 (10)');

UNLOCK TABLES;

-- Table externalcontact

LOCK TABLES `externalcontact` WRITE;

INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (1,'Firma (1)','Kontakttyp (1)','Adresse (1)','Telefon 1 (1)','Telefon 2 (1)','www.google.com','Name (1)','Vorname (1)','Anrede (1)','Organisationseinheit (1)','hansmuster1@gmail.com','Bemerkungen (1)','Andere 1 (1)','Andere 2 (1)','Andere 3 (1)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (2,'Firma (2)','Kontakttyp (2)','Adresse (2)','Telefon 1 (2)','Telefon 2 (2)','www.google.com','Name (2)','Vorname (2)','Anrede (2)','Organisationseinheit (2)','hansmuster2@gmail.com','Bemerkungen (2)','Andere 1 (2)','Andere 2 (2)','Andere 3 (2)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (3,'Firma (3)','Kontakttyp (3)','Adresse (3)','Telefon 1 (3)','Telefon 2 (3)','www.google.com','Name (3)','Vorname (3)','Anrede (3)','Organisationseinheit (3)','hansmuster3@gmail.com','Bemerkungen (3)','Andere 1 (3)','Andere 2 (3)','Andere 3 (3)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (4,'Firma (4)','Kontakttyp (4)','Adresse (4)','Telefon 1 (4)','Telefon 2 (4)','www.google.com','Name (4)','Vorname (4)','Anrede (4)','Organisationseinheit (4)','hansmuster4@gmail.com','Bemerkungen (4)','Andere 1 (4)','Andere 2 (4)','Andere 3 (4)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (5,'Firma (5)','Kontakttyp (5)','Adresse (5)','Telefon 1 (5)','Telefon 2 (5)','www.google.com','Name (5)','Vorname (5)','Anrede (5)','Organisationseinheit (5)','hansmuster5@gmail.com','Bemerkungen (5)','Andere 1 (5)','Andere 2 (5)','Andere 3 (5)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (6,'Firma (6)','Kontakttyp (6)','Adresse (6)','Telefon 1 (6)','Telefon 2 (6)','www.google.com','Name (6)','Vorname (6)','Anrede (6)','Organisationseinheit (6)','hansmuster6@gmail.com','Bemerkungen (6)','Andere 1 (6)','Andere 2 (6)','Andere 3 (6)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (7,'Firma (7)','Kontakttyp (7)','Adresse (7)','Telefon 1 (7)','Telefon 2 (7)','www.google.com','Name (7)','Vorname (7)','Anrede (7)','Organisationseinheit (7)','hansmuster7@gmail.com','Bemerkungen (7)','Andere 1 (7)','Andere 2 (7)','Andere 3 (7)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (8,'Firma (8)','Kontakttyp (8)','Adresse (8)','Telefon 1 (8)','Telefon 2 (8)','www.google.com','Name (8)','Vorname (8)','Anrede (8)','Organisationseinheit (8)','hansmuster8@gmail.com','Bemerkungen (8)','Andere 1 (8)','Andere 2 (8)','Andere 3 (8)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (9,'Firma (9)','Kontakttyp (9)','Adresse (9)','Telefon 1 (9)','Telefon 2 (9)','www.google.com','Name (9)','Vorname (9)','Anrede (9)','Organisationseinheit (9)','hansmuster9@gmail.com','Bemerkungen (9)','Andere 1 (9)','Andere 2 (9)','Andere 3 (9)');
INSERT INTO `externalcontact` (`id`, `company`, `type`, `address`, `phone1`, `phone2`, `www`, `name`, `firstname`, `salutation`, `orgunit`, `email`, `comments`, `user1`, `user2`, `user3`) VALUES (10,'Firma (10)','Kontakttyp (10)','Adresse (10)','Telefon 1 (10)','Telefon 2 (10)','www.google.com','Name (10)','Vorname (10)','Anrede (10)','Organisationseinheit (10)','hansmuster10@gmail.com','Bemerkungen (10)','Andere 1 (10)','Andere 2 (10)','Andere 3 (10)');

UNLOCK TABLES;

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

-- Table peripheral

LOCK TABLES `peripheral` WRITE;

INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (1,'Asset TAG (1)','Typ (1)','Marke (1)','Model (1)','Status (1)','Name (1)','Seriennummer 1 (1)','Seriennummer 2 (1)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (2,'Asset TAG (2)','Typ (2)','Marke (2)','Model (2)','Status (2)','Name (2)','Seriennummer 1 (2)','Seriennummer 2 (2)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (3,'Asset TAG (3)','Typ (3)','Marke (3)','Model (3)','Status (3)','Name (3)','Seriennummer 1 (3)','Seriennummer 2 (3)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (4,'Asset TAG (4)','Typ (4)','Marke (4)','Model (4)','Status (4)','Name (4)','Seriennummer 1 (4)','Seriennummer 2 (4)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (5,'Asset TAG (5)','Typ (5)','Marke (5)','Model (5)','Status (5)','Name (5)','Seriennummer 1 (5)','Seriennummer 2 (5)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (6,'Asset TAG (6)','Typ (6)','Marke (6)','Model (6)','Status (6)','Name (6)','Seriennummer 1 (6)','Seriennummer 2 (6)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (7,'Asset TAG (7)','Typ (7)','Marke (7)','Model (7)','Status (7)','Name (7)','Seriennummer 1 (7)','Seriennummer 2 (7)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (8,'Asset TAG (8)','Typ (8)','Marke (8)','Model (8)','Status (8)','Name (8)','Seriennummer 1 (8)','Seriennummer 2 (8)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (9,'Asset TAG (9)','Typ (9)','Marke (9)','Model (9)','Status (9)','Name (9)','Seriennummer 1 (9)','Seriennummer 2 (9)');
INSERT INTO `peripheral` (`id`, `asset_tag`, `type`, `brand`, `model`, `status`, `name`, `serial1`, `serial2`) VALUES (10,'Asset TAG (10)','Typ (10)','Marke (10)','Model (10)','Status (10)','Name (10)','Seriennummer 1 (10)','Seriennummer 2 (10)');

UNLOCK TABLES;

-- Table computerconfig

LOCK TABLES `computerconfig` WRITE;

INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (1,'Betriebssystem (1)','CPU (1)','Anzahl Kerne (1)','Arbeitsspeicher (1)','Harddisk (1)','Externer Speicher (1)','www.google.com','Bemerkungen (1)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (2,'Betriebssystem (2)','CPU (2)','Anzahl Kerne (2)','Arbeitsspeicher (2)','Harddisk (2)','Externer Speicher (2)','www.google.com','Bemerkungen (2)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (3,'Betriebssystem (3)','CPU (3)','Anzahl Kerne (3)','Arbeitsspeicher (3)','Harddisk (3)','Externer Speicher (3)','www.google.com','Bemerkungen (3)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (4,'Betriebssystem (4)','CPU (4)','Anzahl Kerne (4)','Arbeitsspeicher (4)','Harddisk (4)','Externer Speicher (4)','www.google.com','Bemerkungen (4)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (5,'Betriebssystem (5)','CPU (5)','Anzahl Kerne (5)','Arbeitsspeicher (5)','Harddisk (5)','Externer Speicher (5)','www.google.com','Bemerkungen (5)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (6,'Betriebssystem (6)','CPU (6)','Anzahl Kerne (6)','Arbeitsspeicher (6)','Harddisk (6)','Externer Speicher (6)','www.google.com','Bemerkungen (6)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (7,'Betriebssystem (7)','CPU (7)','Anzahl Kerne (7)','Arbeitsspeicher (7)','Harddisk (7)','Externer Speicher (7)','www.google.com','Bemerkungen (7)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (8,'Betriebssystem (8)','CPU (8)','Anzahl Kerne (8)','Arbeitsspeicher (8)','Harddisk (8)','Externer Speicher (8)','www.google.com','Bemerkungen (8)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (9,'Betriebssystem (9)','CPU (9)','Anzahl Kerne (9)','Arbeitsspeicher (9)','Harddisk (9)','Externer Speicher (9)','www.google.com','Bemerkungen (9)');
INSERT INTO `computerconfig` (`id`, `os`, `cpu`, `nrcpus`, `memory`, `hdd`, `extstor`, `infourl`, `comments`) VALUES (10,'Betriebssystem (10)','CPU (10)','Anzahl Kerne (10)','Arbeitsspeicher (10)','Harddisk (10)','Externer Speicher (10)','www.google.com','Bemerkungen (10)');

UNLOCK TABLES;

-- Table peripheralconfig

LOCK TABLES `peripheralconfig` WRITE;

INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (1,'www.google.com','Bemerkungen (1)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (2,'www.google.com','Bemerkungen (2)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (3,'www.google.com','Bemerkungen (3)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (4,'www.google.com','Bemerkungen (4)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (5,'www.google.com','Bemerkungen (5)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (6,'www.google.com','Bemerkungen (6)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (7,'www.google.com','Bemerkungen (7)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (8,'www.google.com','Bemerkungen (8)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (9,'www.google.com','Bemerkungen (9)');
INSERT INTO `peripheralconfig` (`id`, `infourl`, `comments`) VALUES (10,'www.google.com','Bemerkungen (10)');

UNLOCK TABLES;

-- Table software

LOCK TABLES `software` WRITE;

INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (1,'Name (1)','Version (1)','Lieferant (1)','Lizenzen (1)','2004-04-23','Bemerkungen (1)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (2,'Name (2)','Version (2)','Lieferant (2)','Lizenzen (2)','2010-10-24','Bemerkungen (2)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (3,'Name (3)','Version (3)','Lieferant (3)','Lizenzen (3)','2001-08-05','Bemerkungen (3)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (4,'Name (4)','Version (4)','Lieferant (4)','Lizenzen (4)','2001-01-23','Bemerkungen (4)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (5,'Name (5)','Version (5)','Lieferant (5)','Lizenzen (5)','2011-09-17','Bemerkungen (5)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (6,'Name (6)','Version (6)','Lieferant (6)','Lizenzen (6)','2009-12-12','Bemerkungen (6)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (7,'Name (7)','Version (7)','Lieferant (7)','Lizenzen (7)','2003-03-17','Bemerkungen (7)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (8,'Name (8)','Version (8)','Lieferant (8)','Lizenzen (8)','2009-05-12','Bemerkungen (8)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (9,'Name (9)','Version (9)','Lieferant (9)','Lizenzen (9)','2007-10-10','Bemerkungen (9)');
INSERT INTO `software` (`id`, `name`, `version`, `distributor`, `license`, `expiration`, `comments`) VALUES (10,'Name (10)','Version (10)','Lieferant (10)','Lizenzen (10)','2011-06-26','Bemerkungen (10)');

UNLOCK TABLES;

-- Table ipaddress

LOCK TABLES `ipaddress` WRITE;

INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (1,'Adresse (1)','Typ (1)','Bemerkungen (1)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (2,'Adresse (2)','Typ (2)','Bemerkungen (2)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (3,'Adresse (3)','Typ (3)','Bemerkungen (3)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (4,'Adresse (4)','Typ (4)','Bemerkungen (4)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (5,'Adresse (5)','Typ (5)','Bemerkungen (5)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (6,'Adresse (6)','Typ (6)','Bemerkungen (6)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (7,'Adresse (7)','Typ (7)','Bemerkungen (7)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (8,'Adresse (8)','Typ (8)','Bemerkungen (8)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (9,'Adresse (9)','Typ (9)','Bemerkungen (9)');
INSERT INTO `ipaddress` (`id`, `address`, `type`, `comments`) VALUES (10,'Adresse (10)','Typ (10)','Bemerkungen (10)');

UNLOCK TABLES;

-- Table network

LOCK TABLES `network` WRITE;

INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (1,'Name (1)','Beschreibung (1)','Andere 1 (1)','Andere 2 (1)','Andere 3 (1)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (2,'Name (2)','Beschreibung (2)','Andere 1 (2)','Andere 2 (2)','Andere 3 (2)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (3,'Name (3)','Beschreibung (3)','Andere 1 (3)','Andere 2 (3)','Andere 3 (3)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (4,'Name (4)','Beschreibung (4)','Andere 1 (4)','Andere 2 (4)','Andere 3 (4)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (5,'Name (5)','Beschreibung (5)','Andere 1 (5)','Andere 2 (5)','Andere 3 (5)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (6,'Name (6)','Beschreibung (6)','Andere 1 (6)','Andere 2 (6)','Andere 3 (6)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (7,'Name (7)','Beschreibung (7)','Andere 1 (7)','Andere 2 (7)','Andere 3 (7)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (8,'Name (8)','Beschreibung (8)','Andere 1 (8)','Andere 2 (8)','Andere 3 (8)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (9,'Name (9)','Beschreibung (9)','Andere 1 (9)','Andere 2 (9)','Andere 3 (9)');
INSERT INTO `network` (`id`, `name`, `comments`, `user1`, `user2`, `user3`) VALUES (10,'Name (10)','Beschreibung (10)','Andere 1 (10)','Andere 2 (10)','Andere 3 (10)');

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

-- Relation Table computer_externalcontact

LOCK TABLES `computer_externalcontact` WRITE;

INSERT INTO `computer_externalcontact` VALUES (1,5,9);
INSERT INTO `computer_externalcontact` VALUES (2,7,5);
INSERT INTO `computer_externalcontact` VALUES (3,3,10);
INSERT INTO `computer_externalcontact` VALUES (4,9,6);
INSERT INTO `computer_externalcontact` VALUES (5,9,1);
INSERT INTO `computer_externalcontact` VALUES (6,6,5);
INSERT INTO `computer_externalcontact` VALUES (7,2,1);
INSERT INTO `computer_externalcontact` VALUES (8,4,2);
INSERT INTO `computer_externalcontact` VALUES (9,6,4);
INSERT INTO `computer_externalcontact` VALUES (10,6,8);
INSERT INTO `computer_externalcontact` VALUES (11,7,10);
INSERT INTO `computer_externalcontact` VALUES (12,5,9);
INSERT INTO `computer_externalcontact` VALUES (13,1,4);
INSERT INTO `computer_externalcontact` VALUES (14,4,9);
INSERT INTO `computer_externalcontact` VALUES (15,6,5);
INSERT INTO `computer_externalcontact` VALUES (16,9,4);
INSERT INTO `computer_externalcontact` VALUES (17,4,9);
INSERT INTO `computer_externalcontact` VALUES (18,10,7);
INSERT INTO `computer_externalcontact` VALUES (19,5,4);
INSERT INTO `computer_externalcontact` VALUES (20,3,5);
INSERT INTO `computer_externalcontact` VALUES (21,2,6);
INSERT INTO `computer_externalcontact` VALUES (22,9,10);
INSERT INTO `computer_externalcontact` VALUES (23,3,4);
INSERT INTO `computer_externalcontact` VALUES (24,4,9);
INSERT INTO `computer_externalcontact` VALUES (25,2,3);
INSERT INTO `computer_externalcontact` VALUES (26,10,4);
INSERT INTO `computer_externalcontact` VALUES (27,7,3);
INSERT INTO `computer_externalcontact` VALUES (28,1,3);
INSERT INTO `computer_externalcontact` VALUES (29,1,8);
INSERT INTO `computer_externalcontact` VALUES (30,10,8);

UNLOCK TABLES;

-- Relation Table externalcontact_peripheral

LOCK TABLES `externalcontact_peripheral` WRITE;

INSERT INTO `externalcontact_peripheral` VALUES (1,4,8);
INSERT INTO `externalcontact_peripheral` VALUES (2,1,5);
INSERT INTO `externalcontact_peripheral` VALUES (3,8,7);
INSERT INTO `externalcontact_peripheral` VALUES (4,6,8);
INSERT INTO `externalcontact_peripheral` VALUES (5,1,6);
INSERT INTO `externalcontact_peripheral` VALUES (6,1,3);
INSERT INTO `externalcontact_peripheral` VALUES (7,9,9);
INSERT INTO `externalcontact_peripheral` VALUES (8,6,3);
INSERT INTO `externalcontact_peripheral` VALUES (9,8,6);
INSERT INTO `externalcontact_peripheral` VALUES (10,8,4);
INSERT INTO `externalcontact_peripheral` VALUES (11,2,1);
INSERT INTO `externalcontact_peripheral` VALUES (12,8,9);
INSERT INTO `externalcontact_peripheral` VALUES (13,10,5);
INSERT INTO `externalcontact_peripheral` VALUES (14,1,6);
INSERT INTO `externalcontact_peripheral` VALUES (15,5,1);
INSERT INTO `externalcontact_peripheral` VALUES (16,9,5);
INSERT INTO `externalcontact_peripheral` VALUES (17,5,9);
INSERT INTO `externalcontact_peripheral` VALUES (18,7,5);
INSERT INTO `externalcontact_peripheral` VALUES (19,4,5);
INSERT INTO `externalcontact_peripheral` VALUES (20,6,8);
INSERT INTO `externalcontact_peripheral` VALUES (21,1,8);
INSERT INTO `externalcontact_peripheral` VALUES (22,2,10);
INSERT INTO `externalcontact_peripheral` VALUES (23,9,2);
INSERT INTO `externalcontact_peripheral` VALUES (24,7,5);
INSERT INTO `externalcontact_peripheral` VALUES (25,6,7);
INSERT INTO `externalcontact_peripheral` VALUES (26,6,8);
INSERT INTO `externalcontact_peripheral` VALUES (27,6,8);
INSERT INTO `externalcontact_peripheral` VALUES (28,10,3);
INSERT INTO `externalcontact_peripheral` VALUES (29,6,5);
INSERT INTO `externalcontact_peripheral` VALUES (30,5,7);

UNLOCK TABLES;

-- Relation Table computer_software

LOCK TABLES `computer_software` WRITE;

INSERT INTO `computer_software` VALUES (1,2,2);
INSERT INTO `computer_software` VALUES (2,1,1);
INSERT INTO `computer_software` VALUES (3,10,10);
INSERT INTO `computer_software` VALUES (4,6,4);
INSERT INTO `computer_software` VALUES (5,5,1);
INSERT INTO `computer_software` VALUES (6,10,6);
INSERT INTO `computer_software` VALUES (7,5,8);
INSERT INTO `computer_software` VALUES (8,8,6);
INSERT INTO `computer_software` VALUES (9,3,3);
INSERT INTO `computer_software` VALUES (10,2,5);
INSERT INTO `computer_software` VALUES (11,8,7);
INSERT INTO `computer_software` VALUES (12,7,1);
INSERT INTO `computer_software` VALUES (13,3,4);
INSERT INTO `computer_software` VALUES (14,5,6);
INSERT INTO `computer_software` VALUES (15,7,5);
INSERT INTO `computer_software` VALUES (16,2,7);
INSERT INTO `computer_software` VALUES (17,3,3);
INSERT INTO `computer_software` VALUES (18,8,6);
INSERT INTO `computer_software` VALUES (19,9,9);
INSERT INTO `computer_software` VALUES (20,9,1);
INSERT INTO `computer_software` VALUES (21,10,6);
INSERT INTO `computer_software` VALUES (22,7,3);
INSERT INTO `computer_software` VALUES (23,2,6);
INSERT INTO `computer_software` VALUES (24,7,1);
INSERT INTO `computer_software` VALUES (25,1,2);
INSERT INTO `computer_software` VALUES (26,10,5);
INSERT INTO `computer_software` VALUES (27,4,5);
INSERT INTO `computer_software` VALUES (28,2,3);
INSERT INTO `computer_software` VALUES (29,4,8);
INSERT INTO `computer_software` VALUES (30,5,8);

UNLOCK TABLES;

-- Relation Table computer_computerconfig

LOCK TABLES `computer_computerconfig` WRITE;

INSERT INTO `computer_computerconfig` VALUES (1,1,3);
INSERT INTO `computer_computerconfig` VALUES (2,3,6);
INSERT INTO `computer_computerconfig` VALUES (3,7,2);
INSERT INTO `computer_computerconfig` VALUES (4,8,10);
INSERT INTO `computer_computerconfig` VALUES (5,2,6);
INSERT INTO `computer_computerconfig` VALUES (6,6,7);
INSERT INTO `computer_computerconfig` VALUES (7,8,10);
INSERT INTO `computer_computerconfig` VALUES (8,8,9);
INSERT INTO `computer_computerconfig` VALUES (9,3,4);
INSERT INTO `computer_computerconfig` VALUES (10,10,4);
INSERT INTO `computer_computerconfig` VALUES (11,3,1);
INSERT INTO `computer_computerconfig` VALUES (12,2,3);
INSERT INTO `computer_computerconfig` VALUES (13,3,2);
INSERT INTO `computer_computerconfig` VALUES (14,1,4);
INSERT INTO `computer_computerconfig` VALUES (15,9,2);
INSERT INTO `computer_computerconfig` VALUES (16,8,8);
INSERT INTO `computer_computerconfig` VALUES (17,9,9);
INSERT INTO `computer_computerconfig` VALUES (18,8,4);
INSERT INTO `computer_computerconfig` VALUES (19,6,10);
INSERT INTO `computer_computerconfig` VALUES (20,2,3);
INSERT INTO `computer_computerconfig` VALUES (21,8,3);
INSERT INTO `computer_computerconfig` VALUES (22,7,2);
INSERT INTO `computer_computerconfig` VALUES (23,10,3);
INSERT INTO `computer_computerconfig` VALUES (24,3,4);
INSERT INTO `computer_computerconfig` VALUES (25,8,10);
INSERT INTO `computer_computerconfig` VALUES (26,7,6);
INSERT INTO `computer_computerconfig` VALUES (27,8,8);
INSERT INTO `computer_computerconfig` VALUES (28,8,10);
INSERT INTO `computer_computerconfig` VALUES (29,7,8);
INSERT INTO `computer_computerconfig` VALUES (30,4,3);

UNLOCK TABLES;

-- Relation Table computer_network

LOCK TABLES `computer_network` WRITE;

INSERT INTO `computer_network` VALUES (1,8,4);
INSERT INTO `computer_network` VALUES (2,5,7);
INSERT INTO `computer_network` VALUES (3,1,5);
INSERT INTO `computer_network` VALUES (4,6,10);
INSERT INTO `computer_network` VALUES (5,8,6);
INSERT INTO `computer_network` VALUES (6,10,4);
INSERT INTO `computer_network` VALUES (7,8,8);
INSERT INTO `computer_network` VALUES (8,2,6);
INSERT INTO `computer_network` VALUES (9,5,4);
INSERT INTO `computer_network` VALUES (10,2,8);
INSERT INTO `computer_network` VALUES (11,7,5);
INSERT INTO `computer_network` VALUES (12,7,7);
INSERT INTO `computer_network` VALUES (13,7,4);
INSERT INTO `computer_network` VALUES (14,8,5);
INSERT INTO `computer_network` VALUES (15,4,3);
INSERT INTO `computer_network` VALUES (16,10,1);
INSERT INTO `computer_network` VALUES (17,1,4);
INSERT INTO `computer_network` VALUES (18,5,5);
INSERT INTO `computer_network` VALUES (19,6,9);
INSERT INTO `computer_network` VALUES (20,9,5);
INSERT INTO `computer_network` VALUES (21,4,2);
INSERT INTO `computer_network` VALUES (22,1,4);
INSERT INTO `computer_network` VALUES (23,2,2);
INSERT INTO `computer_network` VALUES (24,10,8);
INSERT INTO `computer_network` VALUES (25,5,4);
INSERT INTO `computer_network` VALUES (26,4,10);
INSERT INTO `computer_network` VALUES (27,9,8);
INSERT INTO `computer_network` VALUES (28,1,6);
INSERT INTO `computer_network` VALUES (29,10,9);
INSERT INTO `computer_network` VALUES (30,1,10);

UNLOCK TABLES;

-- Relation Table computer_domain

LOCK TABLES `computer_domain` WRITE;

INSERT INTO `computer_domain` VALUES (1,5,6);
INSERT INTO `computer_domain` VALUES (2,10,7);
INSERT INTO `computer_domain` VALUES (3,7,4);
INSERT INTO `computer_domain` VALUES (4,9,2);
INSERT INTO `computer_domain` VALUES (5,6,2);
INSERT INTO `computer_domain` VALUES (6,5,9);
INSERT INTO `computer_domain` VALUES (7,4,6);
INSERT INTO `computer_domain` VALUES (8,7,3);
INSERT INTO `computer_domain` VALUES (9,10,5);
INSERT INTO `computer_domain` VALUES (10,2,9);
INSERT INTO `computer_domain` VALUES (11,8,3);
INSERT INTO `computer_domain` VALUES (12,1,1);
INSERT INTO `computer_domain` VALUES (13,5,1);
INSERT INTO `computer_domain` VALUES (14,9,4);
INSERT INTO `computer_domain` VALUES (15,6,3);
INSERT INTO `computer_domain` VALUES (16,8,3);
INSERT INTO `computer_domain` VALUES (17,9,8);
INSERT INTO `computer_domain` VALUES (18,4,3);
INSERT INTO `computer_domain` VALUES (19,7,2);
INSERT INTO `computer_domain` VALUES (20,8,7);
INSERT INTO `computer_domain` VALUES (21,9,4);
INSERT INTO `computer_domain` VALUES (22,4,2);
INSERT INTO `computer_domain` VALUES (23,7,9);
INSERT INTO `computer_domain` VALUES (24,6,10);
INSERT INTO `computer_domain` VALUES (25,2,6);
INSERT INTO `computer_domain` VALUES (26,7,9);
INSERT INTO `computer_domain` VALUES (27,5,1);
INSERT INTO `computer_domain` VALUES (28,10,10);
INSERT INTO `computer_domain` VALUES (29,5,2);
INSERT INTO `computer_domain` VALUES (30,1,1);

UNLOCK TABLES;

-- Relation Table computer_ipaddress

LOCK TABLES `computer_ipaddress` WRITE;

INSERT INTO `computer_ipaddress` VALUES (1,7,5);
INSERT INTO `computer_ipaddress` VALUES (2,9,5);
INSERT INTO `computer_ipaddress` VALUES (3,7,9);
INSERT INTO `computer_ipaddress` VALUES (4,2,7);
INSERT INTO `computer_ipaddress` VALUES (5,1,9);
INSERT INTO `computer_ipaddress` VALUES (6,9,1);
INSERT INTO `computer_ipaddress` VALUES (7,5,5);
INSERT INTO `computer_ipaddress` VALUES (8,8,3);
INSERT INTO `computer_ipaddress` VALUES (9,5,10);
INSERT INTO `computer_ipaddress` VALUES (10,9,6);
INSERT INTO `computer_ipaddress` VALUES (11,7,6);
INSERT INTO `computer_ipaddress` VALUES (12,7,8);
INSERT INTO `computer_ipaddress` VALUES (13,5,7);
INSERT INTO `computer_ipaddress` VALUES (14,4,9);
INSERT INTO `computer_ipaddress` VALUES (15,9,2);
INSERT INTO `computer_ipaddress` VALUES (16,6,7);
INSERT INTO `computer_ipaddress` VALUES (17,1,6);
INSERT INTO `computer_ipaddress` VALUES (18,4,5);
INSERT INTO `computer_ipaddress` VALUES (19,9,8);
INSERT INTO `computer_ipaddress` VALUES (20,3,10);
INSERT INTO `computer_ipaddress` VALUES (21,8,5);
INSERT INTO `computer_ipaddress` VALUES (22,5,4);
INSERT INTO `computer_ipaddress` VALUES (23,6,4);
INSERT INTO `computer_ipaddress` VALUES (24,5,3);
INSERT INTO `computer_ipaddress` VALUES (25,6,1);
INSERT INTO `computer_ipaddress` VALUES (26,5,1);
INSERT INTO `computer_ipaddress` VALUES (27,6,5);
INSERT INTO `computer_ipaddress` VALUES (28,10,5);
INSERT INTO `computer_ipaddress` VALUES (29,10,2);
INSERT INTO `computer_ipaddress` VALUES (30,2,6);

UNLOCK TABLES;

-- Relation Table peripheral_peripheralconfig

LOCK TABLES `peripheral_peripheralconfig` WRITE;

INSERT INTO `peripheral_peripheralconfig` VALUES (1,6,10);
INSERT INTO `peripheral_peripheralconfig` VALUES (2,5,2);
INSERT INTO `peripheral_peripheralconfig` VALUES (3,9,6);
INSERT INTO `peripheral_peripheralconfig` VALUES (4,2,5);
INSERT INTO `peripheral_peripheralconfig` VALUES (5,5,7);
INSERT INTO `peripheral_peripheralconfig` VALUES (6,8,2);
INSERT INTO `peripheral_peripheralconfig` VALUES (7,10,9);
INSERT INTO `peripheral_peripheralconfig` VALUES (8,4,5);
INSERT INTO `peripheral_peripheralconfig` VALUES (9,10,2);
INSERT INTO `peripheral_peripheralconfig` VALUES (10,6,2);
INSERT INTO `peripheral_peripheralconfig` VALUES (11,10,10);
INSERT INTO `peripheral_peripheralconfig` VALUES (12,5,5);
INSERT INTO `peripheral_peripheralconfig` VALUES (13,8,3);
INSERT INTO `peripheral_peripheralconfig` VALUES (14,7,1);
INSERT INTO `peripheral_peripheralconfig` VALUES (15,8,6);
INSERT INTO `peripheral_peripheralconfig` VALUES (16,3,2);
INSERT INTO `peripheral_peripheralconfig` VALUES (17,7,8);
INSERT INTO `peripheral_peripheralconfig` VALUES (18,8,5);
INSERT INTO `peripheral_peripheralconfig` VALUES (19,10,4);
INSERT INTO `peripheral_peripheralconfig` VALUES (20,4,3);
INSERT INTO `peripheral_peripheralconfig` VALUES (21,5,4);
INSERT INTO `peripheral_peripheralconfig` VALUES (22,7,2);
INSERT INTO `peripheral_peripheralconfig` VALUES (23,5,2);
INSERT INTO `peripheral_peripheralconfig` VALUES (24,7,6);
INSERT INTO `peripheral_peripheralconfig` VALUES (25,8,9);
INSERT INTO `peripheral_peripheralconfig` VALUES (26,1,10);
INSERT INTO `peripheral_peripheralconfig` VALUES (27,9,8);
INSERT INTO `peripheral_peripheralconfig` VALUES (28,9,8);
INSERT INTO `peripheral_peripheralconfig` VALUES (29,5,10);
INSERT INTO `peripheral_peripheralconfig` VALUES (30,8,6);

UNLOCK TABLES;

-- Relation Table network_peripheral

LOCK TABLES `network_peripheral` WRITE;

INSERT INTO `network_peripheral` VALUES (1,10,8);
INSERT INTO `network_peripheral` VALUES (2,8,7);
INSERT INTO `network_peripheral` VALUES (3,2,4);
INSERT INTO `network_peripheral` VALUES (4,5,7);
INSERT INTO `network_peripheral` VALUES (5,6,1);
INSERT INTO `network_peripheral` VALUES (6,10,10);
INSERT INTO `network_peripheral` VALUES (7,8,10);
INSERT INTO `network_peripheral` VALUES (8,10,1);
INSERT INTO `network_peripheral` VALUES (9,3,4);
INSERT INTO `network_peripheral` VALUES (10,4,5);
INSERT INTO `network_peripheral` VALUES (11,10,4);
INSERT INTO `network_peripheral` VALUES (12,10,6);
INSERT INTO `network_peripheral` VALUES (13,1,4);
INSERT INTO `network_peripheral` VALUES (14,7,9);
INSERT INTO `network_peripheral` VALUES (15,5,5);
INSERT INTO `network_peripheral` VALUES (16,2,9);
INSERT INTO `network_peripheral` VALUES (17,5,10);
INSERT INTO `network_peripheral` VALUES (18,6,10);
INSERT INTO `network_peripheral` VALUES (19,1,9);
INSERT INTO `network_peripheral` VALUES (20,5,8);
INSERT INTO `network_peripheral` VALUES (21,5,7);
INSERT INTO `network_peripheral` VALUES (22,10,5);
INSERT INTO `network_peripheral` VALUES (23,5,4);
INSERT INTO `network_peripheral` VALUES (24,6,9);
INSERT INTO `network_peripheral` VALUES (25,6,5);
INSERT INTO `network_peripheral` VALUES (26,5,2);
INSERT INTO `network_peripheral` VALUES (27,5,8);
INSERT INTO `network_peripheral` VALUES (28,2,2);
INSERT INTO `network_peripheral` VALUES (29,7,10);
INSERT INTO `network_peripheral` VALUES (30,9,9);

UNLOCK TABLES;

-- Relation Table domain_peripheral

LOCK TABLES `domain_peripheral` WRITE;

INSERT INTO `domain_peripheral` VALUES (1,9,9);
INSERT INTO `domain_peripheral` VALUES (2,1,2);
INSERT INTO `domain_peripheral` VALUES (3,5,10);
INSERT INTO `domain_peripheral` VALUES (4,9,2);
INSERT INTO `domain_peripheral` VALUES (5,3,3);
INSERT INTO `domain_peripheral` VALUES (6,9,7);
INSERT INTO `domain_peripheral` VALUES (7,8,2);
INSERT INTO `domain_peripheral` VALUES (8,3,10);
INSERT INTO `domain_peripheral` VALUES (9,6,8);
INSERT INTO `domain_peripheral` VALUES (10,6,6);
INSERT INTO `domain_peripheral` VALUES (11,2,4);
INSERT INTO `domain_peripheral` VALUES (12,9,9);
INSERT INTO `domain_peripheral` VALUES (13,5,1);
INSERT INTO `domain_peripheral` VALUES (14,8,5);
INSERT INTO `domain_peripheral` VALUES (15,7,4);
INSERT INTO `domain_peripheral` VALUES (16,4,8);
INSERT INTO `domain_peripheral` VALUES (17,7,1);
INSERT INTO `domain_peripheral` VALUES (18,3,3);
INSERT INTO `domain_peripheral` VALUES (19,8,9);
INSERT INTO `domain_peripheral` VALUES (20,5,3);
INSERT INTO `domain_peripheral` VALUES (21,9,5);
INSERT INTO `domain_peripheral` VALUES (22,7,6);
INSERT INTO `domain_peripheral` VALUES (23,4,6);
INSERT INTO `domain_peripheral` VALUES (24,10,3);
INSERT INTO `domain_peripheral` VALUES (25,1,10);
INSERT INTO `domain_peripheral` VALUES (26,10,2);
INSERT INTO `domain_peripheral` VALUES (27,2,3);
INSERT INTO `domain_peripheral` VALUES (28,7,4);
INSERT INTO `domain_peripheral` VALUES (29,8,3);
INSERT INTO `domain_peripheral` VALUES (30,8,8);

UNLOCK TABLES;

-- Relation Table ipaddress_peripheral

LOCK TABLES `ipaddress_peripheral` WRITE;

INSERT INTO `ipaddress_peripheral` VALUES (1,10,7);
INSERT INTO `ipaddress_peripheral` VALUES (2,3,5);
INSERT INTO `ipaddress_peripheral` VALUES (3,8,3);
INSERT INTO `ipaddress_peripheral` VALUES (4,8,3);
INSERT INTO `ipaddress_peripheral` VALUES (5,5,6);
INSERT INTO `ipaddress_peripheral` VALUES (6,5,3);
INSERT INTO `ipaddress_peripheral` VALUES (7,9,6);
INSERT INTO `ipaddress_peripheral` VALUES (8,9,3);
INSERT INTO `ipaddress_peripheral` VALUES (9,4,8);
INSERT INTO `ipaddress_peripheral` VALUES (10,1,5);
INSERT INTO `ipaddress_peripheral` VALUES (11,9,1);
INSERT INTO `ipaddress_peripheral` VALUES (12,8,6);
INSERT INTO `ipaddress_peripheral` VALUES (13,6,9);
INSERT INTO `ipaddress_peripheral` VALUES (14,9,8);
INSERT INTO `ipaddress_peripheral` VALUES (15,4,4);
INSERT INTO `ipaddress_peripheral` VALUES (16,1,9);
INSERT INTO `ipaddress_peripheral` VALUES (17,7,8);
INSERT INTO `ipaddress_peripheral` VALUES (18,6,1);
INSERT INTO `ipaddress_peripheral` VALUES (19,3,3);
INSERT INTO `ipaddress_peripheral` VALUES (20,8,1);
INSERT INTO `ipaddress_peripheral` VALUES (21,6,2);
INSERT INTO `ipaddress_peripheral` VALUES (22,9,1);
INSERT INTO `ipaddress_peripheral` VALUES (23,3,6);
INSERT INTO `ipaddress_peripheral` VALUES (24,5,8);
INSERT INTO `ipaddress_peripheral` VALUES (25,9,9);
INSERT INTO `ipaddress_peripheral` VALUES (26,6,5);
INSERT INTO `ipaddress_peripheral` VALUES (27,1,10);
INSERT INTO `ipaddress_peripheral` VALUES (28,9,9);
INSERT INTO `ipaddress_peripheral` VALUES (29,4,5);
INSERT INTO `ipaddress_peripheral` VALUES (30,5,1);

UNLOCK TABLES;

-- Relation Table ipaddress_network

LOCK TABLES `ipaddress_network` WRITE;

INSERT INTO `ipaddress_network` VALUES (1,4,3);
INSERT INTO `ipaddress_network` VALUES (2,9,1);
INSERT INTO `ipaddress_network` VALUES (3,10,9);
INSERT INTO `ipaddress_network` VALUES (4,3,8);
INSERT INTO `ipaddress_network` VALUES (5,2,10);
INSERT INTO `ipaddress_network` VALUES (6,5,10);
INSERT INTO `ipaddress_network` VALUES (7,8,5);
INSERT INTO `ipaddress_network` VALUES (8,8,1);
INSERT INTO `ipaddress_network` VALUES (9,7,4);
INSERT INTO `ipaddress_network` VALUES (10,1,2);
INSERT INTO `ipaddress_network` VALUES (11,7,6);
INSERT INTO `ipaddress_network` VALUES (12,8,7);
INSERT INTO `ipaddress_network` VALUES (13,6,3);
INSERT INTO `ipaddress_network` VALUES (14,6,6);
INSERT INTO `ipaddress_network` VALUES (15,3,1);
INSERT INTO `ipaddress_network` VALUES (16,10,3);
INSERT INTO `ipaddress_network` VALUES (17,7,3);
INSERT INTO `ipaddress_network` VALUES (18,7,8);
INSERT INTO `ipaddress_network` VALUES (19,4,6);
INSERT INTO `ipaddress_network` VALUES (20,1,6);
INSERT INTO `ipaddress_network` VALUES (21,6,3);
INSERT INTO `ipaddress_network` VALUES (22,1,6);
INSERT INTO `ipaddress_network` VALUES (23,9,9);
INSERT INTO `ipaddress_network` VALUES (24,10,4);
INSERT INTO `ipaddress_network` VALUES (25,2,9);
INSERT INTO `ipaddress_network` VALUES (26,6,8);
INSERT INTO `ipaddress_network` VALUES (27,3,8);
INSERT INTO `ipaddress_network` VALUES (28,3,4);
INSERT INTO `ipaddress_network` VALUES (29,2,10);
INSERT INTO `ipaddress_network` VALUES (30,10,2);

UNLOCK TABLES;

-- Relation Table domain_network

LOCK TABLES `domain_network` WRITE;

INSERT INTO `domain_network` VALUES (1,6,10);
INSERT INTO `domain_network` VALUES (2,9,5);
INSERT INTO `domain_network` VALUES (3,4,2);
INSERT INTO `domain_network` VALUES (4,9,3);
INSERT INTO `domain_network` VALUES (5,3,3);
INSERT INTO `domain_network` VALUES (6,4,3);
INSERT INTO `domain_network` VALUES (7,4,4);
INSERT INTO `domain_network` VALUES (8,1,2);
INSERT INTO `domain_network` VALUES (9,3,3);
INSERT INTO `domain_network` VALUES (10,6,5);
INSERT INTO `domain_network` VALUES (11,1,2);
INSERT INTO `domain_network` VALUES (12,5,3);
INSERT INTO `domain_network` VALUES (13,4,9);
INSERT INTO `domain_network` VALUES (14,2,10);
INSERT INTO `domain_network` VALUES (15,2,5);
INSERT INTO `domain_network` VALUES (16,7,6);
INSERT INTO `domain_network` VALUES (17,2,8);
INSERT INTO `domain_network` VALUES (18,1,5);
INSERT INTO `domain_network` VALUES (19,4,10);
INSERT INTO `domain_network` VALUES (20,4,8);
INSERT INTO `domain_network` VALUES (21,5,8);
INSERT INTO `domain_network` VALUES (22,10,8);
INSERT INTO `domain_network` VALUES (23,6,4);
INSERT INTO `domain_network` VALUES (24,5,6);
INSERT INTO `domain_network` VALUES (25,1,5);
INSERT INTO `domain_network` VALUES (26,5,5);
INSERT INTO `domain_network` VALUES (27,4,5);
INSERT INTO `domain_network` VALUES (28,7,7);
INSERT INTO `domain_network` VALUES (29,8,9);
INSERT INTO `domain_network` VALUES (30,5,5);

UNLOCK TABLES;

