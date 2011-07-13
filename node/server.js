var http = require('http'),
    path = require('path'),
    paperboy = require('node-paperboy/lib/paperboy'),
    dispatcher = require('./dispatcher.js'),

    Db = require('mongodb/lib/mongodb').Db,
    Server = require('mongodb/lib/mongodb').Server;

var WEBROOT = path.join(path.dirname(__filename), '../public'),
    db = null;

function start() {
  function onRequest(request, response) {
    var requestData = '';

    request.on('data', function (chunk) {
      requestData += chunk;
    });

    request.on('end', function (chunk) {
      if (request.method == "GET") {
        paperboy
         .deliver(WEBROOT, request, response)
         .addHeader('Expires', 300)
         .addHeader('X-PaperRoute', 'Node')
         .before(function() {
         })  
         .after(function(statCode) {
         })  
         .error(function(statCode, msg) {
           response.writeHead(statCode, {'Content-Type': 'text/plain'});
           response.end("Error " + statCode);
         })
         .otherwise(function(err) {
           dispatcher.dispatch(request, response, requestData, db);
         });
      }
      else {
        dispatcher.dispatch(request, response, requestData, db);
      }
    });

  }

  server = new Server("127.0.0.1", 27017, {}),
  db = new Db('tables', server);

  db.open(function(err, db) {
    if (err) {
      throw err.message;
    }
    http.createServer(onRequest).listen(8888);
    console.log("Server has started.");
  });
}

exports.start = start;
