function EditForm(datasource, idToUpdate, inputValues) {
	this.base = FormPrototype;
	this.base(datasource, "Add / Update");
	
  var _this = this;
  
  function onDataSourceChangedHandler(eventtype, data, action) {
    switch (action) {
    case TableAction.UPDATE:
    case TableAction.ADD:
      _this.$divForm.dialog("close");
      break;
    }
  }
  datasource.registerOnSuccess(onDataSourceChangedHandler);
  
  function addOrUpdateResource() {
    $.each(_this.$formInputs, function(key, value) {
      value.removeClass("ui-state-error");
    });

    if (_this.validator.form()) {
      var jsonToSend = {};
      for (key in _this.$formInputs) {
        jsonToSend[key] = _this.$formInputs[key].val();
      }

      if (idToUpdate >= 0) {
        datasource.updateRow(idToUpdate, jsonToSend);
      } else {
        datasource.addRow(jsonToSend);
      }
    }
  }

  $.each(datasource.resource.fields, function(index, value) {
    var $label = $('<label for="' + value.name + '">' 
                 +   value.title
                 + '</label>');
    var $input;

    switch (value.type) {
    case undefined:
    case "text":
      $input = $('<input type="text" class="text" />');
      break;
    case "date":
      $input = $('<input type="text" class="text dateISO8601" />');
      $input.mask("9999-99-99");
      break;
    case "textarea":
      $input = $('<textarea class="textarea" />');
      break;
    default:
      $input = $('<input type="text" class="text ' + value.type
          + '" />');
      break;
    }
    
    if (idToUpdate >= 0) {
      $input.val(inputValues[value.name]); 
    }

    $input.addClass("ui-widget-content ui-corner-all");
    $input.attr("id", value.name);
    $input.attr("name", value.name);

    switch (value.type) {
    case "date":
      $input.datepicker( {
        // hack to disable validation when datepicker is open
        beforeShow : function() {
          $(this).removeClass("dateISO8601");
        },
        onClose : function() {
          $(this).addClass("dateISO8601");
          $(this).valid();
        }
      });
      $input.datepicker("option", "dateFormat", "yy-mm-dd");
      break;
    }

    _this.$formInputs[value.name] = $input;
    _this.$fieldset.append($label);
    _this.$fieldset.append($input);
  });
  _this.validator = _this.$form.validate( {
    errorClass : "validation-error"
  });
  // overwrite this function because resetting lastElement is missing in
  // the library
  _this.validator.originalResetForm = _this.validator.resetForm;
  _this.validator.resetForm = function() {
    this.originalResetForm();
    this.lastElement = null;
  };

  _this.$fieldset.delegate("input", "keypress",
    function(event) {
      if (event.which == 13 && !event.altKey && !event.ctrlKey
          && !event.shiftKey && !event.metaKey) {
        addOrUpdateResource();
      }
    });
  
  _this.$divForm.dialog( {
    autoOpen : true,
    height : 550,
    width : 500,
    modal : true,
    buttons : {
      OK : addOrUpdateResource,
      Cancel : function() {
        _this.$divForm.dialog("close");
      }
    },
    open : function() {
      $.each(_this.$formInputs, function(key, value) {
        if (idToUpdate < 0) {
          value.val("");
        }
        value.removeClass("ui-state-error");
      });
      _this.validator.resetForm();
    }
  });
  
}

EditForm.prototype = new FormPrototype;