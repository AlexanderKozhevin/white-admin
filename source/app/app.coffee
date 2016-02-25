app = angular.module('app', ['ui.router', 'ngSanitize',  'ngRoute', 'ngAnimate',
  'ngMaterial',  'restangular', 'templates', 'pascalprecht.translate', 'ngLocale',
  'ngCookies', 'ngMessages', 'tmh.dynamicLocale', 'ngWebSocket', 'googlechart', 'md.data.table', 'ngFileUpload', 'filereader',
  'angular-clipboard',  'angular-chartist', 'angular-google-analytics'
  ])


app.config ($mdThemingProvider) ->
  $mdThemingProvider.theme('default').primaryPalette('teal')


app.config (RestangularProvider) ->
  RestangularProvider.setBaseUrl('http://95.213.191.67:1338/api')
  RestangularProvider.setDefaultHeaders({'Content-Type': 'application/json'});

  # RestangularProvider.setErrorInterceptor (response, deferred, responseHandler) ->
  #   if response.status == 404
  #     $window.location.href='/';


app.config ($animateProvider) ->
  $animateProvider.classNameFilter(/^(?:(?!ng-animate-disabled).)*$/);

app.config (AnalyticsProvider) ->
  AnalyticsProvider.setAccount('UA-73312930-2');
  AnalyticsProvider.logAllCalls(true)
  AnalyticsProvider.useDisplayFeatures(true);



app.config ($translateProvider, tmhDynamicLocaleProvider) ->
  $translateProvider.useCookieStorage();

  $translateProvider.useStaticFilesLoader({
    prefix: '/locales/',
    suffix: '.json'
  });
  locale = document.querySelector('body').getAttribute('locale')
  locale = "ru-ru" if !locale

  $translateProvider.preferredLanguage('ru');

  tmhDynamicLocaleProvider.localeLocationPattern('/locales/angular-locale_{{locale}}.js');
  tmhDynamicLocaleProvider.defaultLocale('ru-ru')


angular.element(document).ready () ->
  angular.bootstrap(document, ["app"]);
