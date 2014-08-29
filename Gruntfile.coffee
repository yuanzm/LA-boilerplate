module.exports = (grunt)->

  coffeeify = require 'coffeeify'
  stringify = require 'stringify'

  grunt.initConfig
    connect:
      server:
        options:
          port: 3000
          base: '.'

    clean: 
      bin: ['bin']
      dist: ['dist']
      assets: ['assets']

    browserify: 
      dev: 
        options:
          preBundleCB: (b)->
            b.transform(coffeeify)
            b.transform(stringify({extensions: ['.hbs', '.html', '.tpl', '.txt']}))
        expand: true
        flatten: true
        src: ['src/main.coffee']
        dest: 'bin/js'
        ext: '.js'

    watch:
      compile:
        options:
          livereload: true
        files: [
          'test/**/*.coffee', 
          'src/**/*.coffee', 
          'src/**/*.less', 
          'src/**/*.html', 
          'index.html'
          'index-dev.html'
        ]
        tasks: ['browserify', 'less']

    copy:
      assets:
        expand: true
        cwd: 'src/pages'
        src: ['**/*.jpg', '**/*.png', '**/*.gif']
        dest: 'assets/pages'

    less:    
      dev:
        files:
          'bin/css/style.css': ['src/**/*.less']

    uglify:
      build:
        files:
          'dist/build.min.js': ['bin/js/main.js']

    cssmin:    
      build:
        files:
          'dist/style.min.css': ['bin/main.css']

  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'default', ->
    grunt.task.run [
      'connect'
      'clean:bin'
      'browserify'
      'less'
      'watch'
    ]

  grunt.registerTask 'assets', ->
    grunt.task.run [
      'clean:assets'
      'copy'
    ]

  grunt.registerTask 'build', [
    'clean:bin'
    'clean:dist'
    'browserify' 
    'less' 
    'uglify'
    'cssmin'
  ]
