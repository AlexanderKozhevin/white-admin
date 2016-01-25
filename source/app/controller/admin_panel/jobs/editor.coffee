angular.module("app").controller "jobs_editor_ctrl",  ($scope, $timeout, FileReader, Upload, $mdDialog, $state, $mdToast, Restangular, $q) ->

  # Selected parameters from list
  $scope.selected = []

  #
  # Put routine actions into object - for easier navigation
  #
  $scope.actions =
    init: () ->
      # Promise for table progress bar
      $scope.progress = $q.defer()
      Restangular.one('templates', $state.params.id).get().then (data) ->
        $scope.job.name = data.name

        # Restore avatar
        if data.avatar_url
          $scope.job.avatar = {url: data.avatar_url, data_url: data.avatar_url}

        # Hash - key will be the same alway, because the names are not changable
        $scope.standart.name = data.params[0]
        $scope.standart.avatar = data.params[1]

        # To separate default params
        data.params.splice(0,2)

        $scope.job.params = data.params
        $scope.progress.resolve()



    save: () ->

      # Lets prepare object for saving
      json  =
        params: angular.copy($scope.job.params)
        name: $scope.job.name

      # Add standard params
      json.params.unshift($scope.standart.avatar)
      json.params.unshift($scope.standart.name)

      # Add avatar_url if we uploaded it
      json.avatar_url = $scope.job.avatar.url if $scope.job.avatar.url

      # Check if there are duplicating labels
      if _.uniq(json.params, 'name').length != json.params.length

        # Show notification if there are one or more duplicates
        $mdToast.show(
          $mdToast.simple()
            .textContent("Duplicating labels!")
            .position("bottom right")
            .hideDelay(3000)
        );
      else

        # Variable to disable saving button during saving process
        $scope.saving_process = true

        # Generate 'id' parameter for every item using it's hash of name
        for i in json.params
          i.id = md5(i.name)

        # Restangular methods for sending request to server
        if $scope.method == 'new'
          Restangular.one('templates').customPOST(json).then (data) ->
            $state.go('admin.jobs.list')
        else
          Restangular.one('templates').customPUT(json, $state.params.id).then (data) ->
            $state.go('admin.jobs.list')

    show_dialog: (item) ->

      # Temporary variable to assign values to selected item
      $scope.dialog.temp = item

      # Show old values
      if item.values
        $scope.dialog.values = item.values

      # Dialog popup
      $mdDialog.show({
        clickOutsideToClose: true,
        scope: $scope,
        preserveScope: true,
        templateUrl: "dialogs/editor_values.html"
        controller: false
      });
    get_image: () ->
      # This function helps to show uploading image immediately via filereader
      if $scope.job.avatar.url != ""
        return $scope.job.avatar.url
      else
        return $scope.job.avatar.data_url
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

        # Variable for disabling saving button during upload process
        $scope.upload_promise = true

        # Upload promise
        appload.then (resp) ->
          $scope.job.avatar.url = resp.data
          $scope.upload_promise = false

        # Filereader helps to show image right after selection - before image has uploaded to server
        FileReader.readAsDataURL($scope.file, $scope).then (img) ->
          $scope.job.avatar.data_url = img

    add: () ->
      # Add new parameter
      $scope.job.params.push({
        name: "New parameter"
        type: $scope.types[0]
        public: true
      })
    remove: () ->
      # Remove selected parameters
      for i in $scope.selected
        _.remove($scope.job.params, i)
      $scope.selected = []



  # Edit/New
  $scope.method = $state.params.method
  if $scope.method == 'edit'
    if !$state.params.id
      $state.go('admin.jobs.list')
    else
      $scope.actions.init()

  #
  # For multiple select values input
  #
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


  #
  # Job model
  #
  $scope.job =
    name: ""
    params: []
    avatar: {
      url: ""
      data_url: ""
    }


  #
  # Default job params
  #
  $scope.standart =
    name: {
      name: "Full name"
      type: "String"
      public: true
    },
    avatar: {
      name: "Avatar"
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
