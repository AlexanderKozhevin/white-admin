angular.module("app").controller "WorkersCtrl",  ($scope, $rootScope, $state, MainHelper) ->


  $scope.$on 'new_item', () ->
    $state.go('admin.workers.editor', {method: 'new'})
