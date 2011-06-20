<?php

function execute_mysql_query($query, &$result) {
	$result = mysql_query($query);
	
	if (!$result) {
	  header('HTTP/1.1 500 Internal Server');
	  echo 'mysql error: ' . mysql_error();
		return false;
	}
	
	return true;
}

?>