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
          'lib/**/*.js',
          'lib/**/*.css',
          'lib/**/*.html',
          'fixtures/index.html',
          'fixtures/index-dist.html'
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

    inline: 
      dev:
        src: ['fixtures/index.html']
        dest: ['index.html']

      build:
        src: ['fixtures/index-dist.html']
        dest: ['dist/index.html']


  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-inline'

  grunt.registerTask 'default', ->
    grunt.task.run [
      'connect'
      'clean:bin'
      'browserify'
      'less'
      'inline:dev'
      'copy:pages'
      'copy:lib'
      'watch'
    ]

  grunt.registerTask 'build', [
    'clean:dist'
    'inline:build'
    'copy:buildAssets'
    'browserify' 
    'less' 
    'uglify'
    'cssmin'
  ]

  grunt.registerTask 'clear', [
    'clean'
  ]
