/**
 * Prototype for forms
 */
function FormPrototype(datasource, title) {
  var _this = this;
  
  //initialize common html elements
  var $divForm = $('<div id="div-add" title="' + title + '"></div>');
  this.__defineGetter__("$divForm", function() { return $divForm; });
  var $msgBoxForm = $('<p class="form-msg-box"></p>');
  this.__defineGetter__("$msgBoxForm", function() { return $msgBoxForm; });
  var $form = $('<form id="form-add"></form>');
  this.__defineGetter__("$form", function() { return $form; });
  var $fieldset = $('<fieldset id="fieldset-add"></fieldset>');
  this.__defineGetter__("$fieldset", function() { return $fieldset; });
  
  $form.append($fieldset);
  $divForm.append($msgBoxForm);
  $divForm.append($form);
  
  //common variables
  this.$formInputs = {};
  this.validator = null;
}