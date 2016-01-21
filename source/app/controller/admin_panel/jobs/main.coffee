angular.module("app").controller "jobs_ctrl",  ($scope, $rootScope, $state, main_helper) ->


  $scope.$on 'new_item', () ->
    $state.go('admin.jobs.editor', {method: 'new'})
