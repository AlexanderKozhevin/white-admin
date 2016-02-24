angular.module("app").directive "editorNumber", ($timeout) ->
  {
    restrict: 'E',
    require: 'ngModel',
    templateUrl: "admin_panel/workers/editor_types/number.html",
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
