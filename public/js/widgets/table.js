/**
 * Creates a table view
 * 
 * @param databinding :
 *            data source bound to this table, {@link TableDataSource}
 * @param rowButtons :
 *            rows to be appended
 * @returns {TableWrapper}
 */
function TableWrapper(datasource, rowButtons) {
	var _this = this;
	this.enableShowRelations = false;

	// initialize
	var $table = $('<table class="ui-widget ui-widget-content"><thead><tr class="ui-widget-header" /></thead><tbody /></table>');
	this.__defineGetter__("$table", function() { return $table; });
	
	// adding table columns
	datasource.resource.fields.forEach(function(field) {
		$("thead tr", $table).append($('<th>' + field.title + '</th>'));
	});
	// adding relations
	datasource.resource.relations.forEach(function(relation) {
		$("thead tr", $table).append($('<th>' + relation.title + '</th>'));
	});
	datasource.registerOnSuccess(onDataSourceChangedHandler);

	// init row buttons
	if (rowButtons) {
		rowButtons.forEach(function(tablebutton) {
			$table.delegate('.' + tablebutton.nameclass, "click", function() {
				var $row = $(this).parent().parent();
				_this.onRowButtonClicked($row, tablebutton);
			});
			$("thead tr", $table).append($('<th></th>'));
		});
	}

	$table.delegate(".btn-show-relation", "click", function() {
		var relation = $(this).data("relation");
		var $row = $(this).parent().parent();
		this
				.onShowResource(datasource.resource.name, $row.attr("id"),
						relation);
	});

	// private functions
	function onDataSourceChangedHandler(eventtype, data, action) {
		console
				.log('Table: table handles data source changed [' + action
						+ ']');

		switch (action) {
		case TableAction.GET:
			// update all rows
			data.forEach(function(rowData) {
				addTableRow(rowData);
			});
			break;
		case TableAction.ADD:
			data.forEach(function(rowData) {
				addTableRow(rowData);
			});
			break;
		case TableAction.UPDATE:
			data.forEach(function(rowData) {
				addTableRow(rowData, {
					replaceRowId : rowData.id
				});
			});
			break;
		case TableAction.DELETE:
			// note: data = rowId
			$('#' + data, $table).remove();
			break;
		}
	}

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
			if (_this.enableShowRelations) {
				var $button = addTableButton($row, new TableButton(
						relation.name, 'btn-show-relation',
						TableButtonIcon.Link));
				$button.data("relation", relation.name);
			} else {
				$row.append($('<td class="' + relation.name + '">'
						+ relation.title + '</td>'));
			}
		});

		if (rowButtons) {
			rowButtons.forEach(function(tablebutton) {
				addTableButton($row, tablebutton);
			});
		}

		$tbody = $('tbody', $table);
		if (!options) {
			$tbody.append($row);
		} else if (options.replaceRowId) {
			var $rowToReplace = $("#" + options.replaceRowId, $tbody);
			if ($rowToReplace.length == 1) {
				$rowToReplace.replaceWith($row);
			} else {
				$tbody.append($row);
			}

		} else if (options.insertAfterRowId) {
			var $anchorRow = $("#" + options.insertAfterRowId, $tbody);
			if ($anchorRow) {
				$row.insertAfter($anchorRow);
			} else {
				$tbody.append($row);
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
	this.reload = function() {
		this.cleanRows();
		datasource.getRows();
	};

	/**
	 * "event" fired when a relation should be shown
	 */
	this.onShowRelation = function(fromResource, fromResourceId, toResource) {
	};

	/**
	 * "event" fired when a row button is clicked
	 */
	this.onRowButtonClicked = function(row, button) {
	};

	/**
	 * Cleans the table rows and the header
	 */
	this.clean = function() {
		$('thead tr', $table).empty();
		this.cleanRows();
	};

	/**
	 * Cleans the table rows
	 */
	this.cleanRows = function() {
		$('tbody', $table).empty();
	};
}
