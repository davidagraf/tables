<?php

/**
 * All requests are redirected from the .htaccess to this php file. 
 */

include_once 'utils/uri.php';
include_once 'resources.php';
include_once 'handler.php';

// Parses request uri
$uri = new UriParser();

// Executes handler to produce the response.
$handler = new Handler($resources, $uri);
$handler->invoke();

?>