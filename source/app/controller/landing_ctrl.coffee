angular.module("app").controller "landing_ctrl",  ($scope, $timeout) ->

  $timeout () ->
    $scope.titles = ['Manager','Hacker','Entrepreneur','Creative','Analysist','Developer','Designer']
  , 10
