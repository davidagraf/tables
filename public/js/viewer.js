/**
 * Table viewer
 */

function Viewer(resources) {  
  // dom elements
  var $msgBoxTable = $(".table-msg-box");
  var $msgBoxForm = $(".form-msg-box");
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
  function generateTableBtn(icon, additionalClass) {
    var str = '<button class="'
             +           additionalClass
             +         ' in-table-button'
             +         ' ui-button'
             +         ' ui-widget'
             +         ' ui-state-default'
             +         ' ui-corner-all'
             +         ' ui-button-text-only"'
             +       ' title=".' + icon + '"'
             +       ' role="button"'
             +       ' aria-disabled="false">'
             +   '<span class="ui-button-text">'
             +     '<span class="ui-icon ' + icon + '">'
             +     '</span>'
             +   '</span>'
             +   '</button>';
    return $(str);
  }
  
  function generateTableRow(rowData) {
    var $row = $('<tr id="' + rowData.id + '"></tr>');;
    resourceToShow.fields.forEach(function(field){
      $row.append($('<td class="' + field.name + '">' + rowData[field.name] + '</td>'));
    });
    resourceToShow.relations.forEach(function(relation){
      var $button = generateTableBtn('ui-icon-link', 'btn-show-relation');
      $button.data("relation", relation.name);
      var $td = $('<td></td>');
      $td.append($button);
      $row.append($td);
    });
    [["ui-icon-trash","btn-delete-row"], ["ui-icon-pencil", "btn-edit-row"]].forEach(function(item) {
      var $td = $('<td></td>');
      $td.append(generateTableBtn(item[0], item[1]));
      $row.append($td);
    });
    //$row.append('<td><button class="in-table-button btn-delete-row" title=".ui-icon-trash"><span class="ui-icon ui-icon-trash"></span></button></td>');
    //$row.append('<td><button class="in-table-button btn-edit-row" title=".ui-icon-pencil"><span class="ui-icon ui-icon-pencil"></span></button></td>');
    
    return $row;
  }
  
  function showTableError(text) {
    $msgBoxTable
      .text(text)
      .addClass("ui-state-error");
    setTimeout(function() {
      $msgBoxTable.removeClass("ui-state-error", 1500);
    }, 500);
  }
  
  function showFormError(text) {
    $msgBoxForm
      .text(text)
      .addClass("ui-state-error");
    setTimeout(function() {
      $msgBoxForm.removeClass("ui-state-error", 1500);
    }, 500);
  }
  
  function deleteRow($row) {
    var id = $row.attr("id");
    $.ajax({
      type: "DELETE",
      url: "/" + resourceToShow.name + "/" + id,
      success: function (data, textStatus, xhr) {
        $row.remove();
      },
      error: function (xhr, textStatus, errorThrown) {
        showFormError(xhr.status + " " + errorThrown);
      }
    });
  }
  
  function addOrReplaceRows(resourceUrl, replaceRow) {    
    $.ajax({
      url: resourceUrl,
      dataType: 'json',
      success: function(data, textStatus, xHr) {
        var tableStr;
        data.forEach(function(rowData){
          var $row = generateTableRow(rowData);
          var $tbody = jQuery("tbody", $table);
          var $rowToReplace = {};
          if (replaceRow && ($rowToReplace = jQuery("#"+rowData.id, $tbody)).length == 1) {
            $rowToReplace.replaceWith($row);
          }
          else {
            $tbody.append($row);
          }
        });
      },
      error: function (xhr, textStatus, errorThrown) {
        showTableError(xhr.status + " " + errorThrown);
      }
    });
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
    
    jQuery("input", $fieldsetAdd).keypress(function(event) {
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
  
  function editRow($row) {
    resourceToShow.fields.forEach(function(field){
      var name = field.name;
      $formInputs[name].val(jQuery("td."+name, $row).html());
    });
    
    idToUpdate = $row.attr("id");
    $divAdd.dialog("open");
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
  
  $table.delegate(".btn-delete-row", "click", function() {
    var $row = $(this).parent().parent();
    deleteRow($row);
  });
  
  $table.delegate(".btn-edit-row", "click", function() {
    var $row = $(this).parent().parent();
    editRow($row);
  });
  
  $table.delegate(".btn-show-relation", "click", function() {
    var relation = $(this).data("relation");
    var $row = $(this).parent().parent();
    var resourceUri = "/" + resourceToShow.name + "/" + $row.attr("id") + "/" + relation;
    window.location.hash = resourceUri;
  });
  
  // public functions
  this.init = function(uri) {    
    // init vars
    switch(uri.pathComps.length) {
    case 4:
    case 3:
      resourceToShow = resources[uri.pathComps[2]];
      break;
    case 2:
    case 1:
      resourceToShow = resources[uri.pathComps[0]];
      break;
    default:
    }
    
    if (!resourceToShow) {
      return false;
    }
    resourceUri = uri.path;
    
    // show btns
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
    
    return true;
  };
  
  this.clean = function() {
    // empty dom
    $btnAdd.addClass('hidden');
    $btnReload.addClass('hidden');
    jQuery("thead tr", $table).empty();
    jQuery("tbody", $table).empty();
    $msgBoxTable.text("");
    $msgBoxForm.text("");
    $fieldsetAdd.empty();
    
    // emtpy vars
    resourceToShow = null;
    resourceUri = null;
    $formInputs = {};
    validator = null;
  };
}

$(function() {
  var viewer = new Viewer(armyResources);
  
  $(window).bind('hashchange', function() {
    newHash = window.location.hash.substring(1);
    
    viewer.clean();
    
    if (newHash) {
      var uri = parseUri(newHash);
      if (!viewer.init(uri)) {
        // something is wrong, do something
      }
    }
    
    $("#nav-tabs a").removeClass("ui-state-active");
    $("#nav-tabs a[href=#" + newHash.replace(/\//g, "\\/") + "]").addClass("ui-state-active");
  });
  
  $(window).trigger('hashchange');
});