angular.module("app").controller "record_attributes_Ctrl",  ($scope) ->


  $scope.title.set('Record - attributes')
  $scope.tab.set('attr')

  $scope.fruitNames = []
  $scope.cats = [
    {name: 'Films'},
    {name: 'DIY'},
    {name: 'Coding'},
    {name: 'Design'}
  ]

  console.log 'record_attributes_Ctrl'
