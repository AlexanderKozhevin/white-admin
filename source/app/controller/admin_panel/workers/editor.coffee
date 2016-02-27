angular.module("app").controller "WorkersEditorCtrl",  ($scope, Restangular, $state, MainHelper, FileReader, Upload) ->

  $scope.method = $state.params.method

  
  workers = Restangular.one('workers')
  templates = Restangular.one('templates')



  $scope.jobs =
    list: []
    selected: ""

  $scope.worker =
    name: ""
    job: ""
    parameters: []
    saving_process: false
    avatar: {
      url: ""
      data_url: ""
      loading: false
    }

  $scope.init_params = () ->
    for i in $scope.worker.parameters
      i.value = null
      switch i.type
        when 'file' then i.value = {name: "", url: ""}
        when 'select' then i.value = {selected: "", list: i.values}
        when 'multiple select' then i.value = {selected: [], list: i.values}
        when 'gallery' then  i.value = []
    $scope.loading = false


  $scope.restore_params = () ->

    workers.one($state.params.id).get().then (data) ->

      $scope.jobs.selected = _.find($scope.jobs.list, {id: data.job})
      $scope.worker.parameters = _.map($scope.jobs.selected.params, (obj) -> obj.value = null; return obj)

      $scope.worker.name = data.name
      $scope.worker.avatar.url = data.avatar
      $scope.worker.job = data.job

      for i in $scope.worker.parameters
        i.value = data.values[i.id]
        switch i.type
          when 'select' then i.value = {selected: data.values[i.id], list: i.values}
          when 'multiple select' then i.value = {selected: data.values[i.id], list: i.values}
          when 'gallery' then i.value = _.map(data.values[i.id], (obj) -> return {url: obj})
      $scope.loading = false




  templates.get().then (data) ->
    $scope.jobs.list = data
    $scope.loading = true
    if $scope.method == 'new'
      $scope.jobs.selected = data[0]
      $scope.worker.parameters = _.map($scope.jobs.selected.params, (obj) -> obj.value = null; return obj)
      $scope.init_params()
    else
      $scope.restore_params()







  $scope.get_img = ()->
    if $scope.worker.avatar.data_url
      return $scope.worker.avatar.data_url
    else
      if $scope.worker.avatar.url
        return $scope.worker.avatar.url
      else
        return false


  $scope.actions =
    is_save_disabled: MainHelper.is_save_disabled
    save: () ->
      # Variables to disable saving button
      $scope.worker.saving_process = true
      json =
        avatar: $scope.worker.avatar.url
        name: $scope.worker.name
        job: $scope.jobs.selected.id
        values: {}

      # Prepare values
      for i in $scope.worker.parameters
        json.values[i.id] = i.value.value
        if i.type == 'gallery'
          json.values[i.id] = _.map(i.value.value, (obj) -> return obj.url)

      # Sending saving request to server
      if $scope.method == 'new'
        workers.customPOST(json).then () ->
          $state.go('admin.workers.list')
      else
        workers.one($state.params.id).customPUT(json).then () ->
          $state.go('admin.workers.list')

    set_job: () ->
      $scope.worker.parameters = _.map($scope.jobs.selected.params, (obj) -> obj.value = null; return obj)
      $scope.init_params()
    upload_avatar: (files) ->
      if files && files.length
        file = files[0]
        $scope.worker.avatar.loading = true
        FileReader.readAsDataURL(file, $scope).then (data_url) ->
          $scope.worker.avatar.data_url = data_url
          path = 'http://vnedesign.ru/api/templates/uploadAvatar'
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
