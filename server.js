'use strict';

var express = require('express'),
	bodyParser = require('body-parser'),
	methodOverride = require('method-override'),
    coffeescript = require("coffee-script/register"),
    mongoose = require('mongoose'),
    app = express();
/**
 * Main application file
 */

// get all data/stuff of the body (POST) parameters
app.use(bodyParser.json()); // parse application/json 
app.use(bodyParser.json({ type: 'application/vnd.api+json' })); // parse application/vnd.api+json as json
app.use(bodyParser.urlencoded({ extended: true })); // parse application/x-www-form-urlencoded

app.use(methodOverride('X-HTTP-Method-Override')); // override with the X-HTTP-Method-Override header in the request. simulate DELETE/PUT
app.use(express.static(__dirname + '/app')); // set the static files location /public/img will be /img for users


var config = require('./lib/config/config');
// var db = mongoose.connect(config.mongo.uri, config.mongo.options);
var db = require('./lib/config/db');
var port = process.env.PORT || 8080; // set our port

// Bootstrap models
// var modelsPath = path.join(__dirname, 'lib/models');
var requireFiles = function (path) {
    fs.readdirSync(path).forEach(function (file) {
        if(fs.lstatSync(path + '/' + file).isDirectory()) {
            requireFiles(path + '/' + file);
        } else if (/(.*)\.(js$|coffee$)/.test(file)) {
            require(path + '/' + file);
        }
    });
}
// requireFiles(modelsPath)

// Setup Express
require('./lib/routes')(app);

app.listen(port);
console.log('Server listening on port ' + port); 

// Start server
// var server = app.listen(config.port, config.ip, function () {
//   console.log('Express server listening on %s:%d, in %s mode', config.ip, config.port, app.get('env'));
// });

// Expose app
exports = module.exports = app;
