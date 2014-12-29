# -- DEPENDENCIES --------------------------------------------------------------

gulp         = require 'gulp'
gutil        = require 'gulp-util'
less         = require 'gulp-less'
concat       = require 'gulp-concat'
gutil        = require 'gulp-util'
header       = require 'gulp-header'
cssmin       = require 'gulp-cssmin'
pkg          = require './package.json'
livereload   = require 'gulp-livereload'
autoprefixer = require 'gulp-autoprefixer'

# -- FILES ---------------------------------------------------------------------

banner = [
  "/**"
  " * <%= pkg.name %> - <%= pkg.description %>"
  " * @version v<%= pkg.version %>"
  " * @link    <%= pkg.homepage %>"
  " * @author  <%= pkg.author.name %> (<%= pkg.author.url %>)"
  " * @license <%= pkg.license %>"
  " */"
  ""].join("\n")

gulp.task "normal", ->
  gulp.src 'less/__init.less'
    .pipe less().on("error", gutil.log)
    .pipe autoprefixer()
    .pipe concat 'borderless.css'
    .pipe header(banner, pkg: pkg)
    .pipe gulp.dest 'dist'
    .pipe livereload()
  return

gulp.task "minify", ->
  gulp.src 'less/__init.less'
    .pipe less().on("error", gutil.log)
    .pipe concat 'borderless.min.css'
    .pipe autoprefixer()
    .pipe cssmin()
    .pipe header(banner, pkg: pkg)
    .pipe gulp.dest 'dist'
    .pipe livereload()
  return

gulp.task "default", ->
  livereload.listen()
  gulp.start ["normal", "minify"]
  gulp.watch('less/*.less', ['normal', 'minify'])
