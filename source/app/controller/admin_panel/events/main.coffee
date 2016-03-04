angular.module("app").controller "EventsCtrl",  ($scope, $rootScope, $state, MainHelper) ->


  $scope.$on 'new_item', () ->
    $state.go('admin.events.editor', {method: 'new'})
