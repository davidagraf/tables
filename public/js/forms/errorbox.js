/**
 * Create error dialog.
 * 
 * @param datasource
 * @param title
 * @param instructions
 * @returns {ErrorBox}
 */
function ErrorBox(datasource, title, instructions) {
	this.base = FormPrototype;
	this.base(datasource, "Fehler - " + title);

	var _this = this;

	// initialize
	_this.$divForm
			.append($('<table style="width:100%"><tr><td rowspan="2"><img src="images/error.png" title="Fehler" alt="X" style="margin-right:16px"/></td><td><span class="tui-error-title">'
					+ title
					+ '</span></td></tr><tr><td><span class="tui-error-instructions">'
					+ instructions
					+ '</span></td></tr></table>'));
	
	_this.$divForm.dialog( {
		autoOpen : true,
		height : 'auto',
		width : '300',
		modal : true,
		buttons : {
			OK : function() {
				_this.$divForm.dialog("close");
			}
		},
		open : function() {
		}
	});

}

ErrorBox.prototype = new FormPrototype;