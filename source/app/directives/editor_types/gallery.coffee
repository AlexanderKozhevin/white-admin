angular.module("app").directive "editorGallery", ($timeout, FileReader, Upload) ->
  {
    restrict: 'E',
    require: 'ngModel',
    replace: true,
    templateUrl: "admin_panel/workers/editor_types/gallery.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.photos = ngModel.$viewValue;

      scope.actions =
        upload: (files) ->
          if files && files.length

            scope.file =  files[0];

            FileReader.readAsDataURL(scope.file, scope).then (data_url) ->
              scope.photos.push({
                  url: ""
                  data_url: data_url
                  progress: 1
              })
              file_object = _.last(scope.photos)
              console.log file_object

              path = 'http://arduino2.club/api/templates/uploadAvatar'
              appload = Upload.upload({
                url: path,
                file: scope.file,
                fileFormDataName: "file",
                withCredentials: true,
                method: 'POST'
              })
              appload.then (resp) ->
                file_object.url = resp.data
                file_object.progress = undefined
                console.log file_object

              ,(resp) ->
                console.log 'upload error'
              ,(evt) ->
                value = parseInt(100.0 * evt.loaded / evt.total)
                file_object.progress = value
                console.log file_object.progress



  }
