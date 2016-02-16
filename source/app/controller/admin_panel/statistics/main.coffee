angular.module("app").controller "statistics_ctrl",  ($scope, $timeout) ->



  $scope.colors = ['#F44336', '#3F51B5', '#009688', '#FF9800']


  $timeout () ->
    $scope.data_cpu = {
      labels: ['10:00', '12:00', '14:00', '16:00', '18:00'],
      series: [
        [17, 25, 10, 55, 11, 44]
      ],
    };
    $scope.data_profiles = {
      labels: ['15.02', '15.02', '15.02', '15.02', '15.02'],
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

  $scope.date_range = {
    from: new Date('2/1/2016'),
    to: new Date('2/17/2016')
  }

  $scope.traffic = [
    {label: "Google", value: 55.3},
    {label: "Direct", value: 18.3},
    {label: "Yandex", value: 17.5},
    {label: "Social networks", value: 8.9}
  ]

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


  $scope.profilesOptions = {
    height: "200px"
    width: "100%",
    lineSmooth: Chartist.Interpolation.cardinal({
      tension: 1
    })
    showPoint: false,
    low: 0
    chartPadding: {
      top: 15,
      right: 25,
      bottom: 5,
      left: 10
    },
    showArea: false,
    showPoint: true,
    showLine: true,
    fullWidth: false,
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
      showLabel: true
    }
    classNames: {
      line: 'ext_chart-ct-line',
      grid: 'ext_chart-ct-grid',
      point: 'ext_chart-ct-point',
    }

  };




  $scope.cpuOptions = {
    width: "100%",
    height: "240px",
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
    chartPadding: {
      top: 55,
      right: 20,
      bottom: 20,
      left: 10
    },
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
