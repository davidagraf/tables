/**
 * Prototype for forms
 */
function FormPrototype(datasource, title) {
  var _this = this;
  
  // initialize common html elements
  var $divForm = $('<div title="' + title + '"></div>');
  this.__defineGetter__("$divForm", function() { return $divForm; });
  var $msgBoxForm = $('<p class="form-msg-box"></p>');
  this.__defineGetter__("$msgBoxForm", function() { return $msgBoxForm; });
  
  $divForm.append($msgBoxForm);
}