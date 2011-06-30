/**
 * Create confirm dialog.
 * 
 * @param datasource
 * @param title
 * @param instructions
 * @returns {ConfirmBox}
 */
function ConfirmBox(datasource, title, instructions, onconfirmyes) {
	this.base = FormPrototype;
	this.base(datasource, "Bestätigen - " + title);

	var _this = this;

	// initialize
	_this.$divForm
			.append($('<table style="width:100%"><tr><td rowspan="2"><img src="images/warning.png" title="Warnung" alt="!" style="margin-right:16px" /></td><td><span class="tui-error-title">'
					+ title
					+ '</span></td></tr><tr><td><span class="tui-error-instructions">'
					+ instructions + '</span></td></tr></table>'));

	_this.$divForm.dialog( {
		autoOpen : true,
		height : 'auto',
		width : '300',
		modal : true,
		buttons : {
			Ja : function() {
				_this.$divForm.dialog("close");
				if (onconfirmyes) {
					onconfirmyes();
				}
			},
			Nein : function() {
				_this.$divForm.dialog("close");
			}
		},
		open : function() {
		}
	});

}

ConfirmBox.prototype = new FormPrototype;