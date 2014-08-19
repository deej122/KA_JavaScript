'use strict'

angular.module('kajsApp', [
  'ngRoute'
])
  .config(($routeProvider, $locationProvider, $httpProvider) ->
    $locationProvider.html5Mode true
    $routeProvider
      .when '/',
        templateUrl: '/views/partials/main.html'
        controller: 'MainController'
  )
  .controller 'MainController', ($scope, $http) ->
    $scope.profile = false
    $scope.jsCode = null
    $scope.parseIt = ->
      console.log $scope.jsCode
      console.log typeof $scope.jsCode
      $http.post(
        '/api/controller/parse'
      ).success (parsed) ->
        console.log parsed
        return
    console.log $scope.profile