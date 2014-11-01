'use strict';

angular.module('remoteSendkeysApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'ngAnimate',
  'ui.scrollfix',
  'LocalStorageModule',
  'ui.sortable',
  'ui.keypress',
  'oitozero.ngSweetAlert',
  'focusOn',
  'keySpy',
  'remoteSendkeysApp.directives'
])

  .config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .otherwise({
        redirectTo: '/'
      });

    $locationProvider
      .html5Mode(false)
      .hashPrefix('!');

  })

  .config(function (localStorageServiceProvider) {
    localStorageServiceProvider
      .setPrefix('open-remote');
  })

  .config(function ($logProvider) {
    $logProvider
      .debugEnabled(false);
  });
