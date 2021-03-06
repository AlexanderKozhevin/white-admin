angular.module("app").directive "editorGallery", ($timeout, FileReader, Upload, $window) ->
  {
    restrict: 'E',
    require: 'ngModel',
    templateUrl: "admin_panel/workers/editor_types/gallery.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.photos = ngModel.$viewValue;
        scope.prepare()

      scope.prepare = () ->

        json = {
          value: scope.photos
          loading: false
          filled: false
        }

        for i in json.value
          if i.url
            json.filled = true
          if i.progress
            json.loading = true;
            break;


        ngModel.$setViewValue(json)

      scope.actions =
        open: (link) ->
          if link
            $window.open(link)
          return false

        delete: (item) ->
          _.remove(scope.photos, item)
          scope.prepare()

        pre_upload: (files) ->
          if files
            for i in files
              this.upload([i])

        upload: (files) ->
          if files && files.length
            file = files[0]
            FileReader.readAsDataURL(file, scope).then (data_url) ->
              scope.photos.push({
                  url: ""
                  data_url: data_url
                  progress: 1
              })
              file_object = _.last(scope.photos)
              scope.prepare()
              path = 'http://app.vnedesign.ru/api/jobs/uploadFile'
              appload = Upload.upload({
                url: path,
                file: file,
                fileFormDataName: "file",
                withCredentials: true,
                method: 'POST'
              })
              appload.then (resp) ->
                file_object.url = 'http://s3.amazonaws.com/polymath-storage/' + resp.data.files[0].fd
                file_object.progress = undefined
                scope.prepare()
              ,(resp) ->
                console.log 'upload error'
              ,(evt) ->
                value = parseInt(100.0 * evt.loaded / evt.total)
                file_object.progress = value



  }
