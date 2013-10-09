angular.element(document).ready(->
  angular.module('app', ['ui.bootstrap', 'pascalprecht.translate', 'app.templates', 'app.directives'])
  .config(['$routeProvider', ($routeProvider) ->
      $routeProvider.otherwise redirectTo: '/', templateUrl: 'partials/dashboard.tpl.html'
    ])
  .config(['$locationProvider', ($locationProvider) ->
      $locationProvider.html5Mode(true).hashPrefix('!')
    ])
  .config(['$translateProvider', ($translateProvider) ->
      $translateProvider.useStaticFilesLoader(
        prefix: '/static/languages/'
        suffix: '.json'
      )
      # $translateProvider.useLocalStorage()
      $translateProvider.preferredLanguage('pl_PL')
    ])
  .value('$anchorScroll', angular.noop)# fix for scrolling up on state change
  .controller('AppCtrl', ['$scope', '$http', ($scope, $http) ->
      $scope.hello = 'world'
    ])

  angular.bootstrap(document, ['app'])
)