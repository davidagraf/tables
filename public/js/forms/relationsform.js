function RelationsForm(datasource, id, relation) {
  this.base = FormPrototype;
  this.base(datasource, "Relation " + "'" + relation + "'");
  
  var _this = this;
  
  function onRelationRemovedHandler(eventtype, data, action) {
    
  }
  
  function onRelationAddedHandler(eventtype, data, action) {
   
  }
  
  function onRemoveRelationClickedHandler($row, button) {
    inRelationDatasource.removeRelation($row.attr("id"), datasource.resource, id);
  }
  
  function onAddRelationClickedHandler($row, button) {
    outRelationDatasource.addRelation($row.attr("id"), datasource.resource, id);
  }
  
  // init table that contains the items which are related
  var inRelationDatasource = new TableDataSource("/" + relation + "/" + datasource.resource.name + "==" + id, 
                                                 globalResources[relation]);
  inRelationDatasource.registerOnSuccess(onRelationRemovedHandler);
  var inRelationTable = new TableWrapper(inRelationDatasource, [DefaultTableButtons.RemoveFromRelationButton]);
  inRelationTable.onRowButtonClicked = onRemoveRelationClickedHandler;
  inRelationDatasource.getRows();
  _this.$divForm.append(inRelationTable.$table);
  
  // int table that contains the items wich are not related
  var outRelationDatasource = new TableDataSource("/" + relation + "/" + datasource.resource.name + "!=" + id, 
                                                  globalResources[relation]);
  outRelationDatasource.registerOnSuccess(onRelationAddedHandler);
  var outRelationTable = new TableWrapper(outRelationDatasource, [DefaultTableButtons.AddToRelationButton]);
  outRelationTable.onRowButtonClicked = onAddRelationClickedHandler;
  outRelationDatasource.getRows();
  _this.$divForm.append(outRelationTable.$table);
  
  _this.$divForm.dialog( {
    autoOpen : true,
    height : 700,
    width : 1000,
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