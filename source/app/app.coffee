app = angular.module('app', ['ui.router', 'ngSanitize',  'ngRoute', 'ngAnimate', 'ngMaterial',  'restangular', 'templates'])


angular.element(document).ready () ->
  angular.bootstrap(document, ["app"]);
