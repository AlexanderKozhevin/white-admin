angular.module("app").controller "BidsListCtrl",  ($scope, $timeout , $q, Restangular, MainHelper, $mdToast, clipboard, $mdDialog, $mdSidenav, $translate) ->

  console.log 'bids'

  templates = Restangular.one('templates')
  workers = Restangular.all('workers')

  $scope.selected = []
  $scope.jobs =
    list:[]
    selected: null

  $scope.request_params =
    limit: 3
    index_page: 1
    max: 1
    sort: 'name'

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
      this.params = []

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

    selected_job = $scope.jobs.list.indexOf($scope.jobs.selected)
    if selected_job != 0
      job_id = $scope.jobs.selected.id
    else
      job_id = undefined

    params = MainHelper.counter_params($scope.search.value, job_id, $scope.ext_search.params)
    # Restangular.one('workers', 'count').get(params).then (max_data) ->

    workers.one('count').get(params).then (max_data) ->
      if max_data
        $scope.request_params.max = max_data
      else
        $scope.request_params.max = 0

      params = MainHelper.configure_params_workers($scope.request_params, $scope.search.value, $scope.jobs.selected.id, $scope.ext_search.params)
      workers.all('find').getList(params).then (data) ->
        $scope.workers = data
        for i in $scope.workers
          i.job_name = _.find($scope.jobs.list, {id: i.job}).name
        $scope.progress.resolve()


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
    side_nav: (item) ->
      user_job = _.find($scope.jobs.list, {id: item.job})
      $scope.worker_preview.set(MainHelper.worker_data(item, user_job))
      $mdSidenav('left').toggle()
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
        # Uncomment this line to send 'DELETE' request to server to remove record
        i.remove()
      $translate('workers.removed').then (translation) ->
        $mdToast.show(
          $mdToast.simple()
            .textContent(translation)
            .position("bottom right")
            .hideDelay(3000)
        );
      $scope.selected = []




  templates.get().then (data) ->
    $translate('simple.all').then (translation) ->
      data.unshift({name: translation})
      $scope.jobs =
        list: data
        selected: data[0]
      $scope.request_page()
