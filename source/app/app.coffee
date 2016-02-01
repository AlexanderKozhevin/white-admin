app = angular.module('app', ['ui.router', 'ngSanitize',  'ngRoute', 'ngAnimate',
  'ngMaterial',  'restangular', 'templates', 'pascalprecht.translate', 'ngLocale',
  'ngCookies', 'ngMessages', 'tmh.dynamicLocale', 'ngWebSocket', 'googlechart', 'md.data.table', 'ngFileUpload', 'filereader', 'angular-clipboard'
  ])


app.config ($mdThemingProvider) ->
  $mdThemingProvider.theme('default').primaryPalette('teal')


app.config (RestangularProvider) ->
  RestangularProvider.setBaseUrl('http://arduino2.club/api')
  RestangularProvider.setDefaultHeaders({'Content-Type': 'application/json'});


app.config ($animateProvider) ->
  $animateProvider.classNameFilter(/^(?:(?!ng-animate-disabled).)*$/);


app.config ($translateProvider, tmhDynamicLocaleProvider) ->
  $translateProvider.useCookieStorage();

  $translateProvider.useStaticFilesLoader({
    prefix: '/locales/',
    suffix: '.json'
  });
  locale = document.querySelector('body').getAttribute('locale')
  locale = "en-us" if !locale

  $translateProvider.preferredLanguage('en');

  tmhDynamicLocaleProvider.localeLocationPattern('/locales/angular-locale_{{locale}}.js');
  tmhDynamicLocaleProvider.defaultLocale('en-us')


angular.element(document).ready () ->
  angular.bootstrap(document, ["app"]);
