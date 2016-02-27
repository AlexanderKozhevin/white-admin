angular.module("app").controller "LandingCtrl",  ($scope, $timeout, Analytics, genius) ->


  console.log genius(2)

  Analytics.trackPage('/profile');
  $timeout () ->
    $scope.titles = ['Manager','Hacker','Entrepreneur','Creative','Analysist','Developer','Designer']
  , 10
