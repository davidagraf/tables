<?php

/**
 * All available resources
 */

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

?>