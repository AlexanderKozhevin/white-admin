angular.module("app").controller "JobsEditorCtrl",  ($scope, $timeout, FileReader, Upload, $mdDialog, $state, $mdToast, Restangular, $q, $translate) ->

  # Selected parameters from list
  $scope.selected = []

  templates = Restangular.one('jobs')


  #
  # Put routine actions into object - for easier navigation
  #
  $scope.actions =
    init: () ->
      # Promise for table progress bar
      $scope.progress = $q.defer()

      # Request template data from server
      templates.one($state.params.id).get().then (data) ->
        $scope.job.name = data.name

        # Restore avatar
        if data.avatar_url
          $scope.job.avatar = {url: data.avatar_url, data_url: data.avatar_url}

        # Hash - key will be the same alway, because the names are not changable
        $scope.standart.name.public = data.worker_name.public
        $scope.standart.avatar.public = data.worker_avatar.public

        $scope.job.params = data.params
        $scope.progress.resolve()



    save: () ->

      # Lets prepare object for saving
      json  =
        params: angular.copy($scope.job.params)
        name: $scope.job.name


      # Add standard params publicity
      json.worker_name = {public: $scope.standart.name.public}
      json.worker_avatar = {public: $scope.standart.avatar.public}

      # Add avatar_url if we uploaded it
      json.avatar_url = $scope.job.avatar.url if $scope.job.avatar.url

      # Check if there are duplicating labels
      if _.uniq(json.params, 'name').length != json.params.length

        # Show notification if there are one or more duplicates
        $translate('simple.link_copy').then (translation) ->
          $mdToast.show(
            $mdToast.simple()
              .textContent(translation)
              .position("bottom right")
              .hideDelay(3000)
          );
      else

        # Variable to disable saving button during saving process
        $scope.saving_process = true

        # Generate 'id' parameter for every item using it's hash of name
        for i in json.params
          i.id = md5(i.name)

        if $scope.method == 'new'
          templates.customPOST(json).then (data) ->
            $state.go('admin.jobs.list')
        else
          templates.customPUT(json, $state.params.id).then (data) ->
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
        path = 'http://app.vnedesign.ru/api/jobs/uploadFile'
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
          $scope.job.avatar.url = 'http://s3.amazonaws.com/polymath-storage/' + resp.data.files[0].fd
          $scope.upload_promise = false

        # Filereader helps to show image right after selection - before image has uploaded to server
        FileReader.readAsDataURL($scope.file, $scope).then (img) ->
          $scope.job.avatar.data_url = img

    add: () ->
      # Add new parameter
      $translate('simple.new_param').then (translation) ->
        $scope.job.params.push({
          name: translation
          type: $scope.types[0].name
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
    {name: 'string', key: 'all_types.string'},
    {name: 'number', key: 'all_types.number'},
    {name: 'text', key: 'all_types.text'},
    {name: 'file', key: 'all_types.file'},
    {name: 'date', key: 'all_types.date'},
    {name: 'select', key: 'all_types.select'},
    {name: 'multiple select', key: 'all_types.multi'},
    {name: 'gallery', key: 'all_types.gallery'},
    {name: 'boolean', key: 'all_types.boolean'}
  ]
