angular.module("app").controller "profile_ctrl",  ($scope, $state, Restangular) ->

  if !$state.params.id
    $state.go('main')
  else
    Restangular.one('workers', $state.params.id).get().then (data) ->
      $scope.user = {
        name: data.name
        avatar: data.avatar
        params: []
      }
      Restangular.one('templates', data.job).get().then (job) ->
        $scope.user.job = job.name
        for i,index in job.params
          $scope.user.params[index] = {
            name: i.name
            value: data.values[i.id]
            type: i.type
            public: i.public
          }
          if i.type == 'select' or i.type == 'multiple select'
            $scope.user.params[index].values = i.values
          if i.type == 'date'
            $scope.user.params[index].value = new Date($scope.user.params[index].value)
        console.log $scope.user
    ,(error) ->
      $state.go('main')

  $scope.user =
    logo: "http://static.ddmcdn.com/gif/blogs/6a00d8341bf67c53ef014e8af06d1b970d-800wi.jpg"
    name: "Jimmy Neutron"
    job: "Genius"

  $scope.photos = [
    'https://thehacktoday.com/wp-content/uploads/2015/10/hacking-2.jpg',
    'http://cdns.nocamels.com/wp-content/uploads/2014/09/hacker-attack.jpg',
    'https://securitygladiators.com/wp-content/uploads/2015/05/know-how-hacked-what-to-do.jpg',
    'http://3.bp.blogspot.com/-qllvndzYpes/VZ5mlZ4rLxI/AAAAAAAAjeU/W_yymRKV2Ns/s1600/Hacking-Team-Flash-Zero-Day.jpg'
  ]


  console.log 'hello'
