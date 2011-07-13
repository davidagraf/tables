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

function doGet(request, response, db) {
  var pathComps = pathComponents(request.url);
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

function createRelationCollName(resource1, resource2) {
  return ( resource1 < resource2 
         ? resource1 + "_" + resource2
         : resource2 + "_" + resource1 );
}

function doPost(request, response, requestData, db) {
  var pathComps = pathComponents(request.url);
  switch(pathComps.length) {
  case 1:
    var json = parseJSON(response, requestData);
    if (json == null)
      return;
    var host = request.headers.host;
    db.collection(pathComps[0], function(err, collection) {
      collection.insert(
        json,
        function(err, doc) {
          response.setHeader("Location", "http://" + host + "/" + pathComps[0] + "/" + doc[0]['_id']);
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
    var lCollName = createRelationCollName(pathComps[0], pathComps[2]);
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
  var pathComps = pathComponents(request.url);
  switch(pathComps.length) {
  case 2:
    var resource = resources[pathComps[0]];
    var relations = Object.keys(resource);
    var length = relations.length;
    var index = 0;
    var query = {};
    query[pathComps[0]] = pathComps[1];
    var func = function(relations, length, index) {
      if (index < length) {
        var lCollName = createRelationCollName(pathComps[0], relations[length]);
        db.collection(lCollName,  function(err, collection) {
          collection.remove(query, function(err) {
            func(relations, length, index+1);
          });
        });
      }
      else {
        db.collection(pathComps[0], function(err, collection) {
          collection.remove({_id : ObjectID(pathComps[1])}, function(err) {
            response.end();
          });
        });
      }
    };

    func(relations, length, index);

    break;
  case 4:
    var lCollName = createRelationCollName(pathComps[0], pathComps[2]);
    var query = {};
    query[pathComps[0]] = pathComps[1];
    query[pathComps[2]] = pathComps[3];
    db.collection(lCollName,  function(err, collection) {
      collection.remove(query, function(err) {
        response.end();
      });
    });
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
  default:
    response.writeHead(501, {});
  }
}

exports.dispatch = dispatch;
