/**
 * 
 */
$(function() { 
  jQuery.validator.addMethod("version", function(value, element) {
    return this.optional(element) || /^[0-9](\.[a-zA-Z0-9])*$/i.test(value);
  }, "Versions only please. Fromat: [0-9](\\.[a-zA-Z0-9])*"); 
  
  jQuery.validator.addMethod(
      "dateISO8601",
      function(value, element) {
        var check = false;
        var re = /^\d{4}-\d{1,2}-\d{1,2}$/;
        if( re.test(value)){
          var adata = value.split('-');
          var dd = parseInt(adata[2],10);
          var mm = parseInt(adata[1],10);
          var yyyy = parseInt(adata[0],10);
          var xdata = new Date(yyyy,mm-1,dd);
          if ( ( xdata.getFullYear() == yyyy ) && ( xdata.getMonth () == mm - 1 ) && ( xdata.getDate() == dd ) )
            check = true;
          else
            check = false;
        } else
          check = false;
        return this.optional(element) || check;
      }, 
      "Please enter a correct date. Format: yyyy-mm-dd."
    );
  
});