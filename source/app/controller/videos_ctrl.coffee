angular.module("app").controller "videos_Ctrl",  ($scope, $mdSidenav, $state) ->

  if $state.params.id
    current_videos = _.find($scope.video_menu.children, {'id': parseInt($state.params.id)})
    if current_videos
      $scope.page.title = 'Videos - ' + current_videos.name

  $mdSidenav("left").close()
  console.log 'videos_Ctrl'
