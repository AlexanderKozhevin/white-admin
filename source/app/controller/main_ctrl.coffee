angular.module("app").controller "main_Ctrl",  ($scope, $mdSidenav, $state, $translate, tmhDynamicLocale) ->


  $scope.toggle = () ->
    $mdSidenav('left').toggle();


  $scope.title =
    name: "Polymath"
    set: (name) ->
      this.name = name

  $scope.language =
    current: 'En'
    set_language: (language) ->
      switch language
        when 'de'
          tmhDynamicLocale.set('de-de')
          $translate.use('de');
          $scope.language.current = "De"
        when 'en'
          tmhDynamicLocale.set('en-us')
          $translate.use('en');
          $scope.language.current = "En"


  $scope.menu =
    user_menu: {
      element: null
      open: ($mdOpenMenu, ev) ->
        this.element = ev
        $mdOpenMenu(ev);
    },
    flag_menu: {
      element: null
      open: ($mdOpenMenu, ev) ->
        this.element = ev
        $mdOpenMenu(ev);
    }

  $scope.prevent = (event) ->
    event.stopPropagation()
    event.preventDefault()

  $scope.video_menu =
    expand: false
    children: [
      {name: "All videos", id: 0},
      {name: "Deleted", id: 1},
      {name: "Processing", id: 2},
      {name: "MTV", id: 3},
      {name: "Science", id: 4},
      {name: "Hacking", id: 5},
      {name: "DIY", id: 6},
      {name: "Moto", id: 7},
      {name: "NASA", id: 8},
      {name: "Farming", id: 9},
      {name: "Workout", id: 10}
    ]
