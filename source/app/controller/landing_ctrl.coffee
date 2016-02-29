angular.module("app").controller "LandingCtrl",  ($scope, $timeout, genius) ->


  console.log genius(2)

  $timeout () ->
    $scope.titles = ['Manager','Hacker','Entrepreneur','Creative','Analysist','Developer','Designer']
  , 10
