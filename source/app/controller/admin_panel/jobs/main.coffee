angular.module("app").controller "JobsCtrl",  ($scope, $rootScope, $state, MainHelper) ->


  $scope.$on 'new_item', () ->
    $state.go('admin.jobs.editor', {method: 'new'})
