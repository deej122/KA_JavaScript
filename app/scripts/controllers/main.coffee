'use strict'
angular.module('MainCtrl', [])
  .controller 'MainController', ($scope) ->
    $scope.profile = false
    console.log $scope.profile
   	return