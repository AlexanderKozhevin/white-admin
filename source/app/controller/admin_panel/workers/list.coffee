angular.module("app").controller "workers_list_ctrl",  ($scope, $timeout , $q, Restangular, main_helper, $mdToast, clipboard, $mdDialog) ->

  $scope.selected = []

  $scope.jobs =
    list:[]
    selected: null



  $scope.request_params =
    limit: 3
    index_page: 1
    max: 1
    sort: 'name'


  $scope.request_page = () ->

    params = {}
    params.query = $scope.search.value if $scope.search.value

    selected_job = $scope.jobs.list.indexOf($scope.jobs.selected)
    params.id = $scope.jobs.selected.id if selected_job != 0

    console.log $scope.jobs.selected.$$mdSelectId

    $scope.progress = $q.defer()
    # Get number of maximum possible results
    Restangular.one('workers', 'count').get(params).then (max_data) ->
      if max_data
        $scope.request_params.max = max_data
      else
        $scope.request_params.max = 0

      params = main_helper.configure_params_workers($scope.request_params, $scope.search.value, $scope.jobs.selected.id)
      console.log params
      Restangular.all('workers','find').getList(params).then (data) ->
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
    menu: {
      element: null
      open: ($mdOpenMenu, ev) ->
        this.element = ev
        $mdOpenMenu(ev);
    }
    link: (item) ->
      clipboard.copyText('http://arduino2.club/' + item);
      $mdToast.show(
        $mdToast.simple()
          .textContent("Link is copied to clipboard")
          .position("bottom right")
          .hideDelay(3000)
      );
    remove: () ->
      for i in $scope.selected
        _.remove($scope.workers, i)
        # Uncomment this line to send 'DELETE' request to server to remove record
        # i.remove()
      $mdToast.show(
        $mdToast.simple()
          .textContent("Records removed")
          .position("bottom right")
          .hideDelay(3000)
      );
      $scope.selected = []


  Restangular.one('templates').get().then (data) ->
    data.unshift({name: "All"})
    $scope.jobs =
      list: data
      selected: data[0]
    $scope.request_page()
