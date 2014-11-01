/**
 * Main application file
 */

'use strict';

// Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV || 'development';

var express = require('express');
var config = require('./config/environment');
// Setup server
var app = express();
var server = require('http').createServer(app);
require('./config/express')(app);
require('./routes')(app);

var ip = require('ip').address();
var os = require('os').platform();

if (os !== 'win32') {
  // Start server
  console.log('Currently only compaitble with windows');
} else {
  // Start server
  server.listen(config.port, config.ip, function () {
    console.log('Express server listening on %s:%d, in %s mode', ip, config.port, app.get('env'));
  });
}

// Expose app
exports = module.exports = app;
