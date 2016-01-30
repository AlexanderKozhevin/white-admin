angular.module("app").directive "editorBoolean", () ->
  {
    restrict: 'E',
    require: 'ngModel',
    replace: true,
    templateUrl: "admin_panel/workers/editor_types/boolean.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.value = ngModel.$viewValue;
      scope.$watch 'value', () ->
        ngModel.$setViewValue({value: scope.value, filled: true})


  }
