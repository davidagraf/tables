<?php
class UriParser {
  var $pathComps = array();
  var $queryComps = array();
	
  function UriParser(){
    $uri  = parse_url($_SERVER['REQUEST_URI']);
    
    $path = $uri['path'];
    $this->pathComps = explode('/', /*remove starting slash*/substr($path, 1));
    
    if (array_key_exists('query', $uri)) {
      parse_str($uri['query'], $this->queryComps);
    }
	}

	function getPathComps() {
	  return $this->pathComps;
	}
	
	function getQueryComps() {
	  return $this->queryComps;
	}
	
	function getRequestUri() {
	  return $_SERVER['REQUEST_URI'];
	}
}
?>