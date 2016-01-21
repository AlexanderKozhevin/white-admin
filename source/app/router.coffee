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

  $stateProvider.state 'admin',
    url: '/admin'
    abstract: true,
    views:
      root_layout: {templateUrl: 'admin_panel/main.html', controller: 'admin_panel_ctrl'}

  $stateProvider.state 'admin.jobs',
    url: '/jobs'
    abstract: true,
    views:
      admin: {templateUrl: 'admin_panel/jobs/main.html', controller: 'jobs_ctrl'}

  $stateProvider.state 'admin.jobs.list',
    url: '/list'
    abstract: false,
    views:
      jobs: {templateUrl: 'admin_panel/jobs/list.html', controller: 'jobs_list_ctrl'}

  $stateProvider.state 'admin.jobs.editor',
    url: '/editor'
    abstract: false,
    views:
      jobs: {templateUrl: 'admin_panel/jobs/editor.html', controller: 'jobs_editor_ctrl'}



  console.log 'Routes initiated'
