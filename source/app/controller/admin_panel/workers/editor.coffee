angular.module("app").controller "workers_editor_ctrl",  ($scope, $timeout, FileReader, Upload, $mdDialog, $state, $mdToast, Restangular, $q) ->


  $scope.job =
    list: []
    selected: ""
  Restangular.one('templates').get().then (data) ->
    $scope.job.list = data
