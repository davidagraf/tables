var $msgBoxTable = $(".table-msg-box");
var $msgBoxForm = $(".form-msg-box");

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