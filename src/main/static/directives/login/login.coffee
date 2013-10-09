angular.module('app.directives.login', ['services.auth', 'pascalprecht.translate'])
.constant('loginConstans',
    panelTpl: 'static/directives/login/panel.tpl.html'
  )
.controller('loginCtrl', ['$scope', 'authService', ($scope, authService) ->
      $scope.hello = authService.hello()
  ])
.directive('wlLoginPanel', [ 'loginConstans', (loginConstans) ->
    restrict: 'AE'
    templateUrl: loginConstans.panelTpl
    replace: true
  ])