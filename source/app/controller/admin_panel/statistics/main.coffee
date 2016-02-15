angular.module("app").controller "statistics_ctrl",  ($scope) ->

    # $scope.data = {
    #   labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
    #   series: [
    #     [{value: 7, meta: 'line1'}, {value: 15, meta: 'line1'}, {value: 167, meta: 'line1'}, {value: 18, meta: 'line1'}, {value: 199, meta: 'line1'}, {value: 150, meta: 'line1'} ]
    #     [{value: 1, meta: 'line2'}, {value: 25, meta: 'line2'}, {value: 137, meta: 'line2'}, {value: 22, meta: 'line2'}, {value: 19, meta: 'line2'}, {value: 10, meta: 'line2'} ]
    #   ],
    # };

  $scope.data_cpu = {
    labels: ['10:00', '12:00', '14:00', '16:00', '18:00'],
    series: [
      [{value: 25, meta: 'line2'}, {value: 15, meta: 'line2'}, {value: 67, meta: 'line2'}, {value: 18, meta: 'line2'}, {value: 199, meta: 'line2'} ]
    ],
  };

  $scope.data = {
    labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
    series: [
      [{value: 7, meta: 'line1'}, {value: 15, meta: 'line1'}, {value: 167, meta: 'line1'}, {value: 18, meta: 'line1'}, {value: 199, meta: 'line1'}, {value: 150, meta: 'line1'} ]
    ],
  };

  $scope.colors = ['#F44336', '#3F51B5', '#009688', '#FF9800']
  $scope.lineOptions = {
    height: "350px"
    width: "900px"
    lineSmooth: Chartist.Interpolation.cardinal({
      tension: 1
    })
    showPoint: false,
    low: 0
    chartPadding: 30,
    showArea: true,
    showPoint: true,
    showLine: true,
    onlyInteger: true,
    # fullWidth: true,
    axisX: {
      showGrid: false,
      labelOffset: {
        x: 0,
        y: 10
      },
    }
    axisY: {
      offset: 40,
      showGrid: true,
    }
    classNames: {
      # chart: 'ct-chart-line',
      label: 'md-caption my-ct-label',
      # labelGroup: 'my-ct-labels',
      # series: 'my-ct-series',
      line: 'my-ct-line',
      point: 'my-ct-point',
      area: 'my-ct-area',
      grid: 'my-ct-grid',
      # gridGroup: 'ct-grids',
      # vertical: 'ct-vertical',
      # horizontal: 'ct-horizontal',
      # start: 'ct-start',
      # end: 'ct-end'
    }
    plugins: [
      Chartist.plugins.tooltip({
        class: "geniusz"
      })

    ]
  };


  $scope.cpuOptions = {
    height: "200px"
    lineSmooth: Chartist.Interpolation.cardinal({
      tension: 1
    })
    showPoint: false,
    low: 0
    chartPadding: 0,
    showArea: false,
    showPoint: true,
    showLine: true,
    onlyInteger: true,
    # fullWidth: true,
    axisX: {
      showGrid: true,
      showLabel: true
      labelOffset: {
        x: 0
        y: 10
      }
    }
    axisY: {
      showGrid: true,
      showLabel: false
    }
    classNames: {
      # chart: 'ct-chart-line',
      # label: 'md-caption my-ct-label',
      # labelGroup: 'my-ct-labels',
      # series: 'my-ct-series',
      line: 'my-ct-line',
      point: 'my-ct-point',
      # area: 'my-ct-area',
      grid: 'my-ct-grid2',
      # gridGroup: 'ct-grids',
      # vertical: 'ct-vertical',
      # horizontal: 'ct-horizontal',
      # start: 'ct-start',
      # end: 'ct-end'
    }

  };



  $scope.events =
    created: (data) ->
      console.log data
    draw: (data) ->
      if data.type == 'point'
        color = ""
        switch data.meta
          when 'line1' then color = $scope.colors[0]
          when 'line2' then color = $scope.colors[1]
        style = 'fill: ' + color + '!important; stroke: ' + color
        point = new Chartist.Svg('circle', {
          cx: [data.x],
          cy: [data.y],
          r: [5],
          class: 'my-ct-point',
          style: style
          }, 'ct-area');
        data.element.replace(point);

  $scope.events2 =
    created: (data) ->
      console.log data
    draw: (data) ->
      console.log 'hello'
