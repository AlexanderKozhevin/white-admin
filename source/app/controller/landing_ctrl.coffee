angular.module("app").controller "landing_ctrl",  ($scope, $timeout, $analytics) ->

  $timeout () ->
    $scope.titles = ['Manager','Hacker','Entrepreneur','Creative','Analysist','Developer','Designer']
  , 10

  $analytics.pageTrack('/landing');
  $analytics.eventTrack('eventName');
