'use strict';

angular.module('keySpy', [])

  .factory('keySpy', function keypress(){
    var keysByCode = {
      8: 'backspace',
      9: 'tab',
      13: 'enter',

      16: 'shift',
      17: 'ctrl',
      18: 'alt',

      27: 'esc',
      32: 'space',
      33: 'pageup',
      34: 'pagedown',
      35: 'end',
      36: 'home',
      37: 'left',
      38: 'up',
      39: 'right',
      40: 'down',
      45: 'insert',
      46: 'delete'
    };

    return function getEventKey(e) {
      var modifiers = [];

      if (e.shiftKey && e.keyCode !== 16) {  modifiers.push('shift'); }
      if (e.altKey && e.keyCode !== 18) { modifiers.push('alt'); }
      if (e.ctrlKey && e.keyCode !== 17) { modifiers.push('ctrl'); }
      if (e.metaKey) { modifiers.push('meta');}

      var char = e.keyCode;
      if (e.type === 'keypress' && e.keyCode > 32) {
        char = String.fromCharCode(char);
        if (!e.shiftKey) {
          char = char.toLowerCase();
        }
      }

      char = keysByCode[e.keyCode] || char;
      modifiers.push(char);

      return modifiers.join('-');
    };
  })

  .directive('keySpy', function(keySpy, $log) {

    return {
      restrict: 'A',
      link: function(scope,element,attrs) {

        var on = attrs.keySpy || 'keyup keydown keypress';
        element.bind(on, function(e) {
          $log.debug(e.type+':', keySpy(e), e.keyCode);
        });

      }
    };

  });
