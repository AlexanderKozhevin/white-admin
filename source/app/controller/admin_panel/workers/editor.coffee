angular.module("app").controller "workers_editor_ctrl",  ($scope, Restangular, $state, main_helper) ->

  $scope.method = $state.params.method

  $scope.jobs =
    list: []
    selected: ""

  $scope.worker =
    name: ""
    job: ""
    parameters: []
    avatar: ""

  $scope.prepare_params = () ->
    for i in $scope.worker.parameters
      i.value = null
      switch i.type
        when 'file' then i.value = {name: "", url: ""}
        when 'select' then i.value = {selected: "", list: i.values}
        when 'multiple select' then i.value = {selected: [], list: i.values}
        when 'gallery' then  i.value = []

  Restangular.one('templates').get().then (data) ->
    $scope.jobs.list = data
    $scope.jobs.selected = data[0]
    $scope.worker.parameters = _.map($scope.jobs.selected.params, (obj) -> obj.value = null; return obj)
    $scope.prepare_params()


  $scope.actions =
    is_save_disabled: main_helper.is_save_disabled
    set_job: () ->
      $scope.worker.parameters = _.map($scope.jobs.selected.params, (obj) -> obj.value = null; return obj)
      $scope.prepare_params()
    upload_avatar: () ->
      if files && files.length
        file = files[0]
        path = 'http://arduino2.club/api/templates/uploadAvatar'
        appload = Upload.upload({
          url: path,
          file: file,
          fileFormDataName: "file",
          withCredentials: true,
          method: 'POST'
        })
        appload.then (resp) ->
          scope.file.url = resp.data
          scope.loading = false
          scope.prepare()
        ,(resp) ->
          console.log 'upload error'
        ,(evt) ->
          value = parseInt(100.0 * evt.loaded / evt.total)
          scope.loading = value
