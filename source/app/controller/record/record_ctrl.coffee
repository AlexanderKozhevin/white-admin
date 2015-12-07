angular.module("app").controller "record_Ctrl",  ($scope, $state) ->

  $scope.record_id = $state.params.id
  $scope.tab =
    list: ['attr', 'stat', 'ads']
    current: 'attr'
    set: (name) ->
      this.current = name
  console.log 'record_Ctrl'
