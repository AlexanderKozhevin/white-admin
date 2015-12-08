angular.module("app").controller "user_setting_Ctrl",  ($scope, $mdSidenav, $translate) ->


  $translate('user.myaccount').then (data) ->
    $scope.title.set(data)

  $mdSidenav("left").close()
