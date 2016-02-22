angular.module("app").controller "statistics_ctrl",  ($scope, $timeout, Restangular, $filter, $websocket, chart_helper) ->



  $scope.charts_data =
    main: undefined
    cpu: undefined
    profiles: undefined

  io.sails.url = 'http://arduino2.club';
  io.socket.on 'message',  (data)->
    console.log data

  io.socket.on 'connect',  (data)->
    io.socket.get('/api/server/subscribe');


  $scope.date_range = {
    from: new Date('2/9/2016'),
    to: new Date('2/17/2016'),
    today: new Date()
  }

  $scope.request_main = () ->
    $scope.charts_data.main = undefined
    Restangular.one('stat', 'mainsite').get({from: $scope.date_range.from, to: $scope.date_range.to}).then (data) ->
      labels = _.map(data, (obj) -> return $filter('date')(new Date(obj.label), 'd/M'))
      values = _.map(data, (obj) -> return {value: obj.value, meta: 'Views'})
      temp = []
      if labels.length
        pace = Math.round(labels.length / 20)
        if pace >= 2
          for i,index in labels
            if index % pace != 0
              labels[index] = ""
        labels.pop()
      $scope.charts_data.main =
        labels: labels
        series: [
          values
        ]


  $scope.request_external = () ->
    $scope.charts_data.profiles = undefined
    Restangular.one('stat', 'external_views').get().then (data) ->
      labels = _.map(data, (obj) -> return $filter('date')(new Date(obj.label), 'd/M'))
      values = _.map(data, (obj) -> return {value: obj.value, meta: 'Views'})
      labels.pop()
      $scope.charts_data.profiles =
        labels: labels
        series: [
          values
        ],
      

  $scope.request_cpu = () ->
    $scope.charts_data.cpu = undefined
    Restangular.one('stat', 'cpu_data').get().then (data) ->
      labels = _.map(data, (obj) -> return $filter('date')(new Date(obj.label), 'HH:mm'))
      values = _.map(data, (obj) -> return {value: obj.value, meta: 'Load %'})
      labels.pop()
      $scope.charts_data.cpu =
        labels: labels
        series: [
          values
        ],


  $scope.traffic = [
    {label: "Google", value: 55.3},
    {label: "Direct", value: 18.3},
    {label: "Yandex", value: 17.5},
    {label: "Social networks", value: 8.9}
  ]

  $scope.options =
    main: chart_helper.options_main
    profiles: chart_helper.options_profiles
    cpu: chart_helper.options_cpu



  $scope.events =
    created: (data) ->
      console.log data
    draw: (data) ->
      if data.type == 'point'
        circle_width = 4
        if $scope.charts_data.main.series[0].length > 25
          circle_width = 2
        point = new Chartist.Svg('circle', {
          cx: [data.x],
          cy: [data.y],
          r: [circle_width],
          'ct:value': data.value.y,
          'ct:meta': data.meta,
          class: 'main_chart-ct-point',
          }, 'ct-area');
        data.element.replace(point);




  $scope.request_main()
  $scope.request_external()
  $scope.request_cpu()
