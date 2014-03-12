module.exports = (grunt) ->
	grunt.initConfig

		coffee:
			build:
				options:
					bare: true
					sourceMap: true
				expand: true
				cwd: 'src/'
				src: [ '**/*.coffee' ]
				dest: 'lib/'
				ext: '.js'
		express:
			options: {}
			dev:
				options:
					script: 'lib/startup.js'
			prod:
				options:
					script: 'lib/startup.js',
					node_env: 'production'
			test:
				options:
					script: 'path/to/test/server.js'

		watch:
			express:
				files:  [ '**/*.js' ]
				tasks:  [ 'coffee:build', 'express:dev' ]
				options:
					spawn: false # for grunt-contrib-watch v0.5.0+, "nospawn: true" for lower versions. Without this option specified express won't be reloaded

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-express-server'
	grunt.loadNpmTasks 'grunt-contrib-watch'

	grunt.registerTask 'default', ['coffee:build' ]
	grunt.registerTask 'dev', ['coffee:build', 'express:dev', 'watch']

