app = angular.module('app', ['ui.router', 'ngSanitize',  'ngRoute', 'ngAnimate',
  'ngMaterial',  'restangular', 'templates', 'pascalprecht.translate', 'ngLocale',
  'ngCookies', 'ngMessages', 'tmh.dynamicLocale', 'md.data.table', 'ngFileUpload', 'filereader',
  'angular-clipboard',  'angular-chartist', 'LocalStorageModule', 'analytics.mixpanel'
  ])



app.config ($mixpanelProvider) ->
  $mixpanelProvider.apiKey('04f58322b64281927253b4ea2043853f');

app.config ($mdThemingProvider) ->
  $mdThemingProvider.theme('default').primaryPalette('teal')

app.config (RestangularProvider) ->
  RestangularProvider.setBaseUrl('http://app.vnedesign.ru/api')
  RestangularProvider.setDefaultHeaders({'Content-Type': 'application/json'});

  # RestangularProvider.setErrorInterceptor (response, deferred, responseHandler) ->
  #   if response.status == 404
  #     $window.location.href='/';


app.config ($animateProvider) ->
  $animateProvider.classNameFilter(/^(?:(?!ng-animate-disabled).)*$/);




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



app.run (localStorageService, $http, $rootScope, $state) ->
  localStorageService.get('auth');
  $http.get('http://app.vnedesign.ru/api/auth/is_logged').success (data) ->
    if data.status == 'success'
      localStorageService.set('auth', true)
    else
      localStorageService.set('auth', false)
      $state.go('login')


  $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
    if !localStorageService.get('auth')
      if (toState.name != 'login')
        event.preventDefault();
