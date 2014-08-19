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
        if $scope.needVariable == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "VariableDeclaration"
              $scope.variableError = undefined
              break
            else
              $scope.variableError = "You must declare a variable in your code!"

        if $scope.needIf == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "IfStatement"
              $scope.ifError = undefined
              break
            else
              $scope.ifError = "You must use an if statement in your code!"

        if $scope.needFor == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "ForStatement"
              $scope.forError = undefined
              break
            else
              $scope.forError = "You must use a for loop in your code!"


        if $scope.noVariable == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "VariableDeclaration"
              console.log declaration.type == "VariableDeclaration"
              $scope.variableError = "You must not declare any variables in your code!"
              break
            else
              $scope.variableError = undefined

        if $scope.noIf == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "IfStatement"
              $scope.ifError = "You must not use an if statement in your code!"
              break
            else
              $scope.ifError = undefined

        if $scope.noFor == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "ForStatement"
              $scope.forError = "You must not use a for loop in your code!"
              break
            else
              $scope.forError = undefined

        if $scope.variableError == undefined && $scope.ifError == undefined && $scope.forError == undefined
          $scope.successMessage = "You've successfully met all specifications for this example. You should still check your code for syntax errors, but good work!"
        else $scope.successMessage = undefined
          # else if $scope.body.jsCode == null
          #   $scope.variableError = null
          #   $scope.ifError = null
          #   $scope.forError = null
        return