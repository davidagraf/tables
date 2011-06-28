/**
 * Creates a code behind type for {@link data.html}
 * 
 * @returns {DataView}
 */
function DataView() {
	// dom elements
	var $divButtons = $("#div-btns");
	var $btnReload = $("#btn-reload");
	var $btnAdd = $("#btn-add");

	// items
	var tableWrapper;
	var editForm;
	var relationsForm;

	// resources
	var datasource;

	// private functions
	function onShowRelationHandler($row, id, relation) {
		if (relationsForm) {
			relationsForm.$divForm.remove();
		}

		var label = firstLetterToUpper(datasource.resource.title) + ' '
				+ getShortLabel($('#' + id, tableWrapper.$table), datasource);
		relationsForm = new RelationsForm(datasource, id, relation, label);
	}

	function editRow(idToUpdate, valuesToUpdate) {
		if (editForm) {
			editForm.$divForm.remove();
		}
		editForm = new EditForm(datasource, idToUpdate, valuesToUpdate,
				idToUpdate == -1);
	}

	function onRowButtonClickedHandler($row, button) {
		switch (button) {
		case DefaultTableButtons.EditButton:
			valuesToUpdate = tableWrapper.rowValues($row);
			editRow($row.attr("id"), valuesToUpdate);
			break;
		case DefaultTableButtons.DeleteButton:
			datasource.deleteRow($row.attr('id'));
			break;
		}
	}

	function onHeaderButtonClickedHandler(button) {
		switch (button) {
		case DefaultTableButtons.AddButton:
			editRow(-1);
			break;
		case DefaultTableButtons.ReloadButton:
			reloadTable();
			break;
		}
	}

	function reloadTable() {
		tableWrapper.reload();
	}

	// public functions
	/**
	 * Initializes this page
	 */
	this.init = function(uri) {
		// init vars
		var resourceName = uri.pathComps[uri.pathComps.length - 1];
		if (uri.pathComps.length % 2 == 0) {
			resourceName = uri.pathComps[uri.pathComps.length - 2];
		}

		var resource = globalResources[resourceName];
		if (!resource) {
			return false;
		}

		datasource = new TableDataSource(uri.path, resource);

		// init table
		var rowButtons = [ DefaultTableButtons.EditButton,
				DefaultTableButtons.DeleteButton ];
		var headerButtons = [ DefaultTableButtons.AddButton,
				DefaultTableButtons.ReloadButton ];
		tableWrapper = new TableWrapper(
				firstLetterToUpper(datasource.resource.title), datasource,
				rowButtons, headerButtons);
		tableWrapper.onShowRelation = onShowRelationHandler;
		tableWrapper.onRowButtonClicked = onRowButtonClickedHandler;
		tableWrapper.onHeaderButtonClicked = onHeaderButtonClickedHandler;
		tableWrapper.enableShowRelations = true;
		$('#div-data-table').append(tableWrapper.$table);
		datasource.getRows();
		resourceUri = uri.path;

		// highlight state
		$("#nav-tabs a[href=#" + newHash.replace(/\//g, "\\/") + "]").addClass(
				"ui-state-active");

		return true;
	};

	/**
	 * Cleans this page
	 */
	this.clean = function() {
		// empty dom
		$msgBoxTable.text("");
		$msgBoxForm.text("");
		if (editForm) {
			editForm.$divForm.remove();
		}
		if (relationsForm) {
			relationsForm.$divForm.remove();
		}
		$("#nav-tabs a").removeClass("ui-state-active");
		if (tableWrapper) {
			tableWrapper.$table.remove();
		}

		// emtpy vars
		resourceUri = null;
		tableWrapper = null;
		editForm = null;
		relationsFrom = null;
		datasource = null;
	};
}
