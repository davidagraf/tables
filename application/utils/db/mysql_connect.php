<?php

$db_host = "localhost";
$db_username = "tables";
$db_pass = "tables";
$db_name = "tables";

if (!@mysql_connect("$db_host","$db_username","$db_pass")) {
  header('HTTP/1.1 500 Internal Server Error');
  die ("Could not connect to MySQL.");
}
if (!@mysql_select_db("$db_name")) {
  header('HTTP/1.1 500 Internal Server Error');
  die ("No database");
}

?>