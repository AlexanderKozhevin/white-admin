angular.module("app").controller "StatisticsCtrl",  ($scope, $timeout, Restangular, $filter, ChartConfig, $interval) ->

  console.log 'stat'

  Date.prototype.subDays = (days) ->
    dat = new Date(this.valueOf())
    dat.setDate(dat.getDate() - days);
    return dat;

  $scope.blocks =
    workers: 0
    jobs: 0
    bids: 0

  $scope.charts_options =
    main: ChartConfig.options_main

  $scope.charts_data =
    main: undefined
    no_data: false

  $scope.date_range =
    from: (new Date()).subDays(14)
    to:  new Date()

  $scope.request =
    block: () ->
      Restangular.one('stat', 'general').get().then (data) ->
        $scope.blocks = data
    main: () ->
      $scope.charts_data.main = false
      $scope.charts_data.no_data = false
      from = $filter('date')($scope.date_range.from, 'yyyy-M-d')
      to = $filter('date')($scope.date_range.to, 'yyyy-M-d')
      Restangular.one('stat', 'period').get({from: from, to: to}).then (data) ->
        if data.data.series.length
          series = _.map(data.data.series, (obj) -> return $filter('date')(obj, 'd/M'))
          values = []

          for i in data.data.series
            values.push data.data.values.landing[i]

          series.pop()
          $scope.charts_data.main =
            labels: series
            series: [
              values
            ]

        else
          $scope.charts_data.no_data = true


  $scope.request.main()
  $scope.request.block()
  # stat = Restangular.one('stat')
  #
  # $scope.socket_data =
  #   cpu: 43
  #   ram: 22
  #
  #
  #
  # # A thing to emulate sockets
  # # $interval () ->
  # #   $scope.socket_data.cpu = Math.round(Math.random()*100)
  # #   $scope.socket_data.ram = Math.round(Math.random()*100)
  # # , 1000
  #
  #
  #
  # io.socket.on 'message',  (data)->
  #   $scope.socket_data.cpu =  Math.round(data.cpu*100)
  #   $scope.socket_data.ram = 100-Math.round(data.memory*100)
  #
  # io.socket.on 'connect',  (data)->
  #   console.log 'connect yo'
  #   io.socket.get('/api/server/subscribe');
  #
  #
  #
  # $scope.charts_data =
  #   main: undefined
  #   cpu: undefined
  #   profiles: undefined
  #
  #

  #
  #
  # $scope.date_range =
  #   from: new Date('2/9/2016'),
  #   to: new Date('2/17/2016'),
  #   today: new Date()
  #
  #
  # $scope.request =
  #   cpu: () ->
  #     $scope.charts_data.cpu = undefined
  #     stat.one('cpu_data').get().then (data) ->
  #       labels = _.map(data, (obj) -> return $filter('date')(new Date(obj.label), 'HH:mm'))
  #       values = _.map(data, (obj) -> return {value: obj.value, meta: 'Load %'})
  #       labels.pop()
  #       $scope.charts_data.cpu =
  #         labels: labels
  #         series: [
  #           values
  #         ],
  #
  #   ext: () ->
  #     $scope.charts_data.profiles = undefined
  #     stat.one('external_views').get().then (data) ->
  #       labels = _.map(data, (obj) -> return $filter('date')(new Date(obj.label), 'd/M'))
  #       values = _.map(data, (obj) -> return {value: obj.value, meta: 'Views'})
  #       labels.pop()
  #       $scope.charts_data.profiles =
  #         labels: labels
  #         series: [
  #           values
  #         ]
  #
  #   main: () ->
  #     $scope.charts_data.main = undefined
  #     stat.one('mainsite').get({from: $scope.date_range.from, to: $scope.date_range.to}).then (data) ->
  #       labels = _.map(data, (obj) -> return $filter('date')(new Date(obj.label), 'd/M'))
  #       values = _.map(data, (obj) -> return {value: obj.value, meta: 'Views'})
  #       temp = []
  #       if labels.length
  #         pace = Math.round(labels.length / 20)
  #         if pace >= 2
  #           for i,index in labels
  #             if index % pace != 0
  #               labels[index] = ""
  #         labels.pop()
  #       $timeout () ->
  #         $scope.charts_data.main =
  #           labels: labels
  #           series: [
  #             values
  #           ]
  #       , 1500
  #
  # $scope.traffic = [
  #   {label: "Google", value: 55.3},
  #   {label: "Direct", value: 18.3},
  #   {label: "Yandex", value: 17.5},
  #   {label: "Social networks", value: 8.9}
  # ]
  #
  #
  $scope.events =
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
  #
  #
  # $scope.request.main()
  # $scope.request.ext()
  # $scope.request.cpu()
