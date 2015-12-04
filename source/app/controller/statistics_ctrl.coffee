angular.module("app").controller "statistics_Ctrl",  ($scope, $mdSidenav, $translate) ->


  $translate('stat').then (data) ->
    $scope.page.title = data

  $mdSidenav("left").close()
  console.log 'statistics_Ctrl'
