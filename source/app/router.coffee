angular.module('app').config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $locationProvider.html5Mode({enabled: true, requireBase: false})
  $urlRouterProvider.otherwise("videos");

  $stateProvider.state 'main',
    url: ''
    abstract: true,
    views:
      layout: {templateUrl: 'main.html', controller: 'main_Ctrl'}

  $stateProvider.state 'main.videos',
    url: '/videos/:id'
    abstract: false,
    views:
      main: {templateUrl: 'videos.html', controller: 'videos_Ctrl'}

  $stateProvider.state 'main.record',
    url: '/record/:id'
    abstract: true,
    views:
      main: {templateUrl: 'record/record.html', controller: 'record_Ctrl'}

  $stateProvider.state 'main.record.attributes',
    url: '/attributes'
    abstract: false,
    views:
      record: {templateUrl: 'record/attributes.html', controller: 'record_attributes_Ctrl'}

  $stateProvider.state 'main.record.statistics',
    url: '/statistics'
    abstract: false,
    views:
      record: {templateUrl: 'record/statistics.html', controller: 'record_statistics_Ctrl'}

  $stateProvider.state 'main.record.ads',
    url: '/ads'
    abstract: false,
    views:
      record: {templateUrl: 'record/ads.html', controller: 'record_ads_Ctrl'}

  $stateProvider.state 'main.statistics',
    url: '/statistics'
    abstract: false,
    views:
      main: {templateUrl: 'statistics.html', controller: 'statistics_Ctrl'}

  $stateProvider.state 'main.settings',
    url: '/settings'
    abstract: true,
    views:
      main: {templateUrl: 'setting/settings.html', controller: 'settings_Ctrl'}

  $stateProvider.state 'main.settings.user',
    url: '/user'
    abstract: false,
    views:
      settings: {templateUrl: 'setting/user.html', controller: 'user_setting_Ctrl'}

  $stateProvider.state 'main.settings.users',
    url: '/users'
    abstract: false,
    views:
      settings: {templateUrl: 'setting/users.html', controller: 'users_setting_Ctrl'}


  console.log 'Routes initiated'
