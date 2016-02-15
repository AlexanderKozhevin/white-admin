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

  $stateProvider.state 'svg',
    url: '/svg'
    abstract: false,
    views:
      root_layout: {templateUrl: 'svg.html', controller: 'svg_ctrl'}


  $stateProvider.state 'admin',
    url: '/admin'
    abstract: true,
    views:
      root_layout: {templateUrl: 'admin_panel/main.html', controller: 'admin_panel_ctrl'}


  $stateProvider.state 'admin.statistics',
    url: '/stat'
    abstract: false,
    views:
      admin: {templateUrl: 'admin_panel/statistics/main.html', controller: 'statistics_ctrl'}


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
    url: '/editor?method&id'
    abstract: false,
    views:
      jobs: {templateUrl: 'admin_panel/jobs/editor.html', controller: 'jobs_editor_ctrl'}


  $stateProvider.state 'admin.workers',
    url: '/workers'
    abstract: true,
    views:
      admin: {templateUrl: 'admin_panel/workers/main.html', controller: 'workers_ctrl'}

  $stateProvider.state 'admin.workers.list',
    url: '/list'
    abstract: false,
    views:
      workers: {templateUrl: 'admin_panel/workers/list.html', controller: 'workers_list_ctrl'}

  $stateProvider.state 'admin.workers.editor',
    url: '/editor?method&id'
    abstract: false,
    views:
      workers: {templateUrl: 'admin_panel/workers/editor.html', controller: 'workers_editor_ctrl'}




  console.log 'Routes initiated'
