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
      assets: ['bin/assets']

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
          'lib/**/*.coffee',
          'lib/**/*.less',
          'index.html',
          'index-dev.html'
        ]
        tasks: ['browserify', 'less']

    copy:
      pages:
        expand: true
        cwd: 'src/pages'
        src: ['**/*.jpg', '**/*.png', '**/*.gif']
        dest: 'bin/assets/pages'

      lib:
        expand: true
        cwd: 'lib'
        src: ['**/*.jpg', '**/*.png', '**/*.gif']
        dest: 'bin/assets/lib'

      buildAssets:
        expand: true
        cwd: 'bin/assets'
        src: ['**/*.jpg', '**/*.png', '**/*.gif']
        dest: 'dist/assets'

      buildHtml:
        files:
          'dist/index.html': ['_index-dist.html']

    less:    
      dev:
        files:
          'bin/css/style.css': ['src/**/*.less']

    uglify:
      build:
        files:
          'dist/js/main.min.js': ['lib/bundle.min.js', 'lib/core/LA.min.js', 'bin/js/main.js']

    cssmin:    
      build:
        files:
          'dist/css/style.min.css': ['bin/css/style.css', 'lib/core/LA.min.css']

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
      'copy:pages'
      'copy:lib'
      'watch'
    ]

  grunt.registerTask 'assets', ->
    grunt.task.run [
      'clean:assets'
      'copy:pages'
      'copy:lib'
    ]

  grunt.registerTask 'build', [
    'clean:bin'
    'clean:dist'
    'copy:buildAssets'
    'copy:buildHtml'
    'browserify' 
    'less' 
    'uglify'
    'cssmin'
  ]

  grunt.registerTask 'clear', [
    'clean'
  ]
