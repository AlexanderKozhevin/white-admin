angular.module("app").controller "users_popup",  ($scope, $mdSidenav, $state, $translate, $mdDialog) ->


  $scope.actions =
    save: () ->
      $mdDialog.hide();
    hide: () ->
      $mdDialog.hide();
