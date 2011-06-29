-- --------------------------------------------------------------------------------------
-- Generated SQL script 'tables_empty.sql' for TABLES
-- JSON Resources 'resources.json'
-- Created on 2011-06-29T16:04:41+02:00
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


