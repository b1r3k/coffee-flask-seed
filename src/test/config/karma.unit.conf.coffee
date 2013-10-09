module.exports = (config) ->
  config.set(
    basePath: '../..'
    files: [
      'test/libs/jquery-2.0.3/jquery.js',
      'test/libs/angular-1.0.8/angular.js',
      'test/libs/angular-1.0.8/angular-mocks.js',
      'main/static/libs/angular-translate/angular-translate.js',
      'main/static/libs/angular-translate/angular-translate-loader-static-files.js',
      'main/static/libs/ui-bootstrap/ui-bootstrap-tpls-0.6.0-SNAPSHOT.js',
      'main/static/directives/**/*.coffee',
      'main/static/directives/**/*.tpl.html',
      'main/static/services/**/*.coffee',
      'test/ui/unit/**/*.spec.coffee'
    ]
    frameworks: ['jasmine']
    preprocessors:
      'main/static/directives/**/*.tpl.html': ['ng-html2js']
      '**/*.coffee': ['coffee']
    ngHtml2JsPreprocessor:
      stripPrefix: 'main/'
      moduleName: 'app.directives.templates'
    coffeePreprocessor:
      options:
        bare: true
        sourceMap: true
    autoWatch: true
    browsers: ['ChromeCanary']
  )