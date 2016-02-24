angular.module("app").directive "editorMultiSelect", ($timeout) ->
  {
    restrict: 'E',
    require: 'ngModel',
    templateUrl: "admin_panel/workers/editor_types/multi_select.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      ngModel.$render = () ->
        scope.selected = ngModel.$viewValue.selected;
        scope.list = ngModel.$viewValue.list;
      scope.$watch 'selected', () ->

        if scope.selected.length>0
          ngModel.$setViewValue({value: scope.selected, filled: true})
        else
          ngModel.$setViewValue({value: scope.selected, filled: false})


  }
