angular.module("app").controller "JobsListCtrl",  ($scope, $timeout , $q, Restangular, MainHelper, $mdToast) ->

  $scope.selected = []

  templates = Restangular.one('jobs')


  $scope.request_params =
    limit: 5
    index_page: 1
    max: 1
    sort: 'name'


  $scope.request_page = () ->
    params = {}
    params.query = $scope.search.value if $scope.search.value
    $scope.progress = $q.defer()
    # Get number of maximum possible results
    templates.one('count').get(params).then (max_data) ->
      $scope.request_params.max = max_data
      params = MainHelper.configure_params_jobs($scope.request_params, $scope.search.value)

      templates.all('find').getList(params).then (data) ->
        $scope.jobs = data
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
          $scope.request_page()


  #
  # Object containing all methods to manage list elements
  #
  $scope.actions =
    remove: () ->
      for i in $scope.selected
        _.remove($scope.jobs, i)
        # Uncomment this line to send 'DELETE' request to server to remove record
        # i.remove()
      $translate('simple.rec_removed').then (translation) ->
      $mdToast.show(
        $mdToast.simple()
          .textContent(translation)
          .position("bottom right")
          .hideDelay(3000)
      );
      $scope.selected = []


  $scope.request_page()
