casper.test.begin('Home page', 1, function suite(test) {
  casper.start("./dist/index.html", function() {
    test.assertExists("a.logo", "We found a logo");
  });

  casper.run(function() {
    test.done();
  });
});
