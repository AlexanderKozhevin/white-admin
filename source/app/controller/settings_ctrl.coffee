angular.module("app").controller "settings_Ctrl",  ($scope, $mdSidenav) ->


  $mdSidenav("left").close()
  console.log 'settings_Ctrl'
