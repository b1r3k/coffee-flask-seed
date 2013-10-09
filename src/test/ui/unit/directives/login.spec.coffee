describe 'login', ->
  beforeEach module 'pascalprecht.translate'
  beforeEach module 'app.directives.templates'
  beforeEach module 'app.directives.login'

  beforeEach inject ($rootScope) ->
    @rootScope = $rootScope

  describe 'controller', ->
    beforeEach inject ($controller) ->
      @scope = @rootScope.$new()
      @loginCtrl = $controller('loginCtrl', $scope: @scope)

    it 'should hello world', ->
      expect(@scope.hello).toBe('world')

  describe 'directive', ->
    beforeEach inject ($document, $compile) ->
      @scope = @rootScope.$new()
      @document = $document
      @element = $compile('<wl-login-panel></wl-login-panel>')(@scope)
      @rootScope.$digest();

    it 'should display', ->
      expect(@element.find('button.login-button').length).toBe(1)