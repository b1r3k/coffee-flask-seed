module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean:
      dist: '<%= pkg.dist %>'

    coffeelint:
      app: '<%= pkg.src %>/static/**/*.coffee'
      grunt: 'Gruntfile.coffee'
      options:
        max_line_length:
          value: 120
          level: 'error'
        no_trailing_whitespace:
          level: 'error'
        no_tabs:
          level: 'error'
        indentation:
          value: 2
          level: 'error'

    coffee:
      app:
        files:
          '<%= pkg.dist %>/static/app.js': [
            '<%= pkg.src %>/static/app.coffee',
            '<%= pkg.src %>/static/**/*.coffee',
            '!<%= pkg.src %>/static/templates.coffee'
          ]
      options:
        bare: true
        preserve_dirs: true
        base_path: '<%= pkg.src %>/static'

    concat:
      options:
        separator: ';\n'
      js:
        src: [
          '<%= pkg.src %>/static/libs/angular-translate/angular-translate.js',
          '<%= pkg.src %>/static/libs/angular-translate/angular-translate-loader-static-files.js',
          '<%= pkg.src %>/static/libs/**/*.js',
          '!<%= pkg.src %>/static/libs/less/**',
          '!<%= pkg.src %>/static/libs/coffeescript/**'
        ]
        dest: '<%= pkg.dist %>/static/libs.js'
      css:
        src: [
          '<%= pkg.src %>/static/libs/**/*.css',
          '!<%= pkg.src %>/static/libs/less/**',
          '!<%= pkg.src %>/static/libs/coffeescript/**'
        ]
        dest: '<%= pkg.dist %>/static/libs.css'

    copy:
      jinja:
        files: [
          expand: true, cwd: '<%= pkg.src %>', src: '**/*.jinja2', dest: '<%= pkg.dist %>'
        ]
      python:
        files: [
          expand: true, cwd: '<%= pkg.src %>', src: '**/*.py', dest: '<%= pkg.dist %>'
        ]
      locales:
        files: [
          expand: true, cwd: '<%= pkg.src %>', src: 'static/languages/*.json', dest: '<%= pkg.dist %>'
        ]

    html2js:
      options:
        module: 'app.templates'
        base: '<%= pkg.src %>'
      templates:
        src: ['<%= pkg.src %>/**/*.tpl.html']
        dest: '<%= pkg.dist %>/static/templates.js'

    less:
      app:
        files:
          '<%= pkg.dist %>/static/app.css': ['<%= pkg.src %>/static/**/*.less']

    karma:
      unit:
        configFile: '<%= pkg.test %>/config/karma.unit.conf.coffee'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-html2js'
  grunt.loadNpmTasks 'grunt-karma'

  grunt.registerTask 'default', ['clean', 'coffeelint', 'coffee', 'html2js', 'concat', 'less', 'copy']
  grunt.registerTask 'heroku', ['default']