angular.module("app").controller "profile_ctrl",  ($scope) ->

  $scope.user =
    logo: "http://vignette2.wikia.nocookie.net/jimmyneutronboygenuisthefanon/images/3/34/Character_large_332x363_jimmy.jpg/revision/latest?cb=20120114162611"
    name: "Jimmy Neutron"
    job: "Genius"

  $scope.photos = [
    'https://thehacktoday.com/wp-content/uploads/2015/10/hacking-2.jpg',
    'http://cdns.nocamels.com/wp-content/uploads/2014/09/hacker-attack.jpg',
    'https://securitygladiators.com/wp-content/uploads/2015/05/know-how-hacked-what-to-do.jpg',
    'http://3.bp.blogspot.com/-qllvndzYpes/VZ5mlZ4rLxI/AAAAAAAAjeU/W_yymRKV2Ns/s1600/Hacking-Team-Flash-Zero-Day.jpg'
  ]
  console.log 'hello'
