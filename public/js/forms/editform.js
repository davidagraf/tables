/**
 * Create dialog to edit a row.
 * @param datasource
 * @param idToUpdate
 * @param inputValues
 * @returns {EditForm}
 */
function EditForm(datasource, idToUpdate, inputValues) {
	this.base = FormPrototype;
	this.base(datasource, "Add / Update");
	
  var _this = this;
  
  // initialize
  var $form = $('<form></form>');
  var $fieldset = $('<fieldset></fieldset>');
  
  $form.append($fieldset);
  _this.$divForm.append($form);
  
  // helper variables
  var $formInputs = {};
  var validator = null;
  
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
    $.each($formInputs, function(key, value) {
      value.removeClass("ui-state-error");
    });

    if (validator.form()) {
      var jsonToSend = {};
      for (key in $formInputs) {
        jsonToSend[key] = $formInputs[key].val();
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

    $formInputs[value.name] = $input;
    $fieldset.append($label);
    $fieldset.append($input);
  });
  validator = $form.validate( {
    errorClass : "validation-error"
  });
  // overwrite this function because resetting lastElement is missing in
  // the library
  validator.originalResetForm = validator.resetForm;
  validator.resetForm = function() {
    this.originalResetForm();
    this.lastElement = null;
  };

  $fieldset.delegate("input", "keypress",
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
      $.each($formInputs, function(key, value) {
        if (idToUpdate < 0) {
          value.val("");
        }
        value.removeClass("ui-state-error");
      });
      validator.resetForm();
    }
  });
  
}

EditForm.prototype = new FormPrototype;