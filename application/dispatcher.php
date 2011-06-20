<?php

include_once 'utils/uri.php';
include_once 'resources.php';
include_once 'handler.php';

$uri = new ArmyUri();
$handler = new Handler($resources, $uri);
$handler->invoke();

?>