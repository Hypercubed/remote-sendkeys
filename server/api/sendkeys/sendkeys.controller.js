/* global require */

/**
 * Using Rails-like standard naming convention for endpoints.
 * GET     /things              ->  index
 * POST    /things              ->  create
 * GET     /things/:id          ->  show
 * PUT     /things/:id          ->  update
 * DELETE  /things/:id          ->  destroy
 */

'use strict';

var cp = require('child_process');
var exe = require('path').normalize('./server/vendor/WinSendKeys/WinSendKeys.exe');

exports.index = function(req, res) {

  var windowName = '[ACTIVE]';
  var keyStrokes = req.body.keys || req.query.keys || '';

  if (keyStrokes === '') {
    res.status(400).json({ error: 'message' });
  } else {
    var keys = keyStrokes.replace('^','^^');

    keys = '"'+keys+'"';

    //keys = keys.replace(/{[^}]*}/g, function(r) {  // Add quotes around commands with whitespace
      //return '"'+r+'"';
      //return r.replace(/\s+/g,'\\\ ');
    //});

    var cmd = [exe,'-w',windowName,keys].join(' ');

    cp.exec(cmd, function(err, stdout, stderr) {
      if (err) {
        res.status(400).json({ error: 'message' });
      } else {
        res.json({ success: 'message', received: keyStrokes, encoded: keys });
      }
    });

  }

};
