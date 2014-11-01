'use strict';

angular.module('remoteSendkeysApp')
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'app/main/main.html',
        controller: 'MainCtrl as main',
        reloadOnSearch: false
      });
  });
