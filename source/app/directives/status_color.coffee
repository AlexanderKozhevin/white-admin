angular.module("app").directive "statusColor", ($timeout, $compile) ->
  {
    restrict: 'A',
    scope: false,
    link: (scope, elm, attrs) ->

      variable = 'socket_data.' + attrs.statusColor
      scope.$watch variable, () ->
        console.log
        # Remove all the classes
        elm.removeClass('green');
        elm.removeClass('yellow');
        elm.removeClass('red');


        # And then - set the current one)

        value = scope.socket_data[attrs.statusColor]

        if value<25
          elm.addClass('green');

        if (value>=25) and (value<=75)
          elm.addClass('yellow');

        if value>75
          elm.addClass('red');


  }
