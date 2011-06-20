<?php

include_once $_SERVER["DOCUMENT_ROOT"] . '/application/utils/db/mysql_connect.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/application/utils/db/mysql_query.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/application/utils/db/command_snippets.php';
include_once $_SERVER["DOCUMENT_ROOT"] . '/application/utils/json.php';

class Handler {
  var $resources = array();
  var $uri;
  var $pathComps;
  var $pathCompsCount;
  
  var $firstResource = null;
  var $secondResource = null;
  var $relation = null;
  
  function Handler($resources, $uri) {
    $this->resources = $resources;
    $this->uri = $uri;
    $this->pathComps = $uri->getPathComps();
    $this->pathCompsCount = count($this->pathComps);
  }
  
  private function resourceNotFound() {
    header('HTTP/1.1 404 Not Found');
    echo "Resource '" . $this->uri->getRequestUri() . "' not found or not allowed.";
  }
  
  private function init() {
    if ($this->pathCompsCount > 4) {
  	  $this->resourceNotFound();
  	  return;
  	}
    
    if (!array_key_exists($this->pathComps[0], $this->resources)) {
      $this->resourceNotFound();
      return false;
    }
    $this->firstResource = $this->resources[$this->pathComps[0]];
  	
    $this->secondResource = null;
    $this->relation = null;
    if ($this->pathCompsCount > 2) {
      if (!array_key_exists($this->pathComps[2], $this->resources)) {
        $this->resourceNotFound();
        return false;
      }
      $this->secondResource = $this->resources[$this->pathComps[2]];
      
      
      if (!array_key_exists($this->pathComps[0],$this->secondResource["relations"])) {
        $this->resourceNotFound();
        echo " Relation missing.";
        return false;
      }
      $this->relation = $this->secondResource["relations"][$this->pathComps[0]];
    }
    
    return true;
  }
  
  private function get() {
    header('Content-type: application/json');
    
  	// compute SELECT
  	$resourceToPrint = ($this->secondResource ? $this->secondResource : $this->firstResource);
  	$select = $resourceToPrint["fields"];
  	$select[] = "id";
    function addPrefix(&$item, $key, $prefix) {
      $item = "$prefix$item";
    }
  	array_walk($select, 'addPrefix', $resourceToPrint["name"] . ".");
  	
  	// compute FROM
  	$from = array();
  	if ($this->secondResource) {
  	  $from[] = $this->secondResource["name"];
  	  $from[] = $this->relation;
  	}
  	else {
  	  $from[] = $this->firstResource["name"];
  	}
  	
  	// compute WHERE
  	$where = array();
  	if ($this->secondResource) {
  	  $where[] = $this->relation . "." . $this->firstResource["name"] . "=" . $this->pathComps[1];
  	  $where[] = $this->relation . "." . $this->secondResource["name"] . "=" . $this->secondResource["name"] . ".id";
  	  if ($this->pathCompsCount > 3) {
  	    $where[] = $this->secondResource["name"] . ".id=" . $this->pathComps[3];
  	  }
  	}
  	else if ($this->pathCompsCount > 1) {
  	  $where[] = $this->firstResource["name"] . ".id=" . $this->pathComps[1];
  	}
  	
  	$query =    "SELECT "
  	         .     implode(",", $select)
  				   . " FROM "
  					 .     implode(",",$from)
  					 .   (count($where) > 0 ? " WHERE " . implode(" AND ", $where) : "");
  
  	if (execute_mysql_query($query, $result)) {
    	$arr = array();
    	
    	while ($row = mysql_fetch_assoc($result)) {
    	  $arr[] = $row;
    	}
    
    	$json = json_encode($arr);
    
    	echo $json;
  	}
  }
  
  private function post() {
  	switch($this->pathCompsCount) {
  	  case 1:
  	    if (readJSONBody($json)) {
    	    create_columns_values_for_insert($json, $columns, $values);
          $query = "INSERT INTO " . $this->firstResource["name"] . " "
                 . $columns
                 . " VALUES "
                 . $values;
    
          if (execute_mysql_query($query, $result)) {
            header('HTTP/1.1 201 Created');
            header('Location: http://' . $_SERVER['HTTP_HOST'] . "/" . $this->firstResource["name"] . "/" . mysql_insert_id());
          }
  	    }
  	    break;
  	  case 2:
  	    if (readJSONBody($json)) {
          create_assigns_for_update($json, $assigns);
          $query = "UPDATE " . $this->firstResource["name"] . " SET "
                 . $assigns
                 . "WHERE id="
                 . $this->pathComps[1];
    
          if (execute_mysql_query($query, $result)) {
            header('HTTP/1.1 204 No Content');
          }
  	    }
  	    break;
  	  case 3:
  	    // the relations to do could be passed as json
  	    header('HTTP/1.1 501 Not Implemented');
  	    break;
  	  case 4:
  	    // insert relation if it does not exist, example:
  	    // insert into computer_software (computer,software) 
  	    //   select 103,1 from dual where not exists(
        //     select *
        //     from computer_software
        //     where computer_software.computer=103 AND computer_software.software=1)
  	    $query = "INSERT INTO " . $this->relation 
  	           . "  (" . $this->firstResource["name"] . "," . $this->secondResource["name"] . ")"
  	           . "  SELECT " . $this->pathComps[1] . "," . $this->pathComps[3] 
  	           . "    FROM DUAL WHERE NOT EXISTS("
  	           . "      SELECT *"
  	           . "      FROM " . $this->relation
  	           . "      WHERE " . $this->firstResource["name"] . "=" . $this->pathComps[1]
  	           . "        AND " . $this->secondResource["name"] . "=" . $this->pathComps[3]
  	           . ")";
  	    if (execute_mysql_query($query, $result)) {
  	      if (mysql_insert_id() == 0) {
  	        header('HTTP/1.1 400 Bad Request');
  	        echo "No duplicate entries allowed in relation ". $this->relation . ".";
  	      }
  	      else {
            header('HTTP/1.1 204 No Content');
  	      }
        }
  	    break;
  	}
  }
  
  private function delete() {
    if ($this->pathCompsCount == 1 || $this->pathCompsCount == 3) {
      header('HTTP/1.1 403 Forbidden');
      return;
    }
    
    if ($this->pathCompsCount == 2) {
      $query = "DELETE FROM " . $this->firstResource["name"] . " WHERE id="
         . $this->pathComps[1];
  
      if (execute_mysql_query($query, $result)) {
        header('HTTP/1.1 204 No Content');
      }
    }
    else {
      $query = "DELETE FROM " . $this->relation 
      			 . " WHERE " . $this->firstResource["name"] . "=" . $this->pathComps[1]
      			 . "   AND " . $this->secondResource["name"] . "=" . $this->pathComps[3];
  
      if (execute_mysql_query($query, $result)) {
        header('HTTP/1.1 204 No Content');
      }
    }
  }
  
  function invoke() {
    if (!$this->init()) {
      return;
    }
    
    if ($_SERVER['REQUEST_METHOD'] == 'GET') {
      $this->get();
    }
    elseif ($_SERVER['REQUEST_METHOD'] == 'POST') {
      $this->post();
    }
    elseif ($_SERVER['REQUEST_METHOD'] == 'DELETE') {
      $this->delete();
    }
    else {
      header('HTTP/1.1 501 Not Implemented');
    }
  }
}

?>
