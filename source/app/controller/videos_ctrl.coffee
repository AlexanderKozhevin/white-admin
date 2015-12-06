angular.module("app").controller "videos_Ctrl",  ($scope, $mdSidenav, $state, $window, $timeout) ->

  $scope.pre_select = false

  if $state.params.id
    current_videos = _.find($scope.video_menu.children, {'id': parseInt($state.params.id)})
    if current_videos
      $scope.title.set('Videos - ' + current_videos.name)

  $scope.page =
    view_type: 'block'
    toggle_view: () ->
      if this.view_type == 'block'
        this.view_type = 'list'
      else
        this.view_type = 'block'
    is_select_all: false
    select_all: () ->
      this.is_select_all = !this.is_select_all
      if this.is_select_all
        $scope.many = _.map($scope.many, (obj) -> obj.select = true; return obj)
        $scope.pre_select = true
      else
        $scope.many = _.map($scope.many, (obj) -> obj.select = false; return obj)
        $scope.pre_select = false

  $scope.sorter =
    list: [
      {name: "By Name", id: 0},
      {name: "By Size", id: 1},
      {name: "By Time", id: 2}
    ]
  $scope.sorter.model = JSON.stringify($scope.sorter.list[0])


  $scope.item_menu =
    open: ($mdOpenMenu, ev) ->
      this.element = ev
      $mdOpenMenu(ev);

  $timeout () ->
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
  ,500


  $scope.is_data_loaded = () ->
    if angular.isUndefined($scope.many)
      return false
    else
      return true


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
