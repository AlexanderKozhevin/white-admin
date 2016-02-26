angular.module("app").controller "landing_ctrl",  ($scope, $timeout, Analytics) ->


  Analytics.trackPage('/profile');
  $timeout () ->
    $scope.titles = ['Manager','Hacker','Entrepreneur','Creative','Analysist','Developer','Designer']
  , 10
