/**
 * Creates a code behind type for {@link index.html}
 * 
 * @param resources
 *            see {@link resources.js}
 * @returns {IndexView}
 */
function IndexView() {
	// dom elements
	var $divButtons = $("#div-btns");
	var $btnReload = $("#btn-reload");
	var $btnAdd = $("#btn-add");
	var $divAdd = $("#div-add");

	// items
	var tableWrapper;
	var editForm;

	// resources
	var datasource;

	// private functions
	function onShowRelationHandler(row, relation) {
		// TODO
		// window.location.hash = resourceUri;
	}

	function onRowButtonClickedHandler($row, button) {
		switch (button) {
		case DefaultTableButtons.EditButton:
			datasource.resource.fields.forEach(function(field) {
				var name = field.name;
				_this.$formInputs[name].val(jQuery("td." + name, $row).html());
			});
			idToUpdate = $row.attr("id");
			$divAdd.dialog("open");
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
	  if (editForm) {
	    editForm.$divForm.remove();
	  }
	  editForm = new EditForm(datasource, -1);
	  $('div-form').append(editForm.$divForm);
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
		$("#nav-tabs a").removeClass("ui-state-active");
		if (tableWrapper) {
			tableWrapper.$table.remove();
		}

		// emtpy vars
		resourceUri = null;
		tableWrapper = null;
		editForm = null;
		datasource = null;
	};
}
