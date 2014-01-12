module.exports = function(grunt) {
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),
		watch: {
			sass: {
				files: ['scss/*.{scss,sass}','scss/_partials/*.{scss,sass}'],
				tasks: ['sass:dist']
			},
		  coffee: {
		    files: ['assets/coffee/*.coffee'],
		    tasks: 'coffee'
		  },
			livereload: {
				files: ['*.html', '*.php', 'js/*.{js,json}', 'css/*.css','images/*.{png,jpg,jpeg,gif,webp,svg}'],
				options: {
					livereload: true
				}
			}
		},
		sass: {
			dist: {
				files: {
					'css/app.css': 'scss/app.scss'
				}
			}
		},
		coffee: {
			compile: {
				files: {
					// 'js/episodes.js': 'coffee/episodes.coffee'
				}
			}
		},
		imagemin: {
	    dynamic: {
        files: [{
          expand: true,
          cwd: 'images',
          src: ['**/*.{png,jpg,gif}'],
          dest: 'images'
        }]
	    }
		}
	});
	grunt.registerTask('default', ['sass:dist', 'coffee', 'imagemin', 'watch']);
	grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-imagemin');
	grunt.loadNpmTasks('grunt-contrib-watch');
};