angular.module("app").controller "settings_Ctrl",  ($scope, $mdSidenav, $translate) ->


  $translate('setting').then (data) ->
    $scope.page.title = data
    
  $mdSidenav("left").close()
  console.log 'settings_Ctrl'
