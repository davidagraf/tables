<?php
function readJSONBody(&$json) {
  $jsonString = file_get_contents('php://input');
  $json = json_decode($jsonString);
  $errorPrefix = 'json parse error: ';
  $errorHeader = 'HTTP/1.1 400 Bad Request';
  switch(json_last_error()) {
    case JSON_ERROR_DEPTH:
      header($errorHeader);
      echo $errorPrefix . 'maximum stack depth exceeded';
    break;
    case JSON_ERROR_CTRL_CHAR:
      header($errorHeader);
      echo $errorPrefix . 'unexpected control character found';
    break;
    case JSON_ERROR_SYNTAX:
      header($errorHeader);
      echo $errorPrefix . 'syntax error, malformed JSON';
    break;
    case JSON_ERROR_NONE:
    return true;
    break;
  }
  return false;
}
?>