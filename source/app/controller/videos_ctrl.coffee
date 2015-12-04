angular.module("app").controller "videos_Ctrl",  ($scope, $mdSidenav) ->

  $mdSidenav("left").close()
  console.log 'videos_Ctrl'
