/**
 * Creates a table view
 * 
 * @param databinding :
 *            data source bound to this table, {@link TableDataSource}
 * @returns {Table}
 */
function Table(datasource) {
	this.enableEditRow = false;
	this.enableDeleteRow = false;
	this.enableShowRelations = false;
	var $this = this;

	// init header
	// adding table columns
	datasource.resource.fields.forEach(function(field) {
		$("thead tr", $this).append($('<th>' + field.title + '</th>'));
	});
	// adding relations
	datasource.resource.relations.forEach(function(relation) {
		$("thead tr", $this).append($('<th>' + relation.title + '</th>'));
	});
	// for delete and edit button
	$("thead tr", $this).append($('<th></th><th></th>'));

	datasource.onSuccess = onDataSourceChangedHandler;

	this.delegate(".btn-delete-row", "click", function() {
		var $row = $(this).parent().parent();
		this.onDeleteRow($row);
	});

	this.delegate(".btn-edit-row", "click", function() {
		var $row = $(this).parent().parent();
		this.onEditRow($row);
	});

	this.delegate(".btn-show-relation", "click", function() {
		var relation = $(this).data("relation");
		var $row = $(this).parent().parent();
		var resourceUri = "/" + resourceToShow.name + "/" + $row.attr("id")
				+ "/" + relation;
		this.onShowResource(resourceUri);
	});

	// private functions
	function onDataSourceChangedHandler(data, action) {
		console.log('table handles data source changed [' + action + ']');

		switch (action) {
		case TableAction.GET:
			// update rows
			data.forEach(function(rowData) {
				$('tbody', $this).empty();
				addTableRow(rowData);
			});
			break;
		}

	}

	/**
	 * Handles data updates
	 * 
	 * @param data
	 */
	function onTableDataUpdated(data) {
		var tableStr;
		data
				.forEach(function(rowData) {
					var $row = generateTableRow(rowData);
					var $tbody = $("tbody", $table);
					var $rowToReplace = {};
					if (replaceRow
							&& ($rowToReplace = $("#" + rowData.id, $tbody)).length == 1) {
						$rowToReplace.replaceWith($row);
					} else {
						$tbody.append($row);
					}
				});
	}

	/**
	 * Adds a row
	 * 
	 * @param rowData
	 */
	function addTableRow(rowData) {
		var $row = $('<tr id="' + rowData.id + '" style="nowrap"></tr>');
		datasource.resource.fields.forEach(function(field) {
			$row.append($('<td class="' + field.name + '">'
					+ rowData[field.name] + '</td>'));
		});

		datasource.resource.relations.forEach(function(relation) {
			if ($this.enableShowRelations) {
				var $button = addTableButton(relation.name, 'ui-icon-extlink',
						'btn-show-relation');
				$button.data("relation", relation.name);
			} else {
				$row.append($('<td class="' + relation.name + '">'
						+ relation.title + '</td>'));
			}
		});

		if (this.enableEditRow) {
			addTableButton($row, "edit", "ui-icon-wrench", "btn-edit-row");
		}

		if (this.enableDeleteRow) {
			addTableButton($row, "remove", "ui-icon-trash", "btn-delete-row");
		}

		$('tbody', $this).append($row);
	}

	/**
	 * Creates a table button and appends it as a new cell to the given row
	 * 
	 * @param $row
	 * @param title
	 * @param icon
	 * @param additionalClass
	 */
	function addTableButton($row, title, icon, additionalClass) {
		var $td = $('<td></td>');
		var buttonHtml = '<button class="' + additionalClass
				+ ' in-table-button' + ' ui-button' + ' ui-widget'
				+ ' ui-state-default' + ' ui-corner-all'
				+ ' ui-button-text-only"' + ' title="' + title + '"'
				+ ' role="button"' + ' aria-disabled="false">'
				+ '<span class="ui-button-text">' + '<span class="ui-icon '
				+ icon + '">' + '</span>' + '</span>' + '</button>';
		$button = $(buttonHtml);
		$td.append($button);
		$row.append($td);
		return $button;
	}

	// public functions / events
	// "event" fired when a relation should be shown
	this.onShowRelation = function(row, relation) {
	};

	this.clean = function() {
		$('thead tr', $this).empty();
		$('tbody', $this).empty();
	};
}

// base type is $(table)
Table.prototype = $('<table class="ui-widget ui-widget-content">'
		+ '<thead><tr class="ui-widget-header" /></thead><tbody />'
		+ '</table>');
