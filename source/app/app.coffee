app = angular.module('app', ['ui.router', 'ngSanitize',  'ngRoute', 'ngAnimate',
  'ngMaterial',  'restangular', 'templates', 'pascalprecht.translate', 'ngLocale',
  'ngCookies', 'ngMessages', 'tmh.dynamicLocale', 'ngWebSocket'
  ])


app.config ($mdThemingProvider) ->
  $mdThemingProvider.theme('default').primaryPalette('teal')
  $mdThemingProvider.theme('white_theme').primaryPalette('grey', {'default': '50', 'hue-1': '200', 'hue-2': '400', 'hue-3': '600' })

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
