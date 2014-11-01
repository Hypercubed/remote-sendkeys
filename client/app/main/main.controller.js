/* global angular */

'use strict';

angular.module('remoteSendkeysApp')
  .controller('MainCtrl', function ($scope, $http, $log, $timeout, $resource, $location, keysArrayStorage, SweetAlert, focus, localStorageService) {

    var DEBUG = false;
    var MOCK_SEND = false;

    var main = this;

    main.input = '';
    main.isEditing = false;
    main.isWaiting = false;

    main.keysArray = keysArrayStorage.get();

    main.config = {};
    main.config.host = [$location.protocol(),'//'+$location.host(),$location.port()].join(':')+'/';
    main.config.confirmDelete = true;

    localStorageService.bind($scope, 'main.config', main.config);

    main.clear = function() {
      main.input = '';
      if (DEBUG) { focus('input'); }
    };

    main.sendKeys = function(keys) {
      if (!keys || keys.length < 1) { return; }

      var msg = 'sending: '+keys;

      if (MOCK_SEND) {
        $log.debug('mock', msg);
        $scope.form.input.$message = 'mock '+msg;
        main.isWaiting = true;
        $timeout(function() {
          $log.debug('mock received:',{received: keys});
          $scope.form.input.$message = 'mock server received: '+keys;
          main.isWaiting = false;
        }, 3000);
      } else {
        $log.debug(msg);
        $scope.form.input.$message = msg;
        main.isWaiting = true;
        $http.post(main.config.host+'api/sendkeys', {keys: keys}, {cache: false})
          .success(function(res) {
            $log.debug('received: ', res);
            $scope.form.input.$message = 'server received: '+res.received;
            main.isWaiting = false;
          }).error(function(res, status, headers, config) {
            main.isWaiting = false;
            $log.warn(res, status, headers, config);
            $scope.form.input.$message = status+' error';
            msg += (res) ? ': '+res.message : '';
          });
      }

    };

    main.saveKeys = function(keys) {
      if (!keys) { return; }
      main.keysArray.unshift({ keys: keys });
      keysArrayStorage.put(main.keysArray);
    };

    main.deleteKeys = function(keys) {
      var index = main.keysArray.indexOf(keys);

      var cb = function() {
        main.keysArray.splice(index,1);
        keysArrayStorage.put(main.keysArray);
      };

      if(!main.config.confirmDelete) {
        cb();
      } else {
        SweetAlert.swal({
          title: 'Are you sure?',
          text: '',
          type: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#DD6B55',
          confirmButtonText: 'Yes, delete it.',
          cancelButtonText: 'No, cancel.',
          closeOnConfirm: true,
          closeOnCancel: true
        }, function(isConfirm) {
          if (isConfirm) {
            $scope.$apply(cb);
          }
        });
      }

    };

    main.doneEditingKeys = function(keys) {

      function clean(keys) {
        if (keys.title) {
          keys.title = keys.title.trim();
        }
        if (keys.title === '' || keys.title === keys.keys) {
          delete keys.title;
        }
        delete keys.$$edit;
      }

      if (keys) {
        clean(keys);
      } else {
        main.keysArray.forEach(clean);
      }

      keysArrayStorage.put(main.keysArray);
    };

  })

  .factory('keysArrayStorage', function ($window,$location,localStorageService) {

    //var version = 0;

    function loadHash() {

      var s = $location.hash();
      if (!s) { return null; }

      s = $window.Base64.decode(s);

      return JSON.parse(s);
    }

    function saveHash(value) {
      var s = '';
      if (value.length > 0) {
        s = angular.toJson(value, false);
        s = $window.Base64.encodeURI(s);
      }
      $location.hash(s).replace();
    }

    return {
      get: function () {
        var r = loadHash() || localStorageService.get('keys') || [];
        saveHash(r);
        return r;
      },

      put: function (keysList) {
        saveHash(keysList);
        localStorageService.set('keys', keysList);
      }
    };
  });
