/**
 * Resources configuration
 * Needs to be imported in the html page first to set globalResources before doing anything.
 */
var globalResources = {};

$.ajax( {
  url : "/public/data/resources.json",
  dataType : 'json',
  async : false,
  success : function(data, textStatus, xhr) {
    globalResources = data;
  },
  error : function(xhr, textStatus, errorThrown) {
    console.log("Reading resources json file didnt work: " + textStatus);
  }
});