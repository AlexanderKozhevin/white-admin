angular.module("app").controller "jobs_editor_ctrl",  ($scope, $timeout, FileReader, Upload, $mdDialog) ->

  $scope.selected = []

  $scope.dialog =
    values: []
    temp: ""
    close: () ->
      this.values = []
      $mdDialog.hide();
    save: () ->
      this.temp.values = this.values
      this.values = []
      $mdDialog.hide();

  $scope.job =
    name: ""
    params: []
    avatar: {
      url: ""
      data_url: ""
    }

  #
  # Required job params
  #
  $scope.standart =
    name: {
      value: "Full name"
      type: "String"
      public: true
    },
    avatar: {
      value: "Avatar"
      type: "Photo"
      public: true
    }

  $scope.types = [
    'string',
    'number'
    'text',
    'file',
    'date'
    'select',
    'multiple select',
    'gallery',
    'boolean'
  ]


  $scope.actions =
    values_dialog: (item) ->
      $scope.dialog.temp = item
      if item.values
        $scope.dialog.values = item.values
      $mdDialog.show({
        clickOutsideToClose: true,
        scope: $scope,
        preserveScope: true,
        templateUrl: "dialogs/editor_values.html"
        controller: false
      });
    get_image: () ->
      if $scope.job.avatar.data_url != ""
        return $scope.job.avatar.data_url
      else
        return $scope.job.avatar.url
    upload: (files) ->
      if files && files.length
        $scope.file =  files[0];
        path = 'http://arduino2.club/api/templates/uploadAvatar'
        appload = Upload.upload({
          url: path,
          file: $scope.file,
          fileFormDataName: "file",
          withCredentials: true,
          method: 'POST'
        })
        appload.then (resp) ->
          console.log resp.data
          $scope.job.avatar.url = resp.data
        FileReader.readAsDataURL($scope.file, $scope).then (img) ->
          $scope.job.avatar.data_url = img

    add: () ->
      $scope.job.params.push({
        value: "New parameter"
        type: $scope.types[0]
        public: true
      })
    remove: () ->
      for i in $scope.selected
        _.remove($scope.job.params, i)
      $scope.selected = []
