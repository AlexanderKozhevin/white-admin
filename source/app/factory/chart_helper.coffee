angular.module('app').factory 'ChartConfig',  () ->

  result = {}

  result.options_main = {
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
      area: 'main_chart-ct-area',
      grid: 'main_chart-ct-grid',
    }
    plugins: [
      Chartist.plugins.tooltip({
        class: "element-tooltip",
        pointClass: 'main_chart-ct-point'
      })

    ]
  };

  result.options_profiles = {
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

  result.options_cpu = {
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




  return result
