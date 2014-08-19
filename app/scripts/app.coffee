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
                containsVariable = true
                $scope.variableError = null
              else
                containsVariable = false
                $scope.variableError = "You must declare a variable in your code!"
                
            else if $scope.needIf == true
              if declaration.type = "IfStatement"
                containsIf = true
                $scope.ifError = null
              else
                containsIf = false
                $scope.ifError = "You must use an if statement in your code!"

            else if $scope.needFor == true
              if declaration.type = "ForStatement"
                containsFor = true
                $scope.forError = null
              else
                containsFor = false
                $scope.forError = "You must use a for loop in your code!"


            if $scope.noVariable == true
              if declaration.type == "VariableDeclaration"
                containsVariable = true
                $scope.variableError = "You must not declare any variables in your code!"
              else
                containsVariable = false
                $scope.variableError = null

            else if $scope.noIf == true
              if declaration.type = "IfStatement"
                containsIf = true
                $scope.ifError = "You must not use an if statement in your code!"
              else
                containsIf = false
                $scope.ifError = null

            else if $scope.noFor == true
              if declaration.type = "ForStatement"
                containsFor = true
                $scope.forError = null
              else
                containsFor = false
                $scope.forError = null
        return