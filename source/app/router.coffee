angular.module('app').config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $locationProvider.html5Mode({enabled: true, requireBase: false})
  $urlRouterProvider.otherwise("videos");

  $stateProvider.state 'main',
    url: '/'
    abstract: false,
    views:
      layout: {templateUrl: 'main.html', controller: 'main_ctrl'}


  console.log 'Routes initiated'
