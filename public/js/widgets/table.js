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
	this.enableSorting = true;

	// initialize

	var $table = $('<table class="tui"><thead><tr class="header1" /><tr class="header2" /></thead><tbody /></table>');
	this.__defineGetter__("$table", function() {
		return $table;
	});

	var numberOfColumns = Object.keys(datasource.resource.fields).length
			+ Object.keys(datasource.resource.relations).length
			+ rowButtons.length;

	var sorterColumns = {};
	for ( var colIdx = Object.keys(datasource.resource.fields).length; colIdx < numberOfColumns; colIdx++) {
		sorterColumns[colIdx] = {
			sorter : false
		};
	}

	$('.header1', $table).append(
			$('<td colspan="1" class="tableHeader">'
					+ datasource.resource.title + '</td>'));

	$('.header1', $table)
			.append(
					$('<td colspan="'
							+ (numberOfColumns - 1)
							+ '" class="filter">'
							+ 'Filter: <input id="filterBox" value="" style="display: inline;" maxlength="30" size="30" type="text" />'
							+ '<img id="filterClear" src="images/cross.png" title="Hier klicken, um den Filter zu löschen." alt="Filter löschen" /></td>'));

	// adding table columns
	var i = 1;
	$.each(datasource.resource.fields, function(key, field) {
		$th = $('<th><a title="Sortieren">' + field.title + '</a></th>');
		$(".header2", $table).append($th);
		i = i + 1;
	});

	// adding relations
	$.each(datasource.resource.relations, function(key, relation) {
		$(".header2", $table).append($('<th>' + relation.title + '</th>'));
	});
	datasource.registerOnSuccess(onDataSourceChangedHandler);

	// init row buttons
	if (rowButtons) {
		rowButtons.forEach(function(tablebutton) {
			$table.delegate('.' + tablebutton.nameclass, "click", function() {
				var $row = $(this).parent().parent();
				_this.onRowButtonClicked($row, tablebutton);
			});
			$(".header2", $table).append($('<th></th>'));
		});
	}

	$table.delegate(".btn-show-relation", "click", function() {
		var relation = $(this).data("relation");
		var $row = $(this).parent().parent();
		_this.onShowRelation(datasource.resource.name, $row.attr("id"),
				relation);
	});

	// footer (paging)
	$table
			.append($('<tfoot><tr id="pager"><td colspan="'
					+ numberOfColumns
					+ '">'
					+ '<img src="images/first.png" class="first" style="cursor:pointer"/>'
					+ '<img src="images/prev.png" class="prev" style="cursor:pointer"/>'
					+ '<input type="text" class="pagedisplay" style="display:inline; color:#666666" readonly="readonly"/>'
					+ '<img src="images/next.png" class="next" style="cursor:pointer"/>'
					+ '<img src="images/last.png" class="last" style="cursor:pointer"/>&nbsp;&nbsp;&nbsp;&nbsp;'
					+ '<select class="pagesize" style="display:inline; color:#666666">'
					+ '<option value="5">5</option>'
					+ '<option selected="selected" value="10">10</option>'
					+ '<option value="20">20</option>'
					+ '<option  value="40">40</option></select></td>'
					+ '</tr></tfoot>'));

	var isTableExtensionsInitialized = false;

	function initializeOrUpdateTableExtensions() {

		if (isTableExtensionsInitialized) {
			// update table sorter
			$.trigger("appendCache");
			$table.trigger("applyWidgets");
			$table.trigger("update");
		} else {
			// init sorting / paging / filtering
			try {

				$table.tablesorter( {
					debug : false,
					sortList : [ [ 0, 0 ] ],
					widgets : [ 'zebra' ],
					widthFixed : true,
					headers : sorterColumns
				}).tablesorterPager( {
					container : $("#pager", $table),
					positionFixed : false
				});
				isTableExtensionsInitialized = true;
			} catch (e) {
				console.log('table extensions could not be initialized! ' + e)
			}

			// .tablesorterPager( {
			// container : $('#pager', $table),
			// positionFixed : false
			// });
			// .tablesorterPager( {
			// container : $('#pager', $table),
			// positionFixed : false
			// }).tablesorterFilter( {
			// filterContainer : $('#filterBoxOne', $table),
			// filterClearContainer : $('#filterClearOne', $table),
			// filterColumns : filterColumns,
			// filterCaseSensitive : false
			// });

		}

	}

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
		case TableAction.DELETE_RELATION:
		case TableAction.ADD_RELATION:
			// note: data = rowId
			$('#' + data, $table).remove();
			break;
		}

		initializeOrUpdateTableExtensions();
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
		$.each(datasource.resource.fields,
				function(key, field) {
					$row.append($('<td class="' + key + '">' + rowData[key]
							+ '</td>'));
				});

		$.each(datasource.resource.relations, function(key, relation) {
			if (_this.enableShowRelations) {
				var $button = addTableButton($row, new TableButton(key,
						'btn-show-relation', TableButtonIcon.Link));
				$button.data("relation", key);
			} else {
				$row.append($('<td class="' + key + '">' + relation.title
						+ '</td>'));
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

	/**
	 * Returns values of a table row.
	 * 
	 * @id Row id
	 */
	this.rowValues = function($row) {
		$values = {};
		$.each(datasource.resource.fields, function(key, field) {
			$values[key] = jQuery("td." + key, $row).html();
		});
		return $values;
	};
}
