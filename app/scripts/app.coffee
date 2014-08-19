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
        console.log parsed.ast.body
        $scope.parsedCode = parsed
        for declaration in $scope.parsedCode.ast.body
          if $scope.needVariable == true
            if declaration.type == "VariableDeclaration"
              $scope.variableError = null
              break
            else
              $scope.variableError = "You must declare a variable in your code!"

          else if $scope.needIf == true
            if declaration.type == "IfStatement"
              $scope.ifError = null
              break
            else
              $scope.ifError = "You must use an if statement in your code!"

          else if $scope.needFor == true
            if declaration.type == "ForStatement"
              $scope.forError = null
              break
            else
              $scope.forError = "You must use a for loop in your code!"


          else if $scope.noVariable == true
            if declaration.type == "VariableDeclaration"
              $scope.variableError = "You must not declare any variables in your code!"
            else
              $scope.variableError = null
              break

          else if $scope.noIf == true
            if declaration.type == "IfStatement"
              $scope.ifError = "You must not use an if statement in your code!"
            else
              $scope.ifError = null
              break

          else if $scope.noFor == true
            if declaration.type == "ForStatement"
              $scope.forError = "You must not use a for loop in your code!"
            else
              $scope.forError = null
              break

          # else if $scope.body.jsCode == null
          #   $scope.variableError = null
          #   $scope.ifError = null
          #   $scope.forError = null
        return