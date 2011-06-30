<?php

include_once "command_snippets.php";

// call "php sqlgenerator.php ..\..\..\public\data\resources2.json" "tables_empty.sql"

if(count($argv) != 3 && count($argv) != 5) {
	echo "\nusage: php sqlgenerator.php <in:jsonresources> <out:sqlfile> [--datafixture N]\n";
	exit();
}

$gen = new Generator($argv[1], $argv[2]);
$dataFixture = false;
$numberOfEntries = 10;

if(count($argv) == 5) {
	$dataFixture = (strcasecmp($argv[3], "--datafixture") == 0);
	$numberOfEntries = (int)$argv[4];
}

$gen->generate($dataFixture, $numberOfEntries);

class Generator {
	private $resources;
	private $dumpFileName;
	private $jsonFileName;
	private $dumpFileHandle;
	private $LINEBREAK = "\n";
	private $tables = array();
	private $relationTables = array();
	private $tableInserts = array();
	private $relationTableInserts = array();

	function Generator($jsonFile, $dumpFile) {
		$this->dumpFileName = $this->getFileName($dumpFile);
		$this->jsonFileName = $this->getFileName($jsonFile);
		$this->resources = json_decode(file_get_contents($jsonFile), true, 1024);

		// printJSONError();

		$this->dumpFileHandle = fopen($dumpFile, "w") or die("can't open file");
	}

	function generate($dataFixture, $numberOfEntries) {
		foreach ($this->resources as $name => $resource) {
			$this->tables[$name] = $this->get_table_sql($resource);
			$this->tableInserts[$name] = $this->get_table_insert_sql($resource, $numberOfEntries);
			foreach ($this->get_relation_tables($resource) as $relationTable => $sql) {
				if(!array_key_exists($relationTable, $this->relationTables)){
					$this->relationTables[$relationTable] = $sql;
					$this->relationTableInserts[$relationTable] =  $this->get_relation_table_insert_sql($relationTable, $numberOfEntries);
				}
			}
		}
		// print_r($this->tables);

		$this->dumpDBHeader();
		$this->dumpTables();
		$this->dumpRelationTables();

		if($dataFixture) {
			$this->dumpTableInserts();
			$this->dumpRelationTableInserts();
		}

		fclose($this->dumpFileHandle);
	}

	// functions
	function get_table_sql($resource) {
		$buffer = new StringBuilder($this->LINEBREAK);
		$buffer->appendLine("DROP TABLE IF EXISTS `" . $resource["name"] . "`;");
		$buffer->appendLine();
		$buffer->appendLine("CREATE TABLE `" . $resource["name"] . "` (");
		$buffer->appendLine("  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,");

		foreach ($resource["fields"] as $name => $field) {
			$type = "";
			if(array_key_exists("type", $field)) {
				$type = $field["type"];
			}

			$isreq = false;
			if(array_key_exists("isreq", $field)) {
				$isreq = strcasecmp($field["isreq"], "true") == 0;
			}
			$buffer->append("  `" . $name . "` " . $this->get_sql_type($type));
			$buffer->appendLine(" " . ($isreq ? "NOT NULL" : "DEFAULT NULL") . ",");
		}

		$buffer->appendLine("  PRIMARY KEY (`id`)");
		$buffer->appendLine(") ENGINE=InnoDB DEFAULT CHARSET=latin1;");

		return $buffer->toString();
	}

	function get_sql_type($type) {
		switch ($type) {
			case "number":
				return "int(12)";
				break;
			case "largenumber":
				return "int(24)";
				break;
			case "date":
				return "date";
				break;
			case "textarea":
				return "varchar(1200)";
				break;
			default:
				return "varchar(140)";
				break;
		}
	}

	function get_relation_table_sql($relationTable, $from, $to) {
		$buffer = new StringBuilder($this->LINEBREAK);
		$buffer->appendLine("DROP TABLE IF EXISTS `".$relationTable."`;");
		$buffer->appendLine();
		$buffer->appendLine("CREATE TABLE `".$relationTable."` (");
		$buffer->appendLine("  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,");
		$buffer->appendLine("  `".$from."` int(11) unsigned NOT NULL,");
		$buffer->appendLine("  `".$to."` int(11) unsigned NOT NULL,");
		$buffer->appendLine("  PRIMARY KEY (`id`),");
		$buffer->appendLine("  KEY `".$from."` (`".$from."`),");
		$buffer->appendLine("  KEY `".$to."` (`".$to."`),");
		$buffer->append("  CONSTRAINT `" . $relationTable . "_ibfk_2` FOREIGN KEY (`" . $from . "`) ");
		$buffer->appendLine("REFERENCES `".$from."` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,");
		$buffer->append("  CONSTRAINT `" . $relationTable . "_ibfk_3` FOREIGN KEY (`" . $to . "`) ");
		$buffer->appendLine("REFERENCES `".$to."` (`id`) ON DELETE CASCADE ON UPDATE CASCADE");
		$buffer->appendLine(") ENGINE=InnoDB DEFAULT CHARSET=latin1;");
		return $buffer->toString();
	}

