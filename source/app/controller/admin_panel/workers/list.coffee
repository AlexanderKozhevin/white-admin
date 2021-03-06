angular.module("app").controller "WorkersListCtrl",  ($scope, $timeout , $q, Restangular, MainHelper, $mdToast, clipboard, $mdDialog, $mdSidenav, $translate, $mixpanel) ->


  templates = Restangular.one('jobs')
  workers = Restangular.all('workers')
  events = Restangular.all('events')

  $scope.events =
    list: []
    selected: null

  $scope.selected = []

  $scope.jobs =
    list:[]
    selected: null

  $scope.request_params =
    limit: 5
    index_page: 1
    max: 1
    sort: 'name'


  $scope.any_job_selected = () ->
    if $scope.jobs.selected
      if $scope.jobs.selected.id
        return false
      else
        return true
    else
      return true

  $scope.is_any_event = () ->
    index = $scope.events.list.indexOf($scope.events.selected)
    if index < 1
      return true
    else
      return false

  $scope.ext_search =
    params: []
    allowed_types: ['string', 'text', 'number', 'date', 'select', 'multiple select']
    compare_types: ['number', 'date'] # Types for which '>', '=', '<' operators could be applied
    compare_values: [{value: '='},{value: '>'},{value: '<'}]
    clear: () ->
      for i in this.params
        i.value = null
    hide_dialog: () ->
      $mdDialog.hide();
    toggle_compare: (item) ->
      index = this.compare_values.indexOf(item.compare_value)
      index++
      index = 0 if index == 3
      item.compare_value = this.compare_values[index]
    find: () ->
      $scope.request_params.index_page = 1
      $scope.request_page()
      $mdDialog.hide();
    open: () ->

      # Include allowed types only
      $scope.ext_search.params = []

      # As far as we need only data - use 'angular.copy' - it prevents object inheritance properties
      for i in angular.copy($scope.jobs.selected.params)
        if this.allowed_types.indexOf(i.type) != -1
          # Check if we compare this type
          if this.compare_types.indexOf(i.type) != -1
            i.compare = true
            i.compare_value = this.compare_values[0]
          this.params.push(i)

      $mdDialog.show({
        clickOutsideToClose: true,
        scope: $scope,
        preserveScope: true,
        templateUrl: "admin_panel/workers/snippets/ext_search.html"
        controller: false
      });

  $scope.request_page = () ->

    $scope.progress = $q.defer()
    $scope.workers = []
    params = MainHelper.query_params($scope.jobs.selected, $scope.events.selected,  $scope.search.value, $scope.ext_search.params)

    $timeout () ->
      workers.one('query').get({query: params, pagination: $scope.request_params}).then (data) ->
        $scope.request_params.max = data.max_data
        $scope.workers = data.data
        for i in $scope.workers
          i.job_name = _.find($scope.jobs.list, {id: i.job}).name
        $scope.progress.resolve()
    , 50



  #
  # Object containing all values and methods to manage search toolbar
  #
  $scope.search =
    show: false
    value: ""
    open: () ->
      this.show = true
      $timeout () ->
        document.querySelector('[ng-model="search.value"]').focus()
        $scope.ext_search.params = []
      , 10
    close: () ->
      this.show = false
      this.value = ""
      $scope.request_page()
    keypress: (event) ->
      switch event.keyCode
        when 13
          $scope.request_page()
        when 27
          event.target.blur()
          $scope.search.show = false
          $scope.search.value = ""
          $scope.jobs.selected = $scope.jobs.list[0]
          $scope.request_page()



  #
  # Object containing all methods to manage list elements
  #
  $scope.actions =
    export: () ->
      str = 'http://vnedesign.ru/list?event=' + $scope.events.selected.id

      if $scope.jobs.selected.id
        str += '&job=' + $scope.jobs.selected.id

      clipboard.copyText(str);
      $translate('simple.list').then (translation) ->
        $mdToast.show(
          $mdToast.simple()
            .textContent(translation)
            .position("bottom right")
            .hideDelay(3000)
        );
    side_nav: (item) ->
      user_job = _.find($scope.jobs.list, {id: item.job})
      $scope.worker_preview.set(MainHelper.worker_data(angular.copy(item), angular.copy(user_job)))
      $mdSidenav('left').toggle()
    set_event: () ->
      $scope.jobs.list = []
      allowed = $scope.events.selected.jobs
      if allowed
        for i in $scope.jobs_collection
          if !i.id
            $scope.jobs.list.push i
          else
            if allowed.indexOf(i.id) != -1
              $scope.jobs.list.push i
        $scope.jobs.selected = $scope.jobs.list[0]
      else
        $scope.jobs.list = $scope.jobs_collection
        $scope.jobs.selected = $scope.jobs.list[0]
      $scope.request_page()
    set_job: () ->
      $scope.ext_search.params = [];
      $scope.request_page();
    menu: {
      element: null
      open: ($mdOpenMenu, ev) ->
        this.element = ev
        $mdOpenMenu(ev);
    }
    link: (item) ->
      clipboard.copyText('http://vnedesign.ru/profile/' + item);
      $translate('simple.timelink').then (translation) ->
        $mdToast.show(
          $mdToast.simple()
            .textContent(translation)
            .position("bottom right")
            .hideDelay(3000)
        );
    remove: () ->
      for i in $scope.selected
        _.remove($scope.workers, i)
        Restangular.one('workers', i.id).customDELETE()
      $translate('workers.removed').then (translation) ->
        $mdToast.show(
          $mdToast.simple()
            .textContent(translation)
            .position("bottom right")
            .hideDelay(3000)
        );
        $scope.selected = []



  $scope.progress = $q.defer()
  request_data = [templates.getList(), events.getList()]
  $q.all(request_data).then (data) ->
    $translate('simple.all').then (translation) ->

      data[1].unshift({name: translation})
      $scope.events.list = data[1]
      $scope.events.selected = $scope.events.list[0]

      data[0].unshift({name: translation})
      $scope.jobs =
        list: data[0]
        selected: data[0][0]

      $scope.jobs_collection = angular.copy($scope.jobs.list)

      $scope.progress.resolve()
      $scope.request_page()
