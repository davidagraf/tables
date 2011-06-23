/**
 * Defines a table row button
 * 
 * @param title
 * @param classes
 * @param icon
 *            see {@link TableButton.TableButtonIcon}
 * @returns {TableButton} of type $('<button />')
 */
function TableButton(title, nameclass, icon) {
	this.nameclass = nameclass;
	this.createNew = function() {
		var buttonHtml = '<button class="' + nameclass + ' in-table-button'
				+ ' ui-button' + ' ui-widget' + ' ui-state-default'
				+ ' ui-corner-all' + ' ui-button-text-only"' + ' title="'
				+ title + '"' + ' role="button"' + ' aria-disabled="false">'
				+ '<span class="ui-button-text">' + '<span class="ui-icon '
				+ icon + '">' + '</span>' + '</span>' + '</button>';
		return $(buttonHtml);
	};
}

var TableButtonIcon = {
	Add : "ui-icon-extlink",
	Edit : "ui-icon-wrench",
	Delete : "ui-icon-trash",
	Link : "ui-icon-extlink",
	Generic : "ui-icon-extlink",
	ArrowDown : "ui-icon-arrow-1-s",
	ArrowUp : "ui-icon-arrow-1-n"
};

var DefaultTableButtons = {
	EditButton : new TableButton("edit", "btn-edit-row", TableButtonIcon.Edit),
	DeleteButton : new TableButton("delete", "btn-delete-row",
			TableButtonIcon.Delete),
  RemoveFromRelationButton : new TableButton("remove", "btn-remove-from-relation", 
      TableButtonIcon.ArrowDown),
  AddToRelationButton : new TableButton("add", "btn-add-to-relation",
      TableButtonIcon.ArrowUp)
};
