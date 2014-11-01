'use strict';

angular.module('remoteSendkeysApp.directives', [])

  .directive('ngRightClick', function($parse) {
    return function(scope, element, attrs) {
      var fn = $parse(attrs.ngRightClick);
      element.bind('contextmenu', function(event) {
        scope.$apply(function() {
          event.preventDefault();
          fn(scope, {$event:event});
        });
      });
    };
  })

  .directive('flash', function($timeout, $animate) {
    return function(scope, element, attrs) {
      var reset;

      scope.$watch(attrs.flash, function (){

        $animate.removeClass(element, 'ng-hide', 'ng-hide-animate');

        $timeout.cancel(reset);
        reset = $timeout(function() {
          $animate.addClass(element, 'ng-hide', 'ng-hide-animate');
        }, 2000);

      });
    };
  });
