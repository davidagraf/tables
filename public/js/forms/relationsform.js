function RelationsForm(datasource, id, relation) {
  this.base = FormPrototype;
  this.base(datasource, "Relation " + "'" + relation + "'");
  
  var _this = this;
  
  // initialize
  var $form = $('<form></form>');
  var $fieldset = $('<fieldset></fieldset>');
  
  _this.$divForm.append($form);
  
  function onDataSourceChangedHandler(eventtype, data, action) {
    switch (action) {
    case TableAction.UPDATE:
    case TableAction.DELETE:
      break;
    }
  }
  datasource.registerOnSuccess(onDataSourceChangedHandler);
  
  
  _this.$divForm.dialog( {
    autoOpen : true,
    height : 800,
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