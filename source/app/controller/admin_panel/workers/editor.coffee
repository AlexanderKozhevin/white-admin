angular.module("app").controller "workers_editor_ctrl",  ($scope, Restangular, $state) ->

  $scope.method = $state.params.method

  $scope.output = () ->
    console.log $scope.worker.params

  $scope.jobs =
    list: []
    selected: ""

  $scope.worker =
    name: ""
    job: ""
    parameters: []

  $scope.prepare_params = () ->
    for i in $scope.worker.parameters
      i.values = null
      switch i.type
        when 'file' then i.value = {name: "", url: ""}
        when 'select' then i.value = {selected: "", list: i.values}
        when 'multiple select' then i.value = {selected: [], list: i.values}
        when 'gallery'
          i.values = []

  Restangular.one('templates').get().then (data) ->
    $scope.jobs.list = data
    $scope.jobs.selected = data[0]
    $scope.worker.parameters = _.map(data[0].params, (obj) -> obj.value = null; return obj)
    $scope.prepare_params()


  $scope.actions =
    is_save_disabled: () ->
      a = false
      if $scope.worker.parameters
        for i in $scope.worker.parameters
          if i.values
            if i.values.loading
              a = true;
              break;
      return a
