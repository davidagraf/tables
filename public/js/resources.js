/**
 * Resources configuration
 */
var globalResources = {};

$.ajax( {
  url : "/public/js/resources.json",
  dataType : 'json',
  success : function(data, textStatus, xhr) {
    globalResources = data;
  },
  error : function(xhr, textStatus, errorThrown) {
    console.log("Reading resources json file didnt work: " + textStatus);
  }
});