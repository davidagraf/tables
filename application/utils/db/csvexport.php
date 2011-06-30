<?php

include_once $_SERVER["DOCUMENT_ROOT"] . '/application/utils/db/mysql_connect.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/application/utils/db/mysql_query.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/application/utils/db/command_snippets.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/application/resources.php';

$resourceName =  $_GET['resource'];

header('Content-Type: text/x-csv');
header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
header('Content-Disposition: attachment; filename=' . $resourceName . '.csv');
header('Pragma: no-cache');

try {
	$resources = Resources::singleton()->resources();
	$resource = $resources[$resourceName];

	if(!isset($resource)) {
	 header('HTTP/1.1 404 Not Found');
	 exit();
	}

	$query = 'SELECT * FROM ' . $resource["name"];


	if (!execute_mysql_query($query, $result)) {
		exit();
	}

	$csv = new StringBuilder("\n");
	$count = 1;
	foreach ($resource["fields"] as $field) {
		if($count == count($resource["fields"])) {
			$csv->appendLine($field["title"]);
		} else {
			$csv->append($field["title"] . ';');
		}
		$count++;
	}
	while ($row = mysql_fetch_array($result, MYSQL_NUM)) {
		// skip 'id', start with 1
		for ($i = 1; $i < count($row); $i++) {
			if($i == count($row) - 1) {
				$csv->appendLine($row[$i]);
			} else {
				$csv->append($row[$i] . ';');
			}
		}
	}
	echo $csv->toString();
} catch (Exception $e) {
	header('HTTP/1.1 500 Internal Server Error');
	echo 'Error with CSV export: ' . $e->getMessage();
}
