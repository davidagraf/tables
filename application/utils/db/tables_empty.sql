-- --------------------------------------------------------------------------------------
-- Generated SQL script 'tables_empty.sql' for TABLES
-- JSON Resources 'resources.json'
-- Created on 2011-07-01T14:39:16+02:00
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


