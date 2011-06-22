/**
 * Creates a table view
 * @param databinding : data source bound to this table, {@link TableDataSource}
 * @returns {Table}
 */
function Table(datasource) {
	this.enableEditRow = false;
	this.enableDeleteRow = false;
	this.enableShowRelations = false;
	
	// init header
	this.append($('<thead />'));
	$('thead', this).append($('<tr class="ui-widget-header" />'));
	
	// adding table columns
	datasource.resource.fields.forEach(function(field){
      $("thead tr", this).append($('<th>' + field.title + '</th>'));
    });
    // adding relations
	datasource.resource.relations.forEach(function(relation) {
      $("thead tr", this).append($('<th>' + relation.title + '</th>'));
    });
    // for delete and edit button
    $("thead tr", this).append($('<th></th><th></th>'));
	
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
		var resourceUri = "/" + resourceToShow.name + "/" + $row.attr("id") + "/" + relation;
		this.onShowResource(resourceUri);
	});

	// private functions
	function addTableButton($cell, title, icon, additionalClass) {
		var str = '<button class="' + additionalClass + ' in-table-button'
				+ ' ui-button' + ' ui-widget' + ' ui-state-default'
				+ ' ui-corner-all' + ' ui-button-text-only"' + ' title="'
				+ title + '"' + ' role="button"' + ' aria-disabled="false">'
				+ '<span class="ui-button-text">' + '<span class="ui-icon '
				+ icon + '">' + '</span>' + '</span>' + '</button>';
		$cell.append($(str));
	}

	/**
	 * Handles data updates
	 * @param data
	 */
	function onTableDataUpdated(data) {
		var tableStr;
		data.forEach(function(rowData) {
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
	 * Adds a 
	 * @param rowData
	 */
	function addTableRow(rowData) {
		var $row = $('<tr id="' + rowData.id + '"></tr>');
		resourceToShow.fields.forEach(function(field) {
			$row.append($('<td class="' + field.name + '">'
					+ rowData[field.name] + '</td>'));
		});
		resourceToShow.relations.forEach(function(relation) {
			var $button = generateTableBtn(relation.name, 'ui-icon-extlink',
					'btn-show-relation');
			$button.data("relation", relation.name);
			var $td = $('<td></td>');
			$td.append($button);
			$row.append($td);
		});

		[ [ "remove", "ui-icon-trash", "btn-delete-row" ],
				[ "edit", "ui-icon-wrench", "btn-edit-row" ] ]
				.forEach(function(item) {
					var $td = $('<td></td>');
					$td.append(generateTableBtn(item[0], item[1], item[2]));
					$row.append($td);
				});

		$(this).append($row);
	};

	// public functions / events
	// "event" fired when a relation should be shown 
	this.onShowRelation = function(row, relation) {
	};	
}

// base type is $(table)
Table.prototype = $('<table class="ui-widget ui-widget-content" />');