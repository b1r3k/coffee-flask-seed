angular.module('services.auth', [])
.factory('authService', [->
    class Service
      hello: ->
        'world'
    return new Service
  ])