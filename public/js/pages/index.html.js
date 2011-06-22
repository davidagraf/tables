/**
 * Creates a code behind type for {@link index.html}
 * @param resources see {@link resources.js}
 * @returns {IndexView}
 */
function IndexView(resources) {  
  // dom elements
  var $divButtons = $("#div-btns");
  var $table = $("#table-list");
  var $btnReload = $("#btn-reload");
  var $btnAdd = $("#btn-add");
  var $divAdd = $("#div-add");
  var $formAdd = $("#form-add");
  var $fieldsetAdd = $("#fieldset-add");
  
  // resources
  var resourceToShow = null;
  var resourceUri = null;
  
  // helper vars
  var idToUpdate = -1;
  var $formInputs = {};
  var validator = null;
  
  
  // private functions 
 
  
  
  function showRelation(resourceUri)
  {
    window.location.hash = resourceUri;		
  }
  
  function reloadTable() {
    jQuery("tbody", $table).empty();
    addOrReplaceRows(resourceUri);
  }
  
  function initInputForm() {
    $.each(resourceToShow.fields, function(index, value) {
      var $label = $('<label for="' + value.name + '">' + value.title + '</label>');
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
        $input = $('<input type="text" class="text ' + value.type + '" />');
        break;
      }
      
      $input.addClass("ui-widget-content ui-corner-all");
      $input.attr("id", value.name);
      $input.attr("name", value.name);
    
      switch (value.type) {
      case "date":
        $input.datepicker(
        {
          // hack to disable validation when datepicker is open
          beforeShow: function() {
            $(this).removeClass("dateISO8601");
          },
          onClose: function ()
          {
            $(this).addClass("dateISO8601");
            $(this).valid();
          }
        }
        );
        $input.datepicker("option", "dateFormat", "yy-mm-dd");
        break;
      }
      
      $formInputs[value.name] = $input;
      $fieldsetAdd.append($label);
      $fieldsetAdd.append($input);
    });
    validator =  $formAdd.validate({
      errorClass : "validation-error"
    });
    // overwrite this function because resetting lastElement is missing in the library
    validator.originalResetForm = validator.resetForm;
    validator.resetForm = function() {
      this.originalResetForm();
      this.lastElement = null;
    };
    
    $("input", $fieldsetAdd).keypress(function(event) {
      if (event.which == 13 && !event.altKey && !event.ctrlKey && !event.shiftKey && !event.metaKey) {
        addOrUpdateResource();
      }
    });
  }
  
  function addOrUpdateResource() {
    $.each($formInputs, function(key, value) {
      value.removeClass("ui-state-error");
    });
    
    if (validator.form()) {
      var jsonToSend = {};
      for (key in $formInputs) {
        jsonToSend[key] = $formInputs[key].val();
      }
      var isReplace = idToUpdate >= 0;
      var url = "/" + resourceToShow.name + (isReplace ? "/"+idToUpdate : "");
      $.ajax({
        type: "POST",
        url: url,
        data: $.toJSON(jsonToSend),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (data, textStatus, xhr) {
          addOrReplaceRows((isReplace ? url : xhr.getResponseHeader("Location")), isReplace);
          $divAdd.dialog("close");
        },
        error: function (xhr, textStatus, errorThrown) {
          showFormError(xhr.status + " " + errorThrown);
        }
      });
    }
  };

  // initializes the debug div
  function initDebug() {
	var $table = $(new Table());
	$table.appendTo("#debug");
  };
  
  // events
  $btnReload
    .button()
    .click(function() { 
      reloadTable();
  });
  
  $divAdd.dialog({
    autoOpen: false,
    height: 550,
    width:500,
    modal: true,
    buttons: {
      OK: addOrUpdateResource,
      Cancel: function() {
        $(this).dialog("close");
      }
    },
    open: function() {
      $.each($formInputs, function(key, value) {
        if (idToUpdate < 0) {
          value.val("");
        }
        value.removeClass("ui-state-error");
      });
      validator.resetForm();
    }
  });
  
  $btnAdd
    .button()
    .click(function() {
      idToUpdate = -1;
      $divAdd.dialog("open");
    });
  
  
  // public functions
  /**
   * Initializes this page
   */
  this.init = function(uri) {
	// init vars	
	var pos = (uri.pathComps.length - 1) / 2;
	resourceToShow = resources[uri.pathComps[pos]];
    
    if (!resourceToShow) {
      return false;
    }
    
    resourceUri = uri.path;
    
    // show buttons
    $btnAdd.removeClass('hidden');
    $btnReload.removeClass('hidden');
    
    // adding table columns
    resourceToShow.fields.forEach(function(field){
      $("thead tr", $table).append($('<th>' + field.title + '</th>'));
    });
    // adding relations
    resourceToShow.relations.forEach(function(relation) {
      $("thead tr", $table).append($('<th>' + relation.title + '</th>'));
    });
    // for delete and edit button
    $("thead tr", $table).append($('<th></th><th></th>'));
       
    initInputForm();
    
    // show content
    addOrReplaceRows(resourceUri);

    // highlight state
	$("#nav-tabs a[href=#" + newHash.replace(/\//g, "\\/") + "]").addClass("ui-state-active");
	
    // init DEBUG area
    initDebug();
    
    return true;
  };
  
  /**
   * Cleans this page
   */
  this.clean = function() {
    // empty dom
    $btnAdd.addClass('hidden');
    $btnReload.addClass('hidden');
    $("thead tr", $table).empty();
    $("tbody", $table).empty();
    $msgBoxTable.text("");
    $msgBoxForm.text("");
    $fieldsetAdd.empty();
    $("#debug").empty();
	$("#nav-tabs a").removeClass("ui-state-active");
    
    // emtpy vars
    resourceToShow = null;
    resourceUri = null;
    $formInputs = {};
    validator = null;
  };
}


