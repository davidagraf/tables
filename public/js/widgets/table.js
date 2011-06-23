/**
 * Creates a table view
 * 
 * @param databinding :
 *            data source bound to this table, {@link TableDataSource}
 * @returns {Table}
 */
function Table(datasource) {
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
			// update all rows
			$('tbody', $this).empty();
			data.forEach(function(rowData) {
				addTableRow(rowData);
			});
			break;
		case TableAction.ADD:
			var tableStr;
//			data
//					.forEach(function(rowData) {
//						var $row = generateTableRow(rowData);
//						var $tbody = $("tbody", $table);
//						var $rowToReplace = {};
//						if (replaceRow
//								&& ($rowToReplace = $("#" + rowData.id, $tbody)).length == 1) {
//							$rowToReplace.replaceWith($row);
//						} else {
//							$tbody.append($row);
//						}
//					});
			break;
		}
	}

	// set default buttons edit & delete
	var rowButtons = [ DefaultTableButtons.EditButton,
			DefaultTableButtons.DeleteButton ];

	/**
	 * Creates and adds a row to the table body
	 * 
	 * @param rowData
	 * @param options
	 *            defining how and where the given row should be inserted
	 *            available options are (mutually excluding): insertAfterRowId
	 *            (given row should be inserted after this row) / replaceRowId
	 *            (row to be replaced)
	 */
	function addTableRow(rowData, options) {
		var $row = $('<tr id="' + rowData.id + '"></tr>');
		datasource.resource.fields.forEach(function(field) {
			$row.append($('<td class="' + field.name + '">'
					+ rowData[field.name] + '</td>'));
		});

		datasource.resource.relations.forEach(function(relation) {
			if ($this.enableShowRelations) {
				var $button = addTableButton($row, new TableButton(
						relation.name, 'btn-show-relation',
						TableButtonIcon.Link));
				$button.data("relation", relation.name);
			} else {
				$row.append($('<td class="' + relation.name + '">'
						+ relation.title + '</td>'));
			}
		});

		rowButtons.forEach(function(tablebutton) {
			addTableButton($row, tablebutton);
		});

		$tbody = $('tbody', $this);
		if (!options) {
			$tbody.append($row);
		} else if (options.replaceRowId) {
			var $rowToReplace = $("#" + options.replaceRowId, $tbody);
			if ($rowToReplace.length == 1) {
				$rowToReplace.replaceWith($row);
			}
		} else if (options.insertAfterRowId) {
			var $anchorRow = $("#" + options.insertAfterRowId, $tbody);
			if ($anchorRow) {
				$row.insertAfter($anchorRow);
			}
		}

		return $row;
	}

	/**
	 * Creates a table button and appends it as a new cell to the given row
	 * 
	 * @param $row
	 * @param tableButton
	 */
	function addTableButton($row, tableButton) {
		var $td = $('<td></td>');
		$button = tableButton.createNew();
		$td.append($button);
		$row.append($td);
		return $button;
	}

	// public functions / events
	/**
	 * Appends the given table buttons to each row
	 */
	this.appendTableButton = function(tablebutton) {
		rowButtons.push(tablebutton);
	};

	/**
	 * "event" fired when a relation should be shown
	 */
	this.onShowRelation = function(row, relation) {
	};

	/**
	 * Cleans the table contents
	 */
	this.clean = function() {
		$('thead tr', $this).empty();
		$('tbody', $this).empty();
	};
}

// base type is $(table)
Table.prototype = $('<table class="ui-widget ui-widget-content">'
		+ '<thead><tr class="ui-widget-header" /></thead><tbody />'
		+ '</table>');
