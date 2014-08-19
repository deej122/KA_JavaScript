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
      $scope.body = {
        jsCode: $scope.jsCode
      }
      console.log $scope.jsCode
      console.log typeof $scope.jsCode
      $http.post(
        '/api/controller/parse', $scope.body
      ).success (parsed) ->
        console.log parsed
        $scope.parsedCode = parsed
        return
    console.log $scope.profile