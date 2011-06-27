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
	  relationsForm = new RelationsForm(datasource, id, relation);
	}
	
	function editRow(idToUpdate, valuesToUpdate) {
      if (editForm) {
        editForm.$divForm.remove();
      }
      editForm = new EditForm(datasource, idToUpdate, valuesToUpdate);
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

	function reloadTable() {
		tableWrapper.reload();
	}

	// events
	$btnReload.button().click(function() {
		reloadTable();
	});

	$btnAdd.button().click(function() {
	   editRow(-1);
	});

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

		// show buttons
		$btnAdd.removeClass('hidden');
		$btnReload.removeClass('hidden');

		// init table
		tableWrapper = new TableWrapper(datasource, [
				DefaultTableButtons.EditButton,
				DefaultTableButtons.DeleteButton ]);
		tableWrapper.onShowRelation = onShowRelationHandler;
		tableWrapper.onRowButtonClicked = onRowButtonClickedHandler;
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
		$btnAdd.addClass('hidden');
		$btnReload.addClass('hidden');
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
