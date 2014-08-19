'use strict'

angular.module('kajsApp', [
  'ngRoute',
  'MainCtrl'
])
  .config(($routeProvider, $locationProvider, $httpProvider) ->
    $locationProvider.html5Mode true
    $routeProvider
      .when '/',
        templateUrl: '/partials/main.html'
        controller: 'MainCtrl'
      .otherwise redirectTo: '/'
  )
