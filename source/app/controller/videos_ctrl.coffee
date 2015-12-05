angular.module("app").controller "videos_Ctrl",  ($scope, $mdSidenav, $state, $window) ->

  $scope.pre_select = false

  if $state.params.id
    current_videos = _.find($scope.video_menu.children, {'id': parseInt($state.params.id)})
    if current_videos
      $scope.page.title = 'Videos - ' + current_videos.name


  $scope.many = [
    {name: 'money making 1'},
    {name: 'money making 2'},
    {name: 'money making 3'},
    {name: 'money making 4'},
    {name: 'money making 5'},
    {name: 'money making 6'},
    {name: 'money making 7'},
    {name: 'money making 8'},
    {name: 'money making 9'},
    {name: 'money making 10'},
    {name: 'money making 11'}
  ]
  $mdSidenav("left").close()
  console.log 'videos_Ctrl'

  $scope.select_item = (item) ->
    item.select = !item.select
    elements = _.where($scope.many, {select: true})
    if elements.length > 0
      $scope.pre_select = true
    else
      $scope.pre_select = false


  $scope.small_cols_calc = () ->
    if $window.innerWidth < 350
      return 1
    else
      return 2
