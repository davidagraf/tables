/**
 * Creates a table view
 * 
 * @param tableTitle :
 *            title to be displayed on top of the table (if null, the name of
 *            the bound resource is displayed)
 * @param databinding :
 *            data source bound to this table, {@link TableDataSource}
 * @param rowButtons :
 *            buttons to be appended to rows
 * @param rowtableHeaderButtons :
 *            buttons to be appended to rows
 * @returns {TableWrapper}
 */
function TableWrapper(tableTitle, datasource, rowButtons, tableHeaderButtons) {
	var _this = this;
	this.enableShowRelations = false;
	this.enableSorting = true;
	var showRelations = true;
	var showActions = true;

	// initialize
	var $table = $('<table class="tui"><thead><tr class="header1" /><tr class="header2" /></thead><tbody /></table>');

	this.__defineGetter__("$table", function() {
		return $table;
	});

	this.__defineSetter__("showRelations", function(value) {
		if (value == showRelations) {
			return;
		}

		showRelations = value;

		$('.tui-relation-column', _this.$table).each(function(i) {
			if (showRelations) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	});

	this.__defineGetter__("showRelations", function() {
		return showRelations;
	});

	this.__defineSetter__("showActions", function(value) {
		if (value == showActions) {
			return;
		}

		showActions = value;

		$('.tui-action-column', _this.$table).each(function(i) {
			if (showActions) {
				$(this).show();
			} else {
				$(this).hide();
			}
		});
	});

	var numberOfFields = Object.keys(datasource.resource.fields).length;
	var numberOfRelations = datasource.resource.relations ? Object
			.keys(datasource.resource.relations).length : 0;
	var numberOfColumns = numberOfFields + numberOfRelations
			+ (rowButtons ? 1 : 0);

	var sorterColumns = {};
	var filterColumns = [];
	for ( var colIdx = 0; colIdx < numberOfColumns; colIdx++) {
		if (colIdx >= numberOfFields) {
			sorterColumns[colIdx] = {
				sorter : false
			};
		} else {
			filterColumns.push(colIdx);
		}
	}

	/**
	 * HEADER 1
	 */
	$('.header1', $table)
			.append(
					'<td colspan="'
							+ numberOfFields
							+ '"> <span class="tui-table-title">'
							+ tableTitle
							+ '</span> <span style="margin-left:32px;" id="headerButtons" class="tui-table-header-toolbar" />'
							+ '&nbsp;Filter: <input id="filterBox" value="" style="display: inline;" maxlength="30" size="30" type="text" />'
							+ '<img id="filterClear" src="images/cross.png" title="Hier klicken, um den Filter zu löschen." alt="Filter löschen" /></td>');

	// init header buttons
	if (tableHeaderButtons) {
		$toolbar = $('#headerButtons', $table);
		var count = 0;
		tableHeaderButtons.forEach(function(tablebutton) {
			$table.delegate('.' + tablebutton.nameclass, "click", function() {
				_this.onHeaderButtonClicked(tablebutton);
			});
			var $button = tablebutton.createNewToolbarButton();
			$toolbar.append($button);
			if (count == tableHeaderButtons.length - 1) {
				$button.css('margin-right', '32px');
			}
			count++;
		});
	}

	addRelationOrActionCells($('.header1', $table));

	/**
	 * HEADER 2 (table columns)
	 */
	var i = 1;
	var optimalWidth = Math.floor(100 / numberOfFields) + '%';
	$.each(datasource.resource.fields, function(key, field) {
		$th = $('<th style="width:'
				+ (i == numberOfFields ? '100%' : optimalWidth)
				+ '"><a title="Sortieren">' + field.title + '</a></th>');
		$(".header2", $table).append($th);
		i = i + 1;
	});

	// adding relations
	if (datasource.resource.relations) {
		$
				.each(
						datasource.resource.relations,
						function(key, relation) {
							$(".header2", $table)
									.append(
											$('<th class="tui-relation-column" style="cursor: default;">'
													+ relation.title + '</th>'));
						});
	}

	// init row buttons
	if (rowButtons) {
		$(".header2", $table)
				.append(
						$('<th class="tui-action-column" style="cursor: default;"> </th>'));
		rowButtons.forEach(function(tablebutton) {
			$table.delegate('.' + tablebutton.nameclass, "click", function() {
				var $row = $(this).parent().parent();
				_this.onRowButtonClicked($row, tablebutton);
			});
		});
	}

	// register on data source changed handler
	datasource.registerOnSuccess(onDataSourceChangedHandler);

	// show relation
	$table.delegate(".btn-show-relation", "click", function() {
		var relation = $(this).data("relation");
		var $row = $(this).parent().parent();
		_this.onShowRelation(datasource.resource.name, $row.attr("id"),
				relation);
	});

	/**
	 * FOOTER
	 */
	$table
			.append($('<tfoot><tr id="pager"><td colspan="'
					+ numberOfFields
					+ '" style="padding-left:16px;">'
					+ '<img src="images/first.png" class="first" style="cursor:pointer" valign="bottom" title="Zur ersten Seite"/>'
					+ '<img src="images/prev.png" class="prev" style="cursor:pointer" valign="bottom" title="Zur vorherigen Seite"/>'
					+ '<input type="text" class="pagedisplay" style="display:inline; color:#666666" readonly="readonly"/>'
					+ '<img src="images/next.png" class="next" style="cursor:pointer" valign="bottom" title="Zur nächsten Seite"/>'
					+ '<img src="images/last.png" class="last" style="cursor:pointer" valign="bottom"  title="Zur letzten Seite"/>&nbsp;&nbsp;&nbsp;&nbsp;'
					+ '<select class="pagesize" style="display:inline; color:#666666" title="Setzt die max. Anzahl angezeigter Elemente">'
					+ '<option value="5">5</option>'
					+ '<option selected="selected" value="10">10</option>'
					+ '<option value="20">20</option>'
					+ '<option  value="40">40</option><option  value="60">60</option><option  value="100">100</option></select><span style="margin-left:32px">Anzahl Einträge : <span id="numberOfEntries">Keine</span></span></td>'
					+ '</tr></tfoot>'));

	addRelationOrActionCells($('#pager', $table));

	var isTableExtensionsInitialized = false;

	function initializeOrUpdateTableExtensions() {

		if (isTableExtensionsInitialized) {
			_this.updateExtensions();

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
				}).tablesorterFilter( {
					filterContainer : $('#filterBox', $table),
					filterClearContainer : $('#filterClear', $table),
					filterColumns : filterColumns,
					filterCaseSensitive : false
				});

				isTableExtensionsInitialized = true;
			} catch (e) {
				console.log('table extensions could not be initialized! ' + e);
			}
		}

		var entriesCount = $('tbody tr', $table).length;
		$('#numberOfEntries', $table).text(
				entriesCount == 0 ? "Keine" : entriesCount);
	}

	this.updateExtensions = function() {
		// update table sorter
		$table.trigger("dynamicUpdate");
	};

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

	function addRelationOrActionCells($row) {
		if (numberOfRelations > 0) {
			$row.append($('<td colspan="' + numberOfRelations
					+ '" class="tui-relation-column" />'));
		}

		if (rowButtons) {
			$row.append($('<td class="tui-action-column" />'));
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
		$.each(datasource.resource.fields, function(key, field) {
			$row.append($('<td class="'
					+ key
					+ (field.type != 'textarea' ? " tui-nowrap"
							: "tui-large-cell") + '">'
					+ getFieldCellContent(field, rowData[key]) + '</td>'));
		});

		if (datasource.resource.relations) {
			$.each(datasource.resource.relations, function(key, relation) {
				$tdRelation = $('<td class="' + key
						+ 'tui-relation-column tui-nowrap" />');
				$row.append($tdRelation);
				if (_this.enableShowRelations) {
					var $button = addTableButton($tdRelation, new TableButton(
							firstLetterToUpper(relation.title),
							'btn-show-relation', TableButtonIcon.Link,
							"Zeigt die zugewiesene "
									+ firstLetterToUpper(relation.title)
									+ " an"));
					$button.data("relation", key);
					$button.addClass("tui-relation-button");
				} else {
					$tdRelation.text(relation.title);
				}
				if (!showRelations) {
					$tdRelation.hide();
				}
			});
		}

		if (rowButtons) {
			$td = $('<td class="tui-action-column tui-nowrap" />');
			$row.append($td);
			var i = 0;
			rowButtons.forEach(function(tablebutton) {
				$button = addTableButton($td, tablebutton);
				if (i < rowButtons.length - 1) {
					$button.css('margin-right', '4px');
				}
				i++;
			});

			if (!showActions) {
				$td.hide();
			}
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

	function getFieldCellContent(field, data) {
		if (!data) {
			return '<span class="tui-undefined">&lt;undefiniert&gt;</span>';
		}
		if (field.type == "url") {
			return '<a href="' + data + '" target="_blank">' + data + '</a>';
		}
		if (field.type == "email") {
			return '<a href="mailto:' + data + '">' + data + '</a>';
		}
		return data;
	}

	/**
	 * Creates a table button and appends it as a new cell to the given row
	 * 
	 * @param $container
	 * @param tableButton
	 */
	function addTableButton($container, tableButton) {
		$button = tableButton.createNew();
		$container.append($button);
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
	 * "event" fired when a header button is clicked
	 */
	this.onHeaderButtonClicked = function(button) {
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
			var $cell = $("td." + key, $row);
			if ($('.tui-undefined', $cell).length != 0) {
				$values[key] = '';
			} else {
				$values[key] = $("td." + key, $row).text();
			}
		});
		return $values;
	};
}
