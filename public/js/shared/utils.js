// Add contains to String
String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

/**
 * Function to add Debug parameter to URI
 */
function appendDebugParam(aOrigUri) {
  var aDebugUri = aOrigUri;
  if (aDebugUri.contains("?")) {
    aDebugUri += "&XDEBUG_SESSION_START=ECLIPSE_DBGP";
  }
  else {
    aDebugUri += "?XDEBUG_SESSION_START=ECLIPSE_DBGP";
  }
  return aDebugUri;
}

function parseUri (str) {
  var o   = parseUri.options,
      m   = o.parser[o.strictMode ? "strict" : "loose"].exec(str),
      uri = {},
      i   = 14;

  while (i--) uri[o.key[i]] = m[i] || "";

  uri[o.q.name] = {};
  uri[o.key[12]].replace(o.q.parser, function ($0, $1, $2) {
      if ($1) uri[o.q.name][$1] = $2;
  });
  
  if (uri.path) {
    // compute path components
    uri.pathComps = uri.path.substring(1).split("/");
  }

  return uri;
};

parseUri.options = {
  strictMode: false,
  key: ["source","protocol","authority","userInfo","user","password","host","port","relative","path","directory","file","query","anchor"],
  q:   {
      name:   "queryKey",
      parser: /(?:^|&)([^&=]*)=?([^&]*)/g
  },
  parser: {
      strict: /^(?:([^:\/?#]+):)?(?:\/\/((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?))?((((?:[^?#\/]*\/)*)([^?#]*))(?:\?([^#]*))?(?:#(.*))?)/,
      loose:  /^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*)(?::([^:@]*))?)?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/
  }
};

function currentPageType() {
    var file_name = window.location.pathname;
    file_name = file_name.substring(file_name.lastIndexOf('/') + 1);
    file_name = file_name.substring(0, file_name.lastIndexOf('.'));
    var type = file_name.substring(0, 1).toUpperCase() + file_name.substring(1) + 'View';
    return type;
}

function createInstance(type)
{
    var initCmd = 'var obj = new ' + type + '();';
    eval(initCmd);
    return obj;
}