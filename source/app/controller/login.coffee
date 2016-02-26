angular.module("app").controller "login_ctrl",  ($scope, $http, $state, $translate, $mdToast, localStorageService) ->

  $scope.credentials = {
    login: ""
    pwd: ""
  }


  $scope.keypress = (event) ->
    if event.keyCode == 13
      $scope.login()
  $scope.login = () ->
    $http.get('http://vnedesign.ru/api/auth/login', {params: $scope.credentials}).success (data) ->
      if data == 'good'
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
