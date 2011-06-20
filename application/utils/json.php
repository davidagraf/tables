<?php
function readJSONBody(&$json) {
  $jsonString = file_get_contents('php://input');
  $json = json_decode($jsonString);
  header('HTTP/1.1 400 Bad Request'); 
  $errorPrefix = 'json parse error: ';
  switch(json_last_error()) {
    case JSON_ERROR_DEPTH:
      echo $errorPrefix . 'maximum stack depth exceeded';
    break;
    case JSON_ERROR_CTRL_CHAR:
      echo $errorPrefix . 'unexpected control character found';
    break;
    case JSON_ERROR_SYNTAX:
      echo $errorPrefix . 'syntax error, malformed JSON';
    break;
    case JSON_ERROR_NONE:
    return true;
    break;
  }
  return false;
}
?>