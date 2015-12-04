angular.module("app").controller "main_Ctrl",  ($scope, $mdSidenav, $state) ->

  $scope.page =
    title: "Polymath"
  $scope.toggle = () ->
    $mdSidenav('left').toggle();

  $scope.video_menu =
    expand: false
    children: [
      {name: "All videos", id: 0},
      {name: "Deleted", id: 1},
      {name: "Processing", id: 2},
      {name: "MTV", id: 3},
      {name: "Science", id: 4},
      {name: "Hacking", id: 5},
      {name: "DIY", id: 6},
      {name: "Moto", id: 7},
      {name: "NASA", id: 8},
      {name: "Farming", id: 9},
      {name: "Workout", id: 10}
    ]
