<?php
function create_columns_values_for_insert($json, &$columns, &$values) {
  $vars = get_object_vars($json);
  
  // Filter out id. It must not be set manually!
  unset($vars['id']);
  
  function singlequotes_wrap($value) {
    return "'" . $value . "'";
  }
  
  $columns = '(' . implode(',', array_keys($vars)) . ')';
  $wrappedValues = array_map("singlequotes_wrap", $vars);
  $values = '(' . implode(',', $wrappedValues) . ')';
}

function create_assigns_for_update($json, &$assigns) {
  $vars = get_object_vars($json);
  // Filter out id. It must not be set manually!
  unset($vars['id']);
  
  $assignsArray = array();
  foreach($vars as $key => $value) {
    $assignsArray[] = $key . "='" . $value ."'";
  }
  
  $assigns = implode(',', $assignsArray);
}
?>