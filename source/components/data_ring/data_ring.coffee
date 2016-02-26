angular.module("app").directive "componentDataRing", ($timeout) ->
  {
    restrict: 'E',
    templateUrl: "data_ring/data_ring.html",
    scope: {},
    link: (scope, elm, attrs, ngModel) ->
      console.log 'hello nigga'


  }
