'use strict'

angular.module('kajsApp', [
  'ngRoute',
  'ui.codemirror'
])
  .config(($routeProvider, $locationProvider, $httpProvider) ->
    $locationProvider.html5Mode true
    $routeProvider
      .when '/',
        templateUrl: '/views/partials/main.html'
        controller: 'MainController'
  )
  .controller 'MainController', ($scope, $http) ->

    $scope.editorOptions = {
      lineWrapping : true,
      lineNumbers: true,
      mode: 'javascript'
    };

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
        $scope.parsedCode = parsed
        console.log $scope.parsedCode.ast.body
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
              if $scope.needForInIf == true
                if declaration.consequent.body.length > 0
                  for nested_declaration in declaration.consequent.body
                    if nested_declaration.type == "ForStatement"
                      $scope.nestedForError = undefined
                      break
                    else 
                      $scope.nestedForError = "You must add a for loop within your if statement!"
                else
                  $scope.nestedForError = "You must add a for loop within your if statement!"
              if $scope.needWhileInIf == true
                if declaration.consequent.body.length > 0
                  for nested_declaration in declaration.consequent.body
                    if nested_declaration.type == "WhileStatement"
                      $scope.nestedWhileIfError = undefined
                      break
                    else
                      $scope.nestedWhileIfError = "You must add a while loop within your if statement!"
                else
                  $scope.nestedWhileIfError = "You must add a while loop within your if statement!"
              break
            else
              $scope.ifError = "You must use an if statement in your code!"

        if $scope.needFor == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "ForStatement"
              $scope.forError = undefined
              if $scope.needIfInFor == true
                if declaration.body.body.length > 0
                  for nested_declaration in declaration.body.body
                    if nested_declaration.type == "IfStatement"
                      $scope.nestedIfError = undefined
                      break
                    else 
                      $scope.nestedIfError = "You must add an if statement within your for loop!"
                else
                  $scope.nestedIfError = "You must add an if statement within your for loop!"
              if $scope.needWhileInFor == true
                if declaration.body.body.length > 0
                  for nested_declaration in declaration.body.body
                    if nested_declaration.type == "WhileStatement"
                      $scope.nestedWhileForError = undefined
                      break
                    else
                      $scope.nestedWhileForError = "You must add a while loop within your for loop!"
                else
                  $scope.nestedWhileForError = "You must add a while loop within your for loop!"
              break
            else
              $scope.forError = "You must use a for loop in your code!"

        if $scope.needWhile == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "WhileStatement"
              $scope.whileError = undefined
              if $scope.needIfInWhile == true
                if declaration.body.body.length > 0
                  for nested_declaration in declaration.body.body
                    if nested_declaration.type == "IfStatement"
                      $scope.nestedIfError = undefined
                      break
                    else 
                      $scope.nestedIfError = "You must add an if statement within your while loop!"
                else
                  $scope.nestedIfError = "You must add an if statement within your while loop!"
              if $scope.needForInWhile == true
                if declaration.body.body.length > 0
                  for nested_declaration in declaration.body.body
                    if nested_declaration.type == "ForStatement"
                      $scope.nestedForWhileError = undefined
                      break
                    else
                      $scope.nestedForWhileError = "You must add a for loop within your while loop!"
                else
                  $scope.nestedForWhileError = "You must add a for loop within your while loop!"
              break
            else
              $scope.whileError = "You must use a while loop in your code!"

        if $scope.noVariable == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "VariableDeclaration"
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

        if $scope.noWhile == true
          for declaration in $scope.parsedCode.ast.body
            if declaration.type == "WhileStatement"
              $scope.whileError = "You must not use a while loop in your code!"
              break
            else
              $scope.whileError = undefined

        if $scope.variableError == undefined && $scope.ifError == undefined && $scope.forError == undefined && $scope.whileError == undefined && $scope.nestedForError == undefined && $scope.nestedWhileIfError == undefined && $scope.nestedIfError == undefined && $scope.nestedWhileForError == undefined && $scope.nestedIfWhileError == undefined && $scope.nestedForWhileError == undefined
          $scope.successMessage = "You've successfully met all specifications for this example. You should still check your code for syntax errors, but good work!"
        else $scope.successMessage = undefined
          # else if $scope.body.jsCode == null
          #   $scope.variableError = null
          #   $scope.ifError = null
          #   $scope.forError = null
        return