var $msgBoxTable = $(".table-msg-box");
var $msgBoxForm = $(".form-msg-box");
// see tabledatasource, if this flag is set, the showError function will be called automatically on error
// for every datasource
var DATASOURCE_DEFAULT_ERROR_HANDLING = true;

var errorBox;
function showError(title, instructions) {
	if (errorBox) {
		errorBox.$divForm.remove();
	}
	errorBox = new ErrorBox(null, title, instructions);
}

var confirmBox;
function showConfirmation(title, instructions, onconfirmyes) {
	if (confirmBox) {
		confirmBox.$divForm.remove();
	}
	confirmBox = new ConfirmBox(null, title, instructions, onconfirmyes);
}