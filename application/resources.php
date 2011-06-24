<?php

/**
 * All available resources
 */
/*
$resources = array(
  "computer" => array(
    "name" => "computer",
    "fields" => array("asset_tag", "type", "brand", "model", "status", "name", "serial1", "serial2"),
    "relations" => array("software" => "computer_software")
  ),
  "software" => array(
    "name" => "software",
    "fields" => array("name", "version", "distributor", "license", "expiration", "comments"),
    "relations" => array("computer" => "computer_software")
  )
);
*/

class Resources
{
    // Hold an instance of the class
    private static $instance;
    
    private $resources;
    
    // A private constructor; prevents direct creation of object
    private function __construct() 
    {
      $resources_file = file_get_contents($_SERVER["DOCUMENT_ROOT"] . '/public/js/resources.json');
      $this->resources = json_decode($resources_file, true);
    }

    // The singleton method
    public static function singleton() 
    {
        if (!isset(self::$instance)) {
            $c = __CLASS__;
            self::$instance = new $c;
        }

        return self::$instance;
    }
    
    // Example method
    public function resources()
    {
        return $this->resources;
    }

    // Prevent users to clone the instance
    public function __clone()
    {
        trigger_error('Clone is not allowed.', E_USER_ERROR);
    }

}

?>