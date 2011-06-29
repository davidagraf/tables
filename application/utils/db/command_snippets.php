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

function generate_joins_string($joins) {
	$str = "";
	foreach($joins as $key => $value) {
		$str .= " JOIN " . $key . " ON " . $value;
	}
	return $str;
}

function generate_relation_table($firstResourceName, $secondResourceName) {
	$relationTable;
	if (strcmp($firstResourceName, $secondResourceName) < 0) {
		$relationTable = $firstResourceName . "_" . $secondResourceName;
	}
	else {
		$relationTable = $secondResourceName . "_" . $firstResourceName;
	}
	return $relationTable;
}

class StringBuilder {

	private $linebr;
	function StringBuilder($linebr = "\n") {
		$this->linebr = $linebr;
	}

	private $str = array();

	public function append($str = "") {
		$this->str[] = $str;
	}

	public function appendLine($str = "") {
		$this->str[] = $str . $this->linebr;
	}

	public function toString() {
		return implode($this->str);
	}
}

function printJSONError() {
	switch (json_last_error()) {
		case JSON_ERROR_NONE:
			echo ' - No errors';
			break;
		case JSON_ERROR_DEPTH:
			echo ' - Maximum stack depth exceeded';
			break;
		case JSON_ERROR_STATE_MISMATCH:
			echo ' - Underflow or the modes mismatch';
			break;
		case JSON_ERROR_CTRL_CHAR:
			echo ' - Unexpected control character found';
			break;
		case JSON_ERROR_SYNTAX:
			echo ' - Syntax error, malformed JSON';
			break;
		case JSON_ERROR_UTF8:
			echo ' - Malformed UTF-8 characters, possibly incorrectly encoded';
			break;
		default:
			echo ' - Unknown error';
			break;
	}
}


?>