angular.module("app").controller "EventsEditorCtrl",  ($scope, $timeout, FileReader, Upload, $mdDialog, $state, $mdToast, Restangular, $q, $translate) ->

  # Selected parameters from list
  $scope.selected = []

  templates = Restangular.one('jobs')
  templates.get().then (data) ->
    $scope.jobs = data



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
