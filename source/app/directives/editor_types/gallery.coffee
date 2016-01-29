angular.module("app").directive "editorGallery", ($timeout, FileReader, Upload, $window) ->
  {
    restrict: 'E',
    require: 'ngModel',
    replace: true,
    templateUrl: "admin_panel/workers/editor_types/gallery.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.photos = ngModel.$viewValue;

      scope.prepare = () ->

        json = {
          photos: scope.photos
          loading: false
        }
        for i in json.photos
          if i.progress
            json.loading = true;
            break;
        ngModel.$setViewValue(json)

      scope.actions =
        open: (link) ->
          $window.open(link)
          return false

        delete: (item) ->
          _.remove(scope.photos, item)

        pre_upload: (files) ->
          if files
            for i in files
              this.upload([i])

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
              scope.prepare()
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
                scope.prepare()

              ,(resp) ->
                console.log 'upload error'
              ,(evt) ->
                value = parseInt(100.0 * evt.loaded / evt.total)
                file_object.progress = value



  }
