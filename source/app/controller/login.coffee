angular.module("app").controller "LoginCtrl",  ($scope, $http, $state, $translate, $mdToast, localStorageService, Restangular) ->

  $scope.credentials = {
    email: ""
    pass: ""
  }


  $scope.keypress = (event) ->
    if event.keyCode == 13
      $scope.login()
  $scope.login = () ->
    Restangular.one('auth', 'login').customPOST($scope.credentials).then (data) ->
      if data.status == 'success'
        localStorageService.set('auth', true)
        $state.go('admin.workers.list')
      else
        $translate('simple.wrong').then (translation) ->
          $mdToast.show(
            $mdToast.simple()
              .textContent(translation)
              .position("bottom right")
              .hideDelay(3000)
          );
