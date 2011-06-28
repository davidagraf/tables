function RelationsForm(datasource, id, relation, shortlabel) {
	this.base = FormPrototype;
	this.base(datasource, firstLetterToUpper(relation) + ' von ' + shortlabel);

	var _this = this;
	var editMode = false;
	
	function onRelationRemovedHandler(eventtype, data, action) {
		if (action == TableAction.DELETE_RELATION) {
			outRelationDatasource.getRowsByUrl("/" + relation + "/" + data);
		}
	}

	function onRelationAddedHandler(eventtype, data, action) {
		if (action == TableAction.ADD_RELATION) {
			inRelationDatasource.getRowsByUrl("/" + relation + "/" + data);
		}
	}

	function onRemoveRelationClickedHandler($row, button) {
		inRelationDatasource.removeRelation($row.attr("id"),
				datasource.resource, id);
	}

	function onAddRelationClickedHandler($row, button) {
		outRelationDatasource.addRelation($row.attr("id"), datasource.resource,
				id);
	}

	function toggleEditMode() {
		editMode = !editMode;
		$('.ui-button-text', this).text(
				editMode ? "Editieren beenden" : "Editieren");
		$(this).attr(
				'title',
				editMode ? "Beendet den Editiermodus"
						: "Startet den Editiermodus");

		if (editMode) {
			outRelationTable.$table.show();
			outRelationTable.updateExtensions();
		} else {
			outRelationTable.$table.hide();
		}

		inRelationTable.showActions = editMode;

		// reposition
		_this.$divForm.dialog( {
			position : 'center'
		});
	}

	// init table that contains the items which are related
	var inRelationDatasource = new TableDataSource("/" + relation + "/"
			+ datasource.resource.name + "==" + id, globalResources[relation]);
	inRelationDatasource.registerOnSuccess(onRelationRemovedHandler);
	var inRelationTable = new TableWrapper('Zugewiesene '
			+ firstLetterToUpper(inRelationDatasource.resource.title),
			inRelationDatasource,
			[ DefaultTableButtons.RemoveFromRelationButton ]);
	inRelationTable.showRelations = false;
	inRelationTable.showActions = editMode;
	inRelationTable.onRowButtonClicked = onRemoveRelationClickedHandler;
	inRelationDatasource.getRows();
	var $inDiv = $('<div class="tables-table"></div>');
	$inDiv.append(inRelationTable.$table);
	_this.$divForm.append($inDiv);


	
	$collapseEditBtn = $('<button id="collapseEditBtn">Editieren</button>');
	$collapseEditBtn.button( {
		text : true
	});
	$collapseEditBtn.css('margin-top', '11px');
	$collapseEditBtn.click(toggleEditMode);
	$separatorDiv = $('<div class="tui-rel-separator" />');
	$separatorDiv.append($collapseEditBtn);
	_this.$divForm.append($separatorDiv);

	// int table that contains the items wich are not related
	var outRelationDatasource = new TableDataSource("/" + relation + "/"
			+ datasource.resource.name + "!=" + id, globalResources[relation]);
	outRelationDatasource.registerOnSuccess(onRelationAddedHandler);
	var outRelationTable = new TableWrapper('Verfügbare '
			+ firstLetterToUpper(outRelationDatasource.resource.title),
			outRelationDatasource, [ DefaultTableButtons.AddToRelationButton ]);
	outRelationTable.showRelations = false;
	outRelationTable.onRowButtonClicked = onAddRelationClickedHandler;
	outRelationDatasource.getRows();
	outRelationTable.$table.hide();
	var $outDiv = $('<div class="tables-table"></div>');
	$outDiv.append(outRelationTable.$table);
	_this.$divForm.append($outDiv);

	_this.$divForm.dialog( {
		autoOpen : true,
		height : 'auto',
		width : '90%',
		modal : true,
		buttons : {
			Close : function() {
				_this.$divForm.dialog("close");
			}
		},
		open : function() {

		}
	});
}

RelationsForm.prototype = new FormPrototype;