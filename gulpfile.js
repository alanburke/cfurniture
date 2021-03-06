var gulp = require('gulp');
    sourcemaps = require('gulp-sourcemaps'),
    sass = require('gulp-sass'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css'),
    livereload = require('gulp-livereload'),
    shell = require('gulp-shell');
    rev    = require('gulp-rev');
    revreplace    = require('gulp-rev-replace');
    critical = require('critical');
    uncss = require('gulp-uncss');



// BrowserSync isn"t a gulp package, and needs to be loaded manually
var browserSync = require("browser-sync");
// Need a command for reloading webpages using BrowserSync
var reload = browserSync.reload;

var config = {
    bootstrapDir: './node_modules/bootstrap-sass',
};

gulp.task('styles', function() {
  return gulp.src('app/sass/*.scss')
    .pipe(sass({
      includePaths: [config.bootstrapDir + '/assets/stylesheets'],
     }))
    .pipe(autoprefixer({browsers: ['last 2 versions', 'ie 8', 'ie 9']}))
//    .pipe(uncss({html: ['dist/**/*.html'], ignoreSheets: [ 'colorbox.css'] }))
//    .pipe(minifycss())
    .pipe(gulp.dest('dist/css'));
});

gulp.task('styles:dev', function() {
  return gulp.src('app/sass/*.scss')
    .pipe(sourcemaps.init())
    .pipe(sass({
      includePaths: [config.bootstrapDir + '/assets/stylesheets'],
     }))
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('dev/css'))
    // Injects the CSS changes to your browser since Jekyll doesn"t rebuild the CSS
    .pipe(reload({stream: true}));
});

// This is failing due to bug in Phantomjs
gulp.task('critical', ['styles'], function () {
    critical.generateInline({
        base: 'dist/',
        src: 'index.html',
        styleTarget: 'css/style.css',
        htmlTarget: 'index.html',
        width: 320,
        height: 480,
        minify: true
    });
});

gulp.task("jekyll", shell.task("bundle exec jekyll build"));
gulp.task("jekyll:dev", shell.task("bundle exec jekyll build -s app -d dev"));
gulp.task("jekyll:rebuild", ["jekyll:dev"], function () {
  reload;
});

gulp.task('watch', function() {

  // Watch .scss files
  gulp.watch(['app/sass/**/*.scss', 'app/images/**/*'], ['styles:dev']);

  // Watch Jekyll files
  gulp.watch(['app/**/*.md', 'app/**/*.html', 'app/**/*.yml', 'app/**/*.txt', 'app/**/*.js', 'app/**/*.geosjon' ,'app/images/**/*'], ['jekyll:rebuild']);

  gulp.watch("dev/*.html").on('change', reload);

});

// BrowserSync will serve our site on a local server for us and other devices to use
// It will also autoreload across all devices as well as keep the viewport synchronized
// between them.
gulp.task("serve:dev", ["styles:dev", "jekyll:rebuild"], function () {
  browserSync({
    notify: true,
    open: false,
    tunnel: false,
    server: {
      baseDir: "dev"
    }
  });
});


gulp.task('revision', function () {
    // by default, gulp would pick `assets/css` as the base,
    // so we need to set it explicitly:
    return gulp.src(['dist/css/*.css', 'dist/js/*.js'], {base: 'dist'})
        .pipe(gulp.dest('dist'))
        .pipe(rev())
        .pipe(gulp.dest('dist'))
        .pipe(rev.manifest())
        .pipe(gulp.dest('dist'));
});

gulp.task("revreplace", ["revision"],  function(){
  var manifest = gulp.src("dist/rev-manifest.json");

  return gulp.src("dist" + "/**/*.html")
    .pipe(revreplace({manifest: manifest}))
    .pipe(gulp.dest("dist"));
});

gulp.task("default", ["serve:dev", "watch"]);
