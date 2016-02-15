angular.module("app").controller "statistics_ctrl",  ($scope, $timeout) ->



  $scope.colors = ['#F44336', '#3F51B5', '#009688', '#FF9800']


  $timeout () ->
    $scope.data_cpu = {
      labels: ['10:00', '12:00', '14:00', '16:00', '18:00'],
      series: [
        [17, 25, 10, 55, 11, 44]
      ],
    };
  , 100
  $scope.data = {
    labels: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
    series: [
      [{value: 7, meta: 'line1'}, {value: 15, meta: 'line1'}, {value: 167, meta: 'line1'}, {value: 18, meta: 'line1'}, {value: 199, meta: 'line1'}, {value: 150, meta: 'line1'} ]
    ],
  };



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
      label: 'md-caption main_chart-ct-label',
      line: 'main_chart-ct-line',
      point: 'main_chart-ct-point',
      area: 'main_chart-ct-area',
      grid: 'main_chart-ct-grid',
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
      line: 'cpu_chart-ct-line',
      grid: 'cpu_chart-grid',
      point: 'cpu_chart-ct-point',
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
          class: 'main_chart-ct-point',
          style: style
          }, 'ct-area');
        data.element.replace(point);
