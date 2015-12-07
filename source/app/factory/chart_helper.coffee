angular.module('app').factory 'chart_helper',  () ->

  result = {
    geomap: () ->
      obj = {}
      obj.type = "GeoChart"
      obj.data = [
        ['Locale','Visits'],
        ['United States', 100],
        ['Germany', 200]
      ];
      obj.options = {
        chartArea: {left:0,top: 0, width: '100%', height: '250px'},
        width: 'auto',
        height: '250px'
        title: 'Demographics'
        colorAxis: {colors: ['#aec7e8', '#1f77b4']},
        displayMode: 'regions',
        enableRegionInteractivity: true
      };

      return obj

    viewline: () ->
      obj = {}
      obj.data = {
        "cols": [
          {id: "t", label: "Topping", type: "string"},
          {id: "s", label: "View", type: "number"}
        ],
        "rows": [
          {c: [
              {v: '21.11'},
              {v: 150},
          ]},
          {c: [
              {v: '22.11'},
              {v: 200}
          ]},
          {c: [
              {v: '23.11'},
              {v: 170},
          ]},
          {c: [
              {v: '24.11'},
              {v: 150},
          ]},
          {c: [
              {v: '25.11'},
              {v: 140},
          ]},
          {c: [
              {v: '26.11'},
              {v: 180}
          ]}
        ]};


      obj.type = "LineChart";
      obj.options = {
        title: 'Views'
        chartArea: {left:35,top: 30, width: '100%', height: '250px'},
        vAxis: {
          minValue: 0,
          viewWindow: {
              min:0
          }
        }
        titleTextStyle: {color: '#414141', fontName: 'Roboto', fontSize: '14', bold: false},
        legend: {
          position: 'none';
        }
      };
      return obj





    heatline: () ->
      obj = {}
      obj.data = {
        "cols": [
          {id: "t", label: "Topping", type: "string"},
          {id: "s", label: "Percent", type: "number"}
        ],
        "rows": [
          {c: [
              {v: "0:0"},
              {v: 100},
          ]},
          {c: [
              {v: "0:10"},
              {v: 60}
          ]},
          {c: [
              {v: "0:20"},
              {v: 50},
          ]},
          {c: [
              {v: "0:30"},
              {v: 40},
          ]},
          {c: [
              {v: "0:40"},
              {v: 30},
          ]},
          {c: [
              {v: "0:50"},
              {v: 30}
          ]}
        ]};


      obj.type = "LineChart";
      obj.options = {
        title: 'HeatMap',
        chartArea: {left:35,top: 30, width: '100%', height: '250px'},
        vAxis: {
          minValue: 0,
          viewWindow: {
              min:0
          }
        }
        titleTextStyle: {color: '#414141', fontName: 'Roboto', fontSize: '14', bold: false},
        legend: {
          position: 'none';
        }
      };
      return obj




  }
  return result
