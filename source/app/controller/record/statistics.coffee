angular.module("app").controller "record_statistics_Ctrl",  ($scope, chart_helper, $translate) ->


  $scope.title.set('Record - statistics')
  $scope.tab.set('stat')

  $scope.heatmap = chart_helper.heatline()
  $scope.viewsmap = chart_helper.viewline()
  $scope.geomap = chart_helper.geomap()


  $scope.cats = [
    {name: 'timerange.week'},
    {name: 'timerange.month'},
    {name: 'timerange.year'}
  ]
