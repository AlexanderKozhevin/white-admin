angular.module("app").controller "statistics_Ctrl",  ($scope, $mdSidenav, $translate, chart_helper) ->


  $translate('stat').then (data) ->
    $scope.title.set(data)

  $mdSidenav("left").close()
  console.log 'statistics_Ctrl'

  $scope.viewsmap = chart_helper.viewline()
  $scope.geomap = chart_helper.geomap()
  $scope.pie = chart_helper.pie()

  $scope.cats = [
    {name: 'timerange.week'},
    {name: 'timerange.month'},
    {name: 'timerange.year'}
  ]
