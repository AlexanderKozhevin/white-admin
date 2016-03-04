angular.module('app').config ($stateProvider, $urlRouterProvider, $locationProvider) ->

  $locationProvider.html5Mode({enabled: true, requireBase: false})
  $urlRouterProvider.otherwise("/login");

  $stateProvider.state 'login',
    url: '/login'
    abstract: false,
    views:
      root_layout: {templateUrl: 'login.html', controller: 'LoginCtrl'}

  $stateProvider.state 'admin',
    url: '/admin'
    abstract: true,
    views:
      root_layout: {templateUrl: 'admin_panel/main.html', controller: 'AdminPanelCtrl'}

  $stateProvider.state 'admin.bids',
    url: '/bids'
    abstract: false,
    views:
      admin: {templateUrl: 'admin_panel/bids/list.html', controller: 'BidsListCtrl'}


  $stateProvider.state 'admin.statistics',
    url: '/stat'
    abstract: false,
    views:
      admin: {templateUrl: 'admin_panel/statistics/main.html', controller: 'StatisticsCtrl'}


  $stateProvider.state 'admin.events',
    url: '/events'
    abstract: true,
    views:
      admin: {templateUrl: 'admin_panel/events/main.html', controller: 'EventsCtrl'}

  $stateProvider.state 'admin.events.list',
    url: '/list'
    abstract: false,
    views:
      events: {templateUrl: 'admin_panel/events/list.html', controller: 'EventsListCtrl'}

  $stateProvider.state 'admin.events.editor',
    url: '/editor?method&id'
    abstract: false,
    views:
      events: {templateUrl: 'admin_panel/events/editor.html', controller: 'EventsEditorCtrl'}

  $stateProvider.state 'admin.jobs',
    url: '/jobs'
    abstract: true,
    views:
      admin: {templateUrl: 'admin_panel/jobs/main.html', controller: 'JobsCtrl'}

  $stateProvider.state 'admin.jobs.list',
    url: '/list'
    abstract: false,
    views:
      jobs: {templateUrl: 'admin_panel/jobs/list.html', controller: 'JobsListCtrl'}

  $stateProvider.state 'admin.jobs.editor',
    url: '/editor?method&id'
    abstract: false,
    views:
      jobs: {templateUrl: 'admin_panel/jobs/editor.html', controller: 'JobsEditorCtrl'}


  $stateProvider.state 'admin.workers',
    url: '/workers'
    abstract: true,
    views:
      admin: {templateUrl: 'admin_panel/workers/main.html', controller: 'WorkersCtrl'}

  $stateProvider.state 'admin.workers.list',
    url: '/list'
    abstract: false,
    views:
      workers: {templateUrl: 'admin_panel/workers/list.html', controller: 'WorkersListCtrl'}

  $stateProvider.state 'admin.workers.editor',
    url: '/editor?method&id'
    abstract: false,
    views:
      workers: {templateUrl: 'admin_panel/workers/editor.html', controller: 'WorkersEditorCtrl'}




  console.log 'Routes initiated'
