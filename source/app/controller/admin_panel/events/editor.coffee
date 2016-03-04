angular.module("app").controller "EventsEditorCtrl",  ($scope, $timeout, FileReader, Upload, $mdDialog, $state, $mdToast, Restangular, $q, $translate) ->

  $scope.method = $state.params.method

  $scope.saving_process = false

  templates = Restangular.one('jobs')
  events = Restangular.one('events')


  $scope.init = () ->
    if $scope.method == 'edit'
      if $state.params.id
        events.one($state.params.id).get().then (data) ->
          console.log data
      else
        $state.go('admin.events.list')


  $scope.event =
    name: ""
    city: ""
    time: ""
    about: ""
    jobs: []

  $scope.save = () ->
    data = angular.copy($scope.event)
    data.jobs = _.map(data.jobs, (obj) -> return obj.id)
    $scope.saving_process = true
    events.customPOST(data).then () ->
      $state.go('admin.events.list')

  $scope.querySearch = (query) ->

    query = query.toLowerCase()

    if $scope.jobs
      result = []
      for i in $scope.jobs
        name = i.name.toLowerCase()

        if name.indexOf(query) != -1
          result.push i
      return result
    else
      return result




  templates.get().then (data) ->
    $scope.init()
    $scope.jobs = data
