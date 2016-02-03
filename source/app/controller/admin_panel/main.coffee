angular.module("app").controller "admin_panel_ctrl",  ($scope, $rootScope, $state, main_helper, $timeout) ->


  #
  # Object for managing floating add button
  #
  $scope.new_item =
    show: true
    broadcast: () ->
      $scope.$broadcast('new_item')
    set: (value) ->
      this.show = value


  #
  # Special variable to show data in quick view card
  #
  $scope.worker_preview =
    data: {}
    set: (data) ->
      this.data = data

  #
  # To highlight active ui-router state in tab panel.
  # Because if you reload the page, tab index will be default, not the one you loaded.
  #
  $scope.root_tab_index = main_helper.select_active_tab($state.$current.self.name)

  #
  # Little function to show/hide floating add button corresponding to ui-router state
  #
  $scope.new_item.set(main_helper.is_new($state.$current.self.name))

  #
  # Used to toggle main Jobs/Worker container class - for smooth width changing
  #
  $scope.active_state = $state.$current.self.name

  $rootScope.$on '$stateChangeStart', (event, toState) ->
    $scope.active_state = toState.name
    $scope.new_item.set(main_helper.is_new(toState.name))
