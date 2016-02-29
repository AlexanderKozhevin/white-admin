angular.module("app").controller "StatisticsCtrl",  ($scope, $timeout, Restangular, $filter, $websocket, ChartConfig, $interval) ->

  stat = Restangular.one('stat')

  $scope.socket_data =
    cpu: 43
    ram: 22



  # A thing to emulate sockets
  # $interval () ->
  #   $scope.socket_data.cpu = Math.round(Math.random()*100)
  #   $scope.socket_data.ram = Math.round(Math.random()*100)
  # , 1000



  io.socket.on 'message',  (data)->
    $scope.socket_data.cpu =  Math.round(data.cpu*100)
    $scope.socket_data.ram = 100-Math.round(data.memory*100)

  io.socket.on 'connect',  (data)->
    console.log 'connect yo'
    io.socket.get('/api/server/subscribe');



  $scope.charts_data =
    main: undefined
    cpu: undefined
    profiles: undefined


  $scope.charts_options =
    main: ChartConfig.options_main
    profiles: ChartConfig.options_profiles
    cpu: ChartConfig.options_cpu


  $scope.date_range =
    from: new Date('2/9/2016'),
    to: new Date('2/17/2016'),
    today: new Date()


  $scope.request =
    cpu: () ->
      $scope.charts_data.cpu = undefined
      stat.one('cpu_data').get().then (data) ->
        labels = _.map(data, (obj) -> return $filter('date')(new Date(obj.label), 'HH:mm'))
        values = _.map(data, (obj) -> return {value: obj.value, meta: 'Load %'})
        labels.pop()
        $scope.charts_data.cpu =
          labels: labels
          series: [
            values
          ],

    ext: () ->
      $scope.charts_data.profiles = undefined
      stat.one('external_views').get().then (data) ->
        labels = _.map(data, (obj) -> return $filter('date')(new Date(obj.label), 'd/M'))
        values = _.map(data, (obj) -> return {value: obj.value, meta: 'Views'})
        labels.pop()
        $scope.charts_data.profiles =
          labels: labels
          series: [
            values
          ]

    main: () ->
      $scope.charts_data.main = undefined
      stat.one('mainsite').get({from: $scope.date_range.from, to: $scope.date_range.to}).then (data) ->
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
        $timeout () ->
          $scope.charts_data.main =
            labels: labels
            series: [
              values
            ]
        , 1500

  $scope.traffic = [
    {label: "Google", value: 55.3},
    {label: "Direct", value: 18.3},
    {label: "Yandex", value: 17.5},
    {label: "Social networks", value: 8.9}
  ]


  $scope.events =
    created: (data) ->
      console.log data
    draw: (data) ->
      if data.type == 'point'
        circle_width = 4
        if $scope.charts_data.main
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


  $scope.request.main()
  $scope.request.ext()
  $scope.request.cpu()
