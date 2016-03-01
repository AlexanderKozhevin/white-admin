angular.module("app").controller "LoginCtrl",  ($scope, $http, $state, $translate, $mdToast, localStorageService) ->

  $scope.credentials = {
    email: ""
    pass: ""
  }


  $scope.keypress = (event) ->
    if event.keyCode == 13
      $scope.login()
  $scope.login = () ->
    $http.get('http://app.vnedesign.ru/api/auth/login', {params: $scope.credentials}).success (data) ->
      console.log data
      if data == 'success'
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
