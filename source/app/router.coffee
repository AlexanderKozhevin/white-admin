angular.module('app').config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $locationProvider.html5Mode({enabled: true, requireBase: false})
  $urlRouterProvider.otherwise("/");

  $stateProvider.state 'main',
    url: '/'
    abstract: false,
    views:
      root_layout: {templateUrl: 'landing.html', controller: 'landing_ctrl'}

  $stateProvider.state 'login',
    url: '/login'
    abstract: false,
    views:
      root_layout: {templateUrl: 'login.html', controller: 'login_ctrl'}


  console.log 'Routes initiated'
