angular.module("app").controller "workers_ctrl",  ($scope, $rootScope, $state, main_helper) ->


  $scope.$on 'new_item', () ->
    $state.go('admin.workers.editor', {method: 'new'})
