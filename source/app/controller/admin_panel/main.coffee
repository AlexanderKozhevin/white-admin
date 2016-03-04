angular.module("app").controller "AdminPanelCtrl",  ($scope, $rootScope, $state, Restangular, MainHelper, $timeout, tmhDynamicLocale, $translate, localStorageService) ->



  #
  # Object for managing floating add button
  #
  $scope.new_item =
    show: true
    broadcast: () ->
      $scope.$broadcast('new_item')
    set: (value) ->
      this.show = value

  $scope.exit = () ->
    Restangular.one('auth', 'logout').customPOST()
    localStorageService.set('auth', false)
    $state.go('login')

  $scope.toolbar_menu =
    element: null
    open: ($mdOpenMenu, ev) ->
      this.element = ev
      $mdOpenMenu(ev);

  $scope.language_menu =
    element: null
    open: ($mdOpenMenu, ev) ->
      this.element = ev
      $mdOpenMenu(ev);
    set_language: (language) ->
      $scope.table_label.set()
      switch language
        when 'ru'
          tmhDynamicLocale.set('ru-ru')
          $translate.use('ru');
        when 'en'
          tmhDynamicLocale.set('en-us')
          $translate.use('en');
      $state.reload()



  $scope.table_label =
    data: null
    set: () ->
      switch $translate.proposedLanguage()
        when 'en'
          $scope.table_label.data =
            page: "page"
            rowsPerPage: "rows per pagee"
            of: "of"
        when 'ru'
          $scope.table_label.data =
            page: "страница "
            rowsPerPage: "кол-во на стр."
            of: "из"



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
  $scope.root_tab_index = MainHelper.select_active_tab($state.$current.self.name)

  #
  # Little function to show/hide floating add button corresponding to ui-router state
  #
  $scope.new_item.set(MainHelper.is_new($state.$current.self.name))

  #
  # Used to toggle main Jobs/Worker container class - for smooth width changing
  #
  $scope.active_state = $state.$current.self.name

  $rootScope.$on '$stateChangeStart', (event, toState) ->
    $scope.active_state = toState.name
    $scope.new_item.set(MainHelper.is_new(toState.name))


  $scope.table_label.set()
