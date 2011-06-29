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

	function initDataTablesMenu(globalResources) {
		var $menu = $('#data-tables-menu');

		// create group map
		var groups = {};
		$.each(globalResources, function(key, value) {
			var group = value.group ? value.group : 'Allgemein';
			if (!groups[group]) {
				groups[group] = {};
			}
			groups[group][key] = value;
		});

		$menuTable = $('<table class="tui-menu-table" />');
		$menu.append($menuTable);
		$trLabel = $('<tr />');
		$menuTable.append($trLabel);
		$trMenu = $('<tr />');
		$menuTable.append($trMenu);

		$.each(groups, function(group, groupButtons) {

			$trLabel
					.append($('<td class="tui-group-label" colspan="'
							+ Object.keys(groupButtons).length + '">' + group
							+ '</td>'));
			$.each(groupButtons, function(key, value) {
				var $menuItem = $('<button id="menu_' + key + '">'
						+ value.title + '</button>');
				$menuItem.button( {
					text : true
				});
				$menuItem.click(function() {
					window.location.hash = '#/' + key;
					$(this).addClass('ui-state-active');
				});

				$menuItem.addClass("tui-button");
				$tdMenuItem = $('<td />');
				$tdMenuItem.append($menuItem);
				$trMenu.append($tdMenuItem);
			});
		});
	}

	// public functions
	/**
	 * Initializes this page
	 */
	this.init = function(uri) {

		initDataTablesMenu(globalResources);

		if (!uri)
			return;

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
		$("#data-tables-menu #menu_" + resource.name).css( {
			'color' : '#cc0000',
			'border-color' : '#ccbbbb'
		});

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
		$("#data-tables-menu button").remove();
		$("#data-tables-menu .tui-group").remove();
		$("#data-tables-menu .tui-menu-table").remove();
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
