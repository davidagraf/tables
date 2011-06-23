<?php
/**
 * Parses a path component query (e.g. 'software!=1' in /computer/software!=1).
 */
class RestfulQuery {
  var $queries = array();
  var $resource = array();
  
  function RestfulQuery() {}
  
  /**
   * Error if something goes wrong.
   * @param String $queryStr
   */
  private function printError($queryStr) {
    header('HTTP/1.1 400 Bad Request');
    echo "URI component query '" . $queryStr . "' not supported.";
  }
  
  /**
   * 
   * Parses path component query and initializes helper variables.
   * 
   * @param string $string query
   * @param resource $resource resource on which the query (filter) is executed.
   */
  function init($string, $resource) {
    $this->queries = array();
    $this->resource = $resource;
    $queryStrs = explode(",", $string);
    foreach($queryStrs as $queryStr) {
      $delimiter = null;
      $sqlop = null;
      if (strpos($queryStr, "==")) {
        $delimiter = "==";
        $sqlop = '=';
      }
      else if (strpos($queryStr, '!=')) {
        $delimiter = "!=";
        $sqlop = "<>";
      }
      
      if (is_null($delimiter)) {
        $this->queries[] = array("key"=>"id", "sqlop"=>"=", "value"=>$queryStr);
      }
      else {
        $keyValue = explode($delimiter, $queryStr);
        if (count($keyValue) != 2
          || (
              !array_key_exists($keyValue[0], $resource["relations"]) && !in_array($keyValue[0], $resource["fields"]) 
             )) {
          $this->printError($queryStr);
          return false;
        }
        $this->queries[] = array("key"=>$keyValue[0], "sqlop"=>$sqlop, "value"=>$keyValue[1]);
      }
    }
    return true;
  }
  
  /**
   * SQL snipped generation.
   * @param string $sql The sql nipped that generates the data which need to be filtered.
   * 										It is wrapped into the newly generated sql.
   */
  function generateSQLSnippets(&$sql) {
    foreach($this->queries as $query) {
      $key = $query["key"];
      $sqlop = $query["sqlop"];
      $value = $query["value"];
      
      if ($key === "id") {
        $sql =  "SELECT " . $this->resource["name"] . ".*"
             . " FROM (" . $sql . ") AS " . $this->resource["name"]
             . " WHERE " . $this->resource["name"] . ".id=" . $value;
      }
      elseif (array_key_exists($key, $this->resource["relations"])) {
        $relation = $this->resource["relations"][$key];
        if ($sqlop === "=") {
          $sql =  "SELECT " . $this->resource["name"] . ".*"
                . " FROM (" . $sql . ") AS " . $this->resource["name"]
                . " JOIN " . $relation . " ON " . $relation . "." . $this->resource["name"] . "=" . $this->resource["name"] . ".id"
                . " WHERE " . $relation . "." . $key . "=" . $value;
          
        }
        // $sqlop ==== "<>"
        else {
          $sql =  "SELECT " . $this->resource["name"] . ".*"
               . " FROM (" . $sql . ") AS " . $this->resource["name"]
               . " WHERE NOT EXISTS (" 
               .   " SELECT * FROM " . $relation
               .   " WHERE " . $relation . "." . $this->resource["name"] . "=" . $this->resource["name"] . ".id"
               .     " AND " . $relation . "." . $key . "=" . $value
               . " )";
        }
      } 
      else {
        $sql =  "SELECT " . $this->resource["name"] . ".*"
             . " FROM (" . $sql . ") AS " . $this->resource["name"]
             . " WHERE " . $this->resource["name"] . "." . $key . $sqlop . "'" . $value . "'";
      }
    }
  }
}

?>