	function get_table_insert_sql($resource, $n) {
		$buffer = new StringBuilder($this->LINEBREAK);
		$fieldsStatement = "(`id`";
		foreach ($resource["fields"] as $name => $field) {
		 $fieldsStatement .= ", `" . $name ."`";
		}
		$fieldsStatement .= ")";

		for ($i = 1; $i <= $n; $i++) {
			$buffer->append("INSERT INTO `".$resource["name"]."` " . $fieldsStatement . " VALUES (" . $i . ",");
			$fieldCount = count($resource["fields"]);
			$count = 1;
			foreach ($resource["fields"] as $name => $field) {
				$type = "";
				if(array_key_exists("type", $field)) {
					$type = $field["type"];
				}

				$buffer->append("'" . $this->get_random_value($type, $field["title"], $i) . "'");

				if($count != $fieldCount) {
					$buffer->append(",");
				} else {
					$buffer->appendLine(");");
				}
				$count++;

			}
		}
		return $buffer->toString();
	}

	function get_relation_table_insert_sql($relationTable, $n) {
		$buffer = new StringBuilder($this->LINEBREAK);
		for ($i = 1; $i <= $n*3; $i++) {
			$buffer->append("INSERT INTO `".$relationTable."` VALUES (" . $i . ",");
			$buffer->append(rand(1,$n) . ",");
			$buffer->appendLine(rand(1,$n) . ");");    }
			return $buffer->toString();
	}

	function get_relation_tables($resource) {
		$relationTables = array();
		if(!array_key_exists("relations", $resource)) {
			return $relationTables;
		}

		$relations = $resource["relations"];
		$resourceName = $resource["name"];

		foreach ($relations as $key => $value) {
			$relationTable = generate_relation_table($resourceName, $key);
			$parts = explode("_", $relationTable);
			$fromRes = $parts[0];
			$toRes = $parts[1];
			if(!array_key_exists($relationTable, $relationTables)) {
				$relationTables[$relationTable] = $this->get_relation_table_sql($relationTable,$fromRes,$toRes);
			}
		}
		return $relationTables;
	}

	function get_random_value($type, $title, $n) {
		switch ($type) {
			case "number":
			case "largenumber":
				return rand(78, 8382);
				break;
			case "date":
				return rand(1999,2011) . "-" . str_pad(rand(1,12), 2, "0", STR_PAD_LEFT) . "-" . str_pad(rand(1,28), 2, "0", STR_PAD_LEFT);
				break;
			case "url":
				return "www.google.com";
			case "email":
				return "hansmuster" . $n . "@gmail.com";
				break;
			case "ip":
				return "192.168." . rand(0,255) . "." . $n;
				break;
			default:
				return $title . " (" . $n . ")";
				break;
		}
	}

	function dumpDBHeader() {
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine("-- Generated SQL script '" . $this->dumpFileName ."' for TABLES");
		$this->writeLine("-- JSON Resources '" . $this->jsonFileName . "'");
		$this->writeLine("-- Created on " . date("c"));
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine();
		$this->writeLine("DROP SCHEMA IF EXISTS `tables`;");
		$this->writeLine("CREATE SCHEMA `tables`;");
		$this->writeLine("USE `tables`;");
		$this->writeLine();
	}

	function dumpTables() {
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine("-- Tables");
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine();
		foreach ($this->tables as $name => $table) {
			$this->writeLine("-- Table " . $name);
			$this->writeLine();
			$this->writeLine($table);
			$this->writeLine();
		}
	}

	function dumpRelationTables() {
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine("-- Relation Tables");
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine();
		foreach ($this->relationTables as $name => $table) {
			$this->writeLine("-- Relation Table " . $name);
			$this->writeLine();
			$this->writeLine($table);
			$this->writeLine();
		}
	}

	function dumpTableInserts() {
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine("-- Table Inserts (test data)");
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine();
		foreach ($this->tableInserts as $name => $tableInserts) {
			$this->writeLine("-- Table " . $name);
			$this->writeLine();
			$this->writeLine("LOCK TABLES `" . $name . "` WRITE;");
			$this->writeLine();
			$this->writeLine($tableInserts);
			$this->writeLine("UNLOCK TABLES;");
			$this->writeLine();
		}
	}

	function dumpRelationTableInserts() {
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine("-- Relation Table Inserts (test data)");
		$this->writeLine("-- --------------------------------------------------------------------------------------");
		$this->writeLine();
		foreach ($this->relationTableInserts as $name => $tableInserts) {
			$this->writeLine("-- Relation Table " . $name);
			$this->writeLine();
			$this->writeLine("LOCK TABLES `" . $name . "` WRITE;");
			$this->writeLine();
			$this->writeLine($tableInserts);
			$this->writeLine("UNLOCK TABLES;");
			$this->writeLine();
		}
	}

	// helper
	function writeLine($line = "") {
		fwrite($this->dumpFileHandle, $line .  $this->LINEBREAK);
	}

	function getFileName($fullname) {
		if(!isset($fullname)) return $fullname;

		$parts = explode("\\", $fullname);
		if(count($parts) == 1){
			$parts = explode("/", $fullname);
		}
		return $parts[count($parts) - 1];
	}
}
