angular.module("app").controller "workers_editor_ctrl",  ($scope, Restangular, $state, main_helper, FileReader, Upload) ->

  $scope.method = $state.params.method

  $scope.jobs =
    list: []
    selected: ""

  $scope.worker =
    name: ""
    job: ""
    parameters: []
    avatar: {
      url: ""
      data_url: ""
      loading: false
    }

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


  $scope.get_img = ()->
    if $scope.worker.avatar.data_url
      return $scope.worker.avatar.data_url
    else
      if $scope.worker.avatar.url
        return $scope.worker.avatar.url
      else
        return false
  $scope.actions =
    is_save_disabled: main_helper.is_save_disabled
    set_job: () ->
      $scope.worker.parameters = _.map($scope.jobs.selected.params, (obj) -> obj.value = null; return obj)
      $scope.prepare_params()
    upload_avatar: (files) ->
      if files && files.length
        file = files[0]
        $scope.worker.avatar.loading = true
        FileReader.readAsDataURL(file, $scope).then (data_url) ->
          $scope.worker.avatar.data_url = data_url
          path = 'http://arduino2.club/api/templates/uploadAvatar'
          appload = Upload.upload({
            url: path,
            file: file,
            fileFormDataName: "file",
            withCredentials: true,
            method: 'POST'
          })
          appload.then (resp) ->
            $scope.worker.avatar.loading = false
            $scope.worker.avatar.url = resp.data
          ,(resp) ->
            console.log 'upload error'
