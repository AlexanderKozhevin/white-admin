angular.module("app").directive "editorMultiSelect", ($timeout) ->
  {
    restrict: 'E',
    require: 'ngModel',
    replace: true,
    templateUrl: "admin_panel/workers/editor_types/multi_select.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.selected = ngModel.$viewValue.selected;
        scope.list = ngModel.$viewValue.list;
      scope.$watch 'selected', () ->
        ngModel.$setViewValue(scope.selected)

  }
