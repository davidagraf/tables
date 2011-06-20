<?php

$db_host = "localhost";
$db_username = "tables";
$db_pass = "tables";
$db_name = "tables";

@mysql_connect("$db_host","$db_username","$db_pass") or die ("Could not connect to MySQL.");
@mysql_select_db("$db_name") or die ("No database");

?>