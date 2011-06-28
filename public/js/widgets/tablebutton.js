/**
 * Defines a table row button
 * 
 * @param title
 * @param classes
 * @param icon
 *            see {@link TableButton.TableButtonIcon}
 * @returns {TableButton} of type $('<button />')
 */
function TableButton(title, nameclass, icon, tooltip) {
	var _this = this;
	this.nameclass = nameclass;
	this.doConfirm = false;
	this.confirmTitle;
	this.confirmInstructions;
	this.showText = true;

	if (!tooltip) {
		tooltip = title;
	}

	this.createNew = function() {
		var buttonHtml = '<button class="' + nameclass + '" title="' + tooltip
				+ '"' + '>' + firstLetterToUpper(title) + '</button>';
		var $tableButton = $(buttonHtml);
		$tableButton.button( {
			text : _this.showText,
			icons : {
				primary : icon
			}
		});

		$tableButton.addClass("tui-table-button");

		return $tableButton;
	};

	this.createNewToolbarButton = function() {
		var buttonHtml = '<button class="' + nameclass + '" id="' + nameclass
				+ '" title="' + tooltip + '">' + firstLetterToUpper(title)
				+ '</button>';
		var $toolbarButton = $(buttonHtml);
		$toolbarButton.button( {
			text : _this.showText,
			icons : {
				primary : icon
			}
		});

		$toolbarButton.addClass("tui-button");
		return $toolbarButton;
	};

	this.confirmAction = function(title, instructions) {
		this.doConfirm = true;
		this.confirmTitle = title;
		this.confirmInstructions = instructions;
		return this;
	};
}

var TableButtonIcon = {
	Add : "ui-icon-extlink",
	Edit : "ui-icon-wrench",
	Delete : "ui-icon-trash",
	Link : "ui-icon-extlink",
	Generic : "ui-icon-extlink",
	ArrowDown : "ui-icon-arrow-1-s",
	ArrowUp : "ui-icon-arrow-1-n",
	AddRow : "ui-icon-plus",
	Reload : "ui-icon-refresh"
};

var DefaultTableButtons = {
	EditButton : new TableButton("Editieren", "btn-edit-row",
			TableButtonIcon.Edit, "Eintrag editieren"),
	DeleteButton : new TableButton("Löschen", "btn-delete-row",
			TableButtonIcon.Delete, "Eintrag löschen"),
	RemoveFromRelationButton : new TableButton("Entfernen",
			"btn-remove-from-relation", TableButtonIcon.ArrowDown,
			"Entfernt die Verbindung zwischen den beiden Einträgen."),
	AddToRelationButton : new TableButton("Hinzufügen", "btn-add-to-relation",
			TableButtonIcon.ArrowUp,
			"Stellt eine Verbindung zwischen den beiden Einträgen her"),
	AddButton : new TableButton("Neu", "btn-add", TableButtonIcon.AddRow,
			"Neuen Eintrag erstellen"),
	ReloadButton : new TableButton("Nachladen", "btn-reload",
			TableButtonIcon.Reload, "Lädt den Inhalt der Tabelle neu")
};

DefaultTableButtons.EditButton.showText = false;
DefaultTableButtons.DeleteButton.showText = false;
DefaultTableButtons.RemoveFromRelationButton.showText = false;
DefaultTableButtons.AddToRelationButton.showText = false;
