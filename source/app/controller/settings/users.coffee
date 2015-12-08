angular.module("app").controller "users_setting_Ctrl",  ($scope, $mdSidenav, $translate) ->


  $translate('simple.users').then (data) ->
    $scope.title.set(data)

  $mdSidenav("left").close()
