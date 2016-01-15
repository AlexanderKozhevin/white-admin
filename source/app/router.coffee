angular.module('app').config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $locationProvider.html5Mode({enabled: true, requireBase: false})
  $urlRouterProvider.otherwise("/genius");

  $stateProvider.state 'main',
    url: '/'
    abstract: false,
    views:
      layout: {templateUrl: 'main.html', controller: 'main_ctrl'}

  $stateProvider.state 'genius',
    url: '/genius'
    abstract: false,
    views:
      layout: {templateUrl: 'genius.html', controller: 'genius_ctrl'}


  console.log 'Routes initiated'