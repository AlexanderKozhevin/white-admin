angular.module("app").directive "editorText", ($timeout) ->
  {
    restrict: 'E',
    require: 'ngModel',
    replace: true,
    templateUrl: "admin_panel/workers/editor_types/text.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.value = ngModel.$viewValue;

      scope.$watch 'value', () ->
        if scope.value
          ngModel.$setViewValue({value: scope.value, filled: true})
        else
          ngModel.$setViewValue({value: scope.value, filled: false})


  }
