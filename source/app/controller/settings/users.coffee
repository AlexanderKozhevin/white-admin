angular.module("app").controller "users_setting_Ctrl",  ($scope, $mdSidenav, $translate, $mdDialog) ->


  $translate('simple.users').then (data) ->
    $scope.title.set(data)

  $mdSidenav("left").close()

  $scope.open_user = () ->
    $mdDialog.show({
      clickOutsideToClose: true,
      scope: $scope,
      preserveScope: true,
      templateUrl: "snippets/users_popup.html",
      controller: "users_popup"
   });
