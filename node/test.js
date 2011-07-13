var 
  http = require('http'),
  Db = require('../node_modules/mongodb/lib/mongodb').Db,
  Connection = require('../node_modules/mongodb/lib/mongodb').Connection,
  Server = require('../node_modules/mongodb/lib/mongodb').Server,
  BSON = require('../node_modules/mongodb/lib/mongodb').BSON;

/**
 * Testing insertion
 */
/*
  var 
    server = new Server("127.0.0.1", 27017, {}),
    db = new Db('tables', server);
    db.open(function(err, db) {
      db.collection('computer', function(err, collection) {
        collection.insert(
          {
            asset_tag : 'someasset_tag',
            type : 'sometype',
            brand : 'somebrand',
            model : 'somemodel',
            status : 'somestatus',
            name : 'somename',
            serial1 : 'someserial1',
            serial2 : 'someserial2'
          }, 
          function(err, docs) {
            db.close(); 
          }
        );
      });
    });
*/

/**
 * Testing reading
 */
  var 
    server = new Server("127.0.0.1", 27017, {}),
    db = new Db('tables', server);
    db.open(function(err, db) {
      db.collection('computer', function(err, collection) {
        var entries = collection.find();
        entries.toArray(function(err, results){
          console.log(results);
          db.close();
        });
      });
    });
