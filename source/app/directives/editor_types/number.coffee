angular.module("app").directive "editorNumber", ($timeout) ->
  {
    restrict: 'E',
    require: 'ngModel',
    replace: true,
    templateUrl: "admin_panel/workers/editor_types/number.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.value = ngModel.$viewValue;

      scope.$watch 'value', () ->
        ngModel.$setViewValue(scope.value)

  }
