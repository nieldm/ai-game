var gulp = require('gulp')
  , gutil = require('gulp-util')
  , concat = require('gulp-concat')
  , rename = require('gulp-rename')
  , minifycss = require('gulp-minify-css')
  , minifyhtml = require('gulp-minify-html')
  , processhtml = require('gulp-processhtml')
  , jshint = require('gulp-jshint')
  , uglify = require('gulp-uglify')
  , connect = require('gulp-connect')
  , download = require('gulp-download')
  , coffee = require('gulp-coffee')
  , notify = require('gulp-notify')
  , paths;

paths = {
  assets: 'src/assets/**/*',
  css:    'src/css/*.css', 
  //js:     ['src/js/boot.js', '!src/js/lib/*.js'],
  js:     ['src/js/**/*.js', 'src/js/lib/*.js'],
  libs:   'src/js/lib/**/*.js',
  coffee: 'src/coffee/**/*.coffee',
  dist:   './dist/'
};


gulp.task('download', function () {
  // for the moment grab phaser from GitHub
  // as it seems the official version is not
  // in the Bower registry ... this should be
  // handled by Bower later on.
  download(['https://raw.github.com/photonstorm/phaser/master/build/phaser.js'])
  download(['http://requirejs.org/docs/release/2.1.11/minified/require.js'])
  download(['http://cdnjs.cloudflare.com/ajax/libs/mathjs/0.18.1/math.min.js'])
    .pipe(gulp.dest('src/js/lib/'));
});

gulp.task('copy', function () {
  gulp.src(paths.assets).pipe(gulp.dest(paths.dist + 'assets'));
});

// Handle CoffeeScript compilation
gulp.task('coffee', function () {
    return gulp.src(paths.coffee)
        .pipe(coffee({bare: true}).on('error', gutil.log))
        .pipe(gulp.dest('src/js/lib/hrdcdd'))
        .pipe(notify('Master your Coffee it\'s ready!'))
});

gulp.task('uglify', ['jshint'], function () {
  gulp.src(paths.js)
    .pipe(concat('main.min.js'))
    .pipe(gulp.dest(paths.dist))
    .pipe(uglify({outSourceMaps: false}))
    .pipe(gulp.dest(paths.dist));
});

gulp.task('minifycss', function () {
 gulp.src(paths.css)
    .pipe(minifycss({
      keepSpecialComments: false,
      removeEmpty: true
    }))
    .pipe(rename({suffix: '.min'}))
    .pipe(gulp.dest(paths.dist));
});

gulp.task('processhtml', function() {
  gulp.src('src/index.html')
    .pipe(processhtml('index.html'))
    .pipe(gulp.dest(paths.dist));
});

gulp.task('minifyhtml', function() {
  gulp.src('dist/index.html')
    .pipe(minifyhtml())
    .pipe(gulp.dest(paths.dist));
});

gulp.task('jshint', function() {
  gulp.src(paths.js)
    .pipe(jshint('.jshintrc'))
    .pipe(jshint.reporter('default'));
});

gulp.task('connect', connect.server({
  root: [__dirname + '/src'],
  port: 9000,
  livereload: true,
  //open: {
    //browser: 'Google Chrome' // if not working on OSX try: 'Google Chrome'
  //}
}));

gulp.task('watch', function () {
  gulp.watch(paths.coffee, ['coffee']);
  gulp.watch(paths.js, ['jshint']);
  gulp.watch(['./src/index.html', paths.css, paths.js], connect.reload);
});

gulp.task('default', ['connect', 'coffee', 'watch']);
gulp.task('build', ['copy', 'coffee', 'uglify', 'minifycss', 'processhtml', 'minifyhtml']);

