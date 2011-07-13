var path = require('path'),
    url = require('url'),
    fs = require('fs'),

    Connection = require('mongodb/lib/mongodb').Connection,
    ObjectID = require('mongodb/lib/mongodb/bson/objectid').ObjectID

    resources = JSON.parse(fs.readFileSync(path.dirname(__filename) + '/../public/data/resources.json'));

function pathComponents(requestUrl) {
  var parsedUrl = url.parse(requestUrl, true);
  var comps = parsedUrl.pathname.split('/');
  return comps.splice(1, comps.length-1);
}

function checkResource(name, response) {
  if (!resources[name]) {
    response.writeHead(400, {});
    response.write('Resource "' + name + '" not available.\n');
    return false;
  }
  else {
    return true;
  }
}

function doGet(request, response, db) {
  var pathComps = pathComponents(request.url);
  if (!checkResource(pathComps[0], response)) {
    return;
  }
  switch(pathComps.length) {
  case 1:
    db.collection(pathComps[0], function(err, collection) {
      collection.find({}, function(err, cursor) {
        cursor.toArray(function(err, items) {          
          // rename _id to id
          items.forEach(function(item) {
            item['id'] = item['_id'];
            delete item['_id'];
          });
          var jsonStr = JSON.stringify(items);
          response.write(jsonStr);
          response.end();
        });
      });
    });
    break;
  case 2:
    db.collection(pathComps[0], function(err, collection) {
      collection.find({_id : ObjectID(pathComps[1])}, function(err, cursor) {
        cursor.toArray(function(err, items) {          
          // rename _id to id
          items.forEach(function(item) {
            item['id'] = item['_id'];
            delete item['_id'];
          });
          var jsonStr = JSON.stringify(items);
          response.write(jsonStr);
          response.end();
        });
      });
    });
    break;
    break;
  default:
    response.writeHead(501, {});
    response.end();
  }
}

function parseJSON(response, requestData) {
  var parsed = null;
  try {
    parsed = JSON.parse(requestData);
  }
  catch (e) {
    if (!(e instanceof SyntaxError)) {
      // other exception, rethrow
      throw e;
    }
    response.writeHead(400, {});
    response.write("Parsing received JSON failed. Message: " + e.message);
    response.end();
  }
  return parsed;
}

function doPost(request, response, requestData, db) {
  var pathComps = pathComponents(request.url);
  switch(pathComps.length) {
  case 1:
    var json = parseJSON(response, requestData);
    if (json == null)
      return;
    db.collection(pathComps[0], function(err, collection) {
      collection.insert(
        json,
        function(err, docs) {
          response.end();
        }
      );
    });
    break;
  case 2:
    var json = parseJSON(response, requestData);
    if (json == null)
      return;
    db.collection(pathComps[0], function(err, collection) {
      collection.update(
        {_id : ObjectID(pathComps[1])},
        json,
        {},
        function(err, docs) {
          response.end();
        }
      );
    });
    break;
  case 4:
    var lCollName = ( pathComps[0] < pathComps[2] 
                    ? pathComps[0] + "_" + pathComps[2]
                    : pathComps[2] + "_" + pathComps[0] );
    // TODO
    // check if resources exist and check if entry in relation db already exists
    db.collection(lCollName, function(err, collection) {
      var entry = {};
      entry[pathComps[0]] = pathComps[1];
      entry[pathComps[2]] = pathComps[3];
      collection.insert(
        entry,
        function(err, docs) {
          response.end();
        }
      );
    });
  default: 
    response.writeHead(501, {});
    response.end();
  }
}

function doDelete(request, response, db) {
  switch(pathComps.length) {
  case 2:
    break;
  case 4:
    break;
  default:
    response.writeHead(501, {});
    response.end();
  } 
}


function dispatch(request, response, requestData, db) {
  switch(request.method) {
  case "GET":
    doGet(request, response, db);
    break;
  case "POST":
    doPost(request, response, requestData, db);
    break;
  case "DELETE":
    doDelete(request, response, db);
    break;
    break;
  default:
    response.writeHead(501, {});
  }
}

exports.dispatch = dispatch;
