angular.module("app").directive "editorFile", (Upload, $window) ->
  {
    restrict: 'E',
    require: 'ngModel',
    templateUrl: "admin_panel/workers/editor_types/file.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.file = ngModel.$viewValue;
        scope.loading = false
        scope.prepare()

      scope.prepare = () ->
        if scope.file.url
          ngModel.$setViewValue({value: scope.file, loading: scope.loading, filled: true})
        else
          ngModel.$setViewValue({value: scope.file, loading: scope.loading, filled: false})



      scope.actions =
        open: (link) ->
          if link
            $window.open(link)
          return false

        delete: () ->
          scope.file  =
            url: ''
            name: ''
          scope.loading = false
          scope.prepare()

        upload: (files) ->
          if files && files.length
            file = files[0]
            scope.file.name = file.name
            scope.loading = 1

            scope.prepare()

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




  }
