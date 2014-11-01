/* global xit */

'use strict';

describe('Controller: MainCtrl', function () {

  // load the controller's module
  beforeEach(module('remoteSendkeysApp'));

  var MainCtrl,
      scope,
      $httpBackend;

  // Initialize the controller and a mock scope
  beforeEach(inject(function (_$httpBackend_, $controller, $rootScope) {
    $httpBackend = _$httpBackend_;

    scope = $rootScope.$new();
    MainCtrl = $controller('MainCtrl', {
      $scope: scope
    });
  }));

  xit('should', function () {
    //$httpBackend.flush();
  });
});
